# pythran export capsule f_capsule(float, float)
def f_capsule(x, y):
    return x * x - x * y + 3 * y


# pythran export f(float, float, float(float, float))
def f(x, y, func):
    return func(x, y)
