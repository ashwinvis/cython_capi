import unittest
import numpy as np
import cy_add_int
import add_int


class TestAll(unittest.TestCase):
    def setUp(self):
        self.x = x = -100
        self.y = y = 2001
        self.ans = x + y

    def test_pythran(self):
        ans2 = add_int.add(self.x, self.y, add_int.f_capsule)
        np.testing.assert_equal(ans2, self.ans)

    def test_pythran_cython(self):
        ans2 = add_int.add(self.x, self.y, cy_add_int.__pyx_capi__['cy_add'])
        np.testing.assert_equal(ans2, self.ans)


if __name__ == '__main__':
    unittest.main()
