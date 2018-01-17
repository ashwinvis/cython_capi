from __future__ import print_function

try:
    import faulthandler
    faulthandler.enable()
except ImportError:
    pass

import unittest

import twice as twice_module
from twice import Twice
from call_capsule_pythran import call_capsule


class TestAll(unittest.TestCase):
    def setUp(self):
        self.obj = Twice()
        self.capi = self.obj.__pyx_capi__

    def test_pythran_capi(self):
        capsule = twice_module.__pyx_capi__['twice_func']
        value = 41
        print('Cython generated capsule twice_func')
        result = call_capsule(capsule, value)
        if result != 2 * value:
            how = 'wrong'
        else:
            how = 'good'

        print(how, 'result ({})\n'.format(result))

    def test_pythran(self):
        value = 41
        print('\n')

        for name, capsule in self.capi.items():
            print('capsule', name)
            result = call_capsule(capsule, value)

            if name.startswith('twice'):
                if result != 2*value:
                    how = 'wrong'
                else:
                    how = 'good'

                print(how, 'result ({})\n'.format(result))


if __name__ == '__main__':
    unittest.main()
