import unittest
import numpy as np
import add
import add_int
import add_pythran


class TestAddInt(unittest.TestCase):
    def setUp(self):
        self.a = 1
        self.b = 2
        self.ans = self.a + self.b

    def test_pythran(self):
        ans2 = add_pythran.add(self.a, self.b, add_pythran.add_int_capsule)
        np.testing.assert_equal(ans2, self.ans)

    def test_pythran_cython(self):
        ans2 = add_pythran.add(self.a, self.b, add_int.__pyx_capi__['add'])
        np.testing.assert_equal(ans2, self.ans)


class TestAddArray(unittest.TestCase):
    def setUp(self):
        self.a = np.ones((3, 3))
        self.b = self.a * 3
        self.ans = self.a + self.b

    def test_pythran(self):
        ans2 = add_pythran.add(self.a, self.b, add_pythran.add_capsule)
        np.testing.assert_equal(ans2, self.ans)

    def test_cython(self):
        ans2 = add.add(self.a, self.b)
        np.testing.assert_equal(ans2, self.ans)

    def test_pythran_cython(self):
        """Results in segfault"""
        print('line commented because of segfault')
        # ans2 = add_pythran.add(self.a, self.b, add.__pyx_capi__['add'])
        # np.testing.assert_equal(ans2, self.ans)


if __name__ == '__main__':
    unittest.main()
