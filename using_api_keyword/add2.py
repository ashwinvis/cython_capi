
# pythran export capsule add_int(int, int)
def add_int(f, g):
    return f + g

# pythran export capsule add(float[][], float[][])
def add(f, g):
    return f + g

# pythran export add2(int, int, int(int, int))
# pythran export add2(float[][], float[][], float[][](float[][], float[][]))
def add2(f, g, add_func):
    return add_func(f, g)
