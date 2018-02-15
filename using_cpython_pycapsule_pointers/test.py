from __future__ import print_function
try:
    import faulthandler
    faulthandler.enable()
except ImportError:
    pass

import unittest
import numpy as np
from numpy.ctypeslib import as_ctypes
from rect import PyRectangle
from call_capsule_pythran import call_capsule


class TestAll(unittest.TestCase):
    def setUp(self):
        self.nb = 10
        self.rect_in = np.arange(self.nb, dtype=np.float64)
        self.rect_out = np.arange(self.nb, dtype=np.float64)
        self.shift = 2.0

        self.rect = PyRectangle(0, 0, 1, 1)
        self.capi = self.rect.__pyx_capi__

    def test_pythran(self):

        keys = list(self.capi.keys())
        print(keys, '\n')

        capsule = self.capi['transform']
        rect_in_ptr = as_ctypes(self.rect_in)
        rect_out_ptr = as_ctypes(self.rect_out)
        result = call_capsule(
            capsule, rect_in_ptr, rect_out_ptr, self.nb, self.shift)

        print('result for get_area =', result, 'should be', 1)


if __name__ == '__main__':
    unittest.main()
