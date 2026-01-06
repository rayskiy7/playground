import math
import time
import importlib
import types


def rdir (a):
    return [attr for attr in dir(a) if not attr.startswith('__')]

def intersect(*args):
    res = []
    for el in args[0]:
        if el in res: continue
        for coll in args[1:]:
            if el not in coll:
                break
        else: res.append(el)
    return res

def union(*args):
    res = []
    for coll in args:
        for el in coll:
            if el not in res:
                res.append(el)
    return res

def primesto(a):
    if not isinstance(a, int):
        return None
    elif a<1:
        return []
    s = set(range(2,a+1))
    p = 2
    # -----------------------
    while p < len(s):
        if p in s:
            s -= set(range(2*p,a+1,p))
        p += 1
    # -----------------------
    return sorted(list(s))

def rbin (a):
    if not type(a) is int:
        raise TypeError
    l = (int(math.log(abs(a),2)) if a!=0 else 0)
    r = l//4+1+1 # 1 additional more
    mask = int('F'*r,16)
    a&=mask
    bins = '{0:0{1}b}'.format(a,r*4)
    res = ''
    for i in range(r):
        res+=bins[:4]+' '
        bins=bins[4:]
    return res[:-1]

def shuffed (coll):
     l = list(coll)
     G = (l[i:]+l[:i] for i in range(len(l)))
     return G

def myzip(*args):
    try:
        while 1:
            yield tuple(s.pop(0) for s in args)
    except:
        return

def TEST(func, *pargs,
         reps = 1000,
         runs = 20,
         allt = True,
         **kwargs) -> 'last func value':
    print ('TEST function [{}]'.format(func.__name__))
    t = time.perf_counter
    def total():
        n = range(reps)
        start = t()
        for i in n:
            res = func(*pargs, **kwargs)
        T = t() - start
        return (T, res)

    def bestof():
        best = 2**30
        for i in range(reps):
            start = t()
            func(*pargs, **kwargs)
            T = t() - start
            if T < best: best=T
        return best

    def bestofTotal():
        best = 2**30
        for i in range(runs):
            T = total()[0]
            if T < best: best=T
        return best
    (T, R), B, BOT = total(), bestof(), bestofTotal()
    if allt:
        print(('{:>12}: {:15.12f}\n'
              '{:>12}: {:15.12f}\n'
              '{:>12}: {:15.12f}').format('total',T,'best time',B,'bestof Total',BOT))
    else:
        print('{:>12}: {}'.format('bestof Total',BOT))
    return R


def isPrime(a):
    if type(a) is not int:
        return False
    if a<2: return False

    for m in range(2,int(math.sqrt(a))+1):
        if a%m == 0:
            print (f'{a} has factor {m}')
            return False
    return True

class inspector:
    def __init__(self, sep='-', sepn = 60):
        self.sep = sep
        self.sepn = sepn

    def __call__(self, obj):
        print(self.sep * self.sepn)
        print('inspecting object. name: {}. file: {}'.format(
            obj.__name__, obj.__file__))
        print(self.sep * self.sepn)

        counter = 0
        for k in obj.__dict__:
            counter+=1
            attr = str(getattr(obj,k))
            print('{:>03d}) {} {}'.format(
                counter, k, (attr[:50]+'...') if len(attr)>50 else attr))


import importlib
import types
def try_reload(module):
    try:
        print('reload module:',module.__name__)
        importlib.reload(module)
    except:
        print('FAILURE of reloading module',module)

# OLD VERSION reload_all(*)
'''
def reload_all(*modules):
    visited = set()
    def transit_reload(module):
        if module not in visited and module is not importlib:
            for m in module.__dict__.values():
                if type(m) == types.ModuleType:
                    transit_reload(m)
            print('reloading module', module.__name__)
            visited.add(module)
            try_reload(module)
    for module in modules:
        if type(module) == types.ModuleType:
            transit_reload(module)
'''
def reload_all(*modules):
    visited = set()
    for module in modules:
        if (type(module) == types.ModuleType
        and module not in visited
        and module is not importlib):
            reload_all(*module.__dict__.values())
            try_reload(module)
            visited.add(module)

def reloadall(*modules):
    modules = list(modules)
    visited = set()
    while modules:
        m = modules.pop()
        visited.add(m)
        modules.extend(x for x in m.__dict__.values()
                if type(x)==types.ModuleType
                and x not in visited
                and x is not importlib)
        try_reload(m)

class AttrDisplay:
    def __repr__(self):
        s = ', '.join('{}={}'.format(k,v) for k,v in
        sorted(self.__dict__.items(),key=lambda x:x[0]))
        return '[{} <{}>]'.format(self.__class__.__name__,s)

def classtree (obj):
    lines = []
    def recShow(cls, indent):
        lines.append('{} {}'.format('---'*indent,  cls.__name__))
        for c in cls.__bases__:
            recShow(c, indent+1)
    if type(obj)==type:
        recShow(obj,0)
    else:
        lines.append(str(obj))
        recShow(type(obj),1)
    for l in reversed(lines):
        print(l)

class ListInstance:
    def __getAttr (self, indent=' '*4):
        res = 'Unders{0}\n{1}{{}}\nOthers{0}\n'.format(
              '-'*60,
              indent
        )
        unders = []
        for attr in dir(self):
            if attr[:2]==attr[-2:]=='__':
                unders.append(attr)
            else:
                res+= '{0}{1} = {2}'.format(
                      indent,
                      attr,
                      getattr(self,attr)
                )[:80] + '\n'
        return res.format(', '.join(unders)).rstrip()

    def __str__ (self):
        return 'Instance of {}. Address: {}\n{}'.format(
               self.__class__.__name__,
               id(self),
               self.__getAttr()
        )

class ListTree:
    def __attrnames (self, obj, indent):
        spaces = ' ' * (indent+1)
        res = ''
        for attr in sorted(obj.__dict__):
            if attr.startswith('__') and attr.endswith('__'):
                res += '{0}{1}\n'.format(spaces, attr)
            else:
                res += '{0}{1} = {2}\n'.format(
                spaces, attr, getattr(obj, attr)
                )
        return res

    def __listclass (self, aClass, indent):
        dots = '.' * indent
        if aClass in self.__visited:
            return '\n{0}<class {1}({2}), address {3}: (see above)>\n'.format(
                    dots,
                    aClass.__name__,
                    ', '.join(map(lambda x: x.__name__, aClass.__bases__)),
                    id(aClass)
            )
        else:
            self.__visited.add(aClass)
            here = self.__attrnames(aClass, indent)
            above = ''.join(self.__listclass(s, indent+4)
                            for s in aClass.__bases__)
            return '\n{0}<class {1}({2}), address {3}:\n{4}{5}{6}>\n'.format(
                    dots,
                    aClass.__name__,
                    ', '.join(map(lambda x: x.__name__, aClass.__bases__)),
                    id(aClass),
                    here, above,
                    dots
            )

    def __str__(self):
        self.__visited = set()
        here = self.__attrnames(self, 0)
        above = self.__listclass(self.__class__, 4)
        return '<Instance of {0}({1}), address {2}:\n{3}{4}>'.format(
                self.__class__.__name__,
                ', '.join(map(lambda x: x.__name__, self.__class__.__bases__)),
                id(self),
                here, above
        )

if __name__ == '__main__':
    import testmixin
    testmixin.tester(ListTree)

def getMRO(cls):
    l = []
    stack = []
    stack.append(cls)
    while stack:
        c = stack.pop(0)
        l.append(c)
        if c.__bases__:
            stack[:0]=c.__bases__
    res = []
    for c in reversed(l):
        if c not in res:
            res.append(c)
    return list(reversed(res))

def multidecor (*args):
    def decorator(f):
        for decorator in reversed(args):
            f = decorator(f)
        return f
    return decorator

t = time.perf_counter
def timer (label=''):
    trace = bool(label)
    def actual (call):
        def onCall(*args, **kargs):
            start = t()
            result = call(*args, **kargs)
            spend = t() - start
            onCall.alltime += spend
            if trace:
                print(label,
                '{}: {}'
                .format(call.__name__, spend))
            return result
        onCall.alltime = 0
        return onCall
    return actual

def singleton (aClass):
    assert isinstance(aClass, type), 'singleton must be a class, not function'
    inst = None
    def onCall (*args, **kargs):
        nonlocal inst
        if not inst:
            inst = aClass(*args,**kargs)
        return inst
    return onCall

builtins = [
'add',
'sub',
'mul',
'div',
'call',
'str',
'repr',
'and',
'or',
]
def access(failer):
    def onDecorate(aClass):
        assert isinstance(aClass, type), 'private decorator uses for classes'
        if not __debug__: print('Optimized!'); return aClass
        class MixinOper:
            class Proxy:
                def __init__(self, attr):
                    self.attr = attr
                def __get__(self, inst, own):
                    return inst.__getattr__(self.attr)
            for name in builtins:
                exec("__{0}__ = Proxy('__{0}__')".format(name))
        class Wrapper(MixinOper):
            def __init__ (self, *args, **kargs):
                self.__wrapped = aClass(*args, **kargs)
            def __getattr__(self, attr):
                if failer(attr):
                    raise TypeError('private attr getting: '+attr)
                return getattr(self.__wrapped, attr)
            def __setattr__(self, attr, val):
                if attr=='_Wrapper__wrapped':
                    self.__dict__[attr] = val
                elif failer(attr):
                    raise TypeError('private attr setting: '+attr)
                else:
                    setattr(self.__wrapped, attr, val)
        return Wrapper
    return onDecorate

public =  lambda *attrs: access(lambda attr : attr not in attrs)
private = lambda *attrs: access(lambda attr : attr in attrs)


def verify(chdict, test):
    def decorator(func):
        code = func.__code__
        vars = code.co_varnames[:code.co_argcount]
        funcname = func.__name__
        def onError(argname, criteria):
            raise TypeError('{} arg "{}" not {}'.format(
            funcname, argname, criteria
            ))
        def onCall (*args, **kargs):
            positionals = vars[:len(args)]
            defaulted =[]
            for argname, criteria in chdict.items():
                if argname in kargs:
                    if not test(kargs[argname], criteria): onError(
                    argname, criteria
                    )
                elif argname in positionals:
                    i = positionals.index(argname)
                    if not test(args[i], criteria): onError(
                    argname+f'({i})', criteria
                    )
                else:
                    defaulted.append(argname)
            try:
                res = func(*args, **kargs)
            except:
                raise
            else:
                if defaulted:
                    print('args {} was dafaulted'.format(
                    ', '.join(map(lambda x: "'"+x+"'",defaulted))
                    ))
            return res
        return onCall
    return decorator

def rangetest(**chdict):
    return verify (chdict, lambda x, vals: vals[0]<=x<=vals[1])
def typetest(**chdict):
    return verify (chdict, lambda x, tp: isinstance(x, tp))
def ctest(**chdict):
    return verify(chdict, lambda x, test: test(x))

def decall (decorator):
    class Meta(type):
        def __new__(meta, name, sups, adict):
            for k,v in adict.items():
                if type(v)==types.FunctionType:
                    adict[k]=decorator(v)
            return type.__new__(meta, name, sups, adict)
    return Meta

def trace(func):
    def onCall(*args, **kargs):
        onCall.times +=1
        print('call[{}] of {}'.format(onCall.times,func.__name__))
        return func(*args,**kargs)
    onCall.times=0
    return onCall

def search(array, x):
    a,b = 0, len(array)
    while a<b-1:
        m = a + (b-a+1)//2
        if x>=array[m]:
            a = m
        else:
            b = m
    if array[a] == x:
        return a
    return b

class File:
    def __init__(self, filename):
        self.f = open(filename)

    def get(self, forcedList = False):
        records = self.f.readline().split()
        for i in range(len(records)):
            try:
                records[i] = int(records[i])
            except Exception:
                try:
                    records[i] = float(records[i])
                except Exception:
                    pass
        if not forcedList and len(records) == 1:
            return records[0]
        else:
            return records

    def getl (self):
        return self.f.readline().rstrip()

    def read(self, n, forcedList = False):
        return (self.get(forcedList) for _ in range(n))

    def __iter__(self):
        return iter(self.f)

def bins (L, R, cond):
    'Поиск первого слева индекса I для которого верно cond(I)'
    while L < R:
        m = (L + R) // 2
        if cond(m):
            R = m
        else:
            L = m + 1
    if not cond(L):
        L += 1
    return L

def rbins (L, R, cond):
    'Поиск первого справа индекса I для которого верно cond(I)'
    while L < R:
        M = (L + R + 1) // 2
        if cond(M):
            L = M
        else:
            R = M - 1
    if not cond(R):
        R -= 1
    return R

def fbins (a, b, prec, cond):
    while b - a > prec:
        m = (a+b) / 2
        if cond(m):
            b = m
        else:
            a = m
    return a

def indSort (seq):
    raise NotImplementedError           # TO DO
    indices = {i:i for i in range(len(seq))}
    pass
