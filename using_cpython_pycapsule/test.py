try:
    import faulthandler
    faulthandler.enable()
except ImportError:
    pass

import unittest
import rect


class TestAll(unittest.TestCase):
    def setUp(self):
        self.r  = rect.PyRectangle(1, 2, 3, 4)
        self.capi = self.r.__pyx_capi__

    def test_pythran(self):
        import rect_pythran

        for k in reversed(list(self.capi)):
            print('function: ', k)
            capsule = self.capi[k]
            print(rect_pythran.get_area(capsule, 41))


if __name__ == '__main__':
    unittest.main()
