
import rect

print(rect.__pyx_capi__)
# {'foo': <capsule object "int (int)" at 0x7f28e02f27e0>,
#  'getArea': <capsule object "int (shapes::Rectangle)" at 0x7f28e02f2c90>,
#  'get_area_cy': <capsule object "int (struct cPyRectangle *)" at 0x7f28e02f2120>}

r = rect.PyRectangle(1, 2, 3, 4)
print(r.__pyx_vtable__)
# <capsule object NULL at 0x7f28e02f2fc0>
