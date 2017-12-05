from __future__ import print_function
try:
    import faulthandler
    faulthandler.enable()
except ImportError:
    pass

import unittest
from rect import PyRectangle
from call_capsule_pythran import call_capsule


class TestAll(unittest.TestCase):
    def setUp(self):
        self.rect = PyRectangle(1, 2, 3, 4)
        self.capi = self.rect.__pyx_capi__

    def test_pythran(self):

        keys = list(reversed(sorted(list(self.capi.keys()))))
        print(keys, '\n')
        value = 41

        for k in keys:
            print('function: ', k)
            capsule = self.capi[k]
            result = call_capsule(capsule, value)

            if k.startswith('twice'):
                if result != 2*value:
                    how = 'wrong'
                else:
                    how = 'good'

                print(how, 'result for capsule', k, '\n')

            if k.startswith('get_area'):
                print('result for get_area', result)


if __name__ == '__main__':
    unittest.main()
