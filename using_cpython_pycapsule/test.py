
import rect

r = rect.PyRectangle(1, 2, 3, 4)
capi = r.get_capi()

import rect_pythran
for k in reversed(list(capi)):
    print('function: ', k)
    capsule = capi[k]
    print(rect_pythran.get_area(capsule, 41))
