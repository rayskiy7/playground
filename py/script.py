
def f():
    try:
        raise Exception("first")
    except Exception as e:
        raise Exception("other")

def g():
    try:
        f()
    except:
        raise Exception("from g")
    
g()