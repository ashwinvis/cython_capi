try:
    import faulthandler
    faulthandler.enable()
except ImportError:
    pass

import unittest
import rect
import rect_pythran


class TestAll(unittest.TestCase):
    def setUp(self):
        self.rect = rect.PyRectangle(1, 2, 3, 4)
        self.capi = self.rect.__pyx_capi__

    def test_pythran(self):

        keys = list(reversed(sorted(list(self.capi.keys()))))
        print(keys, '\n')
        value = 41

        for k in keys:
            print('function: ', k)
            capsule = self.capi[k]
            result = rect_pythran.get_area(capsule, value)

            if k.startswith('twice'):
                if result != 2*value:
                    how = 'wrong'
                else:
                    how = 'good'

                print(how, 'result for capsule', k, '\n')


if __name__ == '__main__':
    unittest.main()
