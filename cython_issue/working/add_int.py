# pythran export capsule f_capsule(int, int)
def f_capsule(x, y):
    return x + y


# pythran export add(int, int, int(int, int))
def add(x, y, func):
    return func(x, y)
