
# pythran export capsule add_int_capsule(int, int)
def add_int_capsule(f, g):
    return f + g

# pythran export capsule add_capsule(float[][], float[][])
def add_capsule(f, g):
    return f + g

# pythran export add(int, int, int(int, int))
# pythran export add(float[][], float[][], float[][](float[][], float[][]))

def add(f, g, add_func):
    return add_func(f, g)
