
import rect
import rect_pythran

r = rect.PyRectangle(1, 2, 3, 4)
capi = r.get_capi()

keys = list(reversed(sorted(list(capi.keys()))))

print(keys)

value = 41

for k in keys:
    print('function: ', k)
    capsule = capi[k]
    result = rect_pythran.get_area(capsule, value)

    if k.startswith('twice') and result != 2*value:
        how = 'wrong'
    else:
        how = 'good'

    print(how, 'result for capsule', k, '\n')
