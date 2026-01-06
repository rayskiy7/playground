#include <iostream>
#include <thread>
#include <mutex>
#include <chrono>

using namespace std;
using namespace std::chrono;

class Message {
    string m;
    long ts;
public:
    Message(const string& s) :m{s} {}
    string getmessage(){
        return m;
    }
};

queue<Message> q;
condition_variable cond;
mutex mtx;

void consumer()
{
	while(true){
		unique_lock<mutex> lck{mtx};
		cond.wait(lck, []{ return !q.empty(); }); // release lock and wait signal, then reacquire
		auto m = q.front(); q.pop();
		lck.unlock();
		this_thread::sleep_for(milliseconds(700));
        cout << m.getmessage() << endl;
	}
}

void producer()
{
	while(true){
        string s;
        cin >> s;
		Message m{s};
		unique_lock<mutex> lck{mtx};
		q.push(m);
		cond.notify_one();
	}
}

int main(){
    thread cons{consumer}, prod{producer};
    cons.join();
    prod.join();
}