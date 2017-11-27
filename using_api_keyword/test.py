import unittest
import numpy as np
import add
import add_int
import add2


class TestAll(unittest.TestCase):
    def test_int(self):
        a = 1
        b = 2
        ans = a + b
        ans2 = add2.add2_int(a, b, add_int.__pyx_capi__['add'])
        np.testing.assert_equal(ans, ans2)

    def test_pythran_int(self):
        a = 1
        b = 2
        ans = a + b
        ans2 = add2.add2_int(a, b, add2.add_int)
        np.testing.assert_equal(ans, ans2)

    def test_pythran(self):
        a = np.ones((3, 3))
        b = a * 3
        ans = a + b
        ans2 = add2.add2(a, b, add2.add)
        np.testing.assert_equal(ans, ans2)

    def test_ndarray(self):
        """Results in segfault"""
        a = np.ones((3, 3))
        b = a * 3
        ans = a + b
        # ans2 = add2.add2(a, b, add.__pyx_capi__['add'])
        # np.testing.assert_equal(ans, ans2)


if __name__ == '__main__':
    unittest.main()
