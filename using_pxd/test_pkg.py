import unittest
import numpy as np
from pkg import cy_myfunc, myfunc


class TestAll(unittest.TestCase):
    def setUp(self):
        self.x = x = -100.
        self.y = y = 2001.
        self.ans = x * x - x * y + 3 * y

    def test_pythran(self):
        ans2 = myfunc.f(self.x, self.y, myfunc.f_capsule)
        np.testing.assert_equal(ans2, self.ans)

    def test_pythran_cython(self):
        ans2 = myfunc.f(self.x, self.y, cy_myfunc.__pyx_capi__['cy_f'])
        np.testing.assert_equal(ans2, self.ans)


if __name__ == '__main__':
    unittest.main()
