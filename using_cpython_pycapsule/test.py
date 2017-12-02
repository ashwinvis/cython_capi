
import rect

r = rect.PyRectangle(1, 2, 3, 4)
capi = r.get_capi()

func_keys = ['twice_static', 'twice', 'get_area']

import rect_pythran
for k in func_keys:
    print('function: ', k)
    capsule = capi[k]
    print(rect_pythran.get_area(capsule, 41))
