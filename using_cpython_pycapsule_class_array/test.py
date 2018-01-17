from __future__ import print_function

try:
    import faulthandler
    faulthandler.enable()
except ImportError:
    pass

import unittest
import numpy as np

import twice as twice_module
from twice import Twice
from call_capsule_pythran import call_capsule


class TestAll(unittest.TestCase):
    def setUp(self):
        self.obj = Twice()
        self.capi = self.obj.__pyx_capi__
        self.value = np.ascontiguousarray(41 * np.eye(3))

    def test_pythran(self):
        value = self.value
        print('\n')

        # self.capi.update(twice_module.__pyx_capi__)

        for name, capsule in self.capi.items():
            print('capsule', name)
            result = call_capsule(capsule, value)

            if name.startswith('twice'):
                if np.all(np.equal(result, 2 * value)):
                    how = 'good'
                else:
                    how = 'wrong'

                print(how, 'result ({})\n'.format(result))


if __name__ == '__main__':
    unittest.main()
