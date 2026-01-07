#include <iostream>
#include <thread>
#include <mutex>
#include <chrono>
#include <future>
#include <numeric>

using namespace std;
using namespace std::chrono;
double accum(double* beg, double* end, double init)
{
	return accumulate(beg, end, init);
}

double comp2(vector<double>& v)
{
	using Task_type = double(double*,double*,double);

	packaged_task<Task_type> pt0{accum};
	packaged_task<Task_type> pt1{accum};
	future<double> f0 {pt0.get_future()};
	future<double> f1 {pt1.get_future()};

	double* first = &v[0];
	thread t1 {move(pt0), first, first+v.size()/2, 0};
	thread t2 {move(pt1), first+v.size()/2, first+v.size(), 0};
	return f0.get() + f1.get();
}

double comp4(vector<double>& v, bool parallel)
{
	auto sz = v.size();
	auto v0 = &v[0], v1=v0+sz/4, v2=v0+sz/2, v3=v0+sz*3/4, v4=v0+sz;

    if (!parallel)
        return accumulate(v0, v4, 0.0);

	auto
		f0 = async(accum, v0, v1, 0.0),
		f1 = async(accum, v1, v2, 0.0),
		f2 = async(accum, v2, v3, 0.0),
		f3 = async(accum, v3, v4, 0.0);
	return f0.get()+f1.get()+f2.get()+f3.get();
}

void run(bool parallel){
    auto start = high_resolution_clock::now();
    vector<double> v(1000000000, 1);
    cout<<comp4(v, parallel)<<endl;
    auto end = high_resolution_clock::now();
    cout<<"elapsed time "<<(parallel?"(parallel): ":"(sequentily): ")<< duration_cast<milliseconds>(end-start).count()<<"ms\n";
}

int main(){
    run(true);
    run(false);
}