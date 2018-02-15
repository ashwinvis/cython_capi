# pythran export call_capsule(
#   int(float64*, float64*, int, float64), float64*, float64*, int32, float64)


def call_capsule(capsule, in_ptr, out_ptr, nb, shift):
    r = capsule(in_ptr, out_ptr, nb, shift)
    return r

# Unable to do this
#  from numpy.ctypeslib import as_ctypes
#  # pythran export call_capsule(
#  #   int(float64*, float64*, int32, float64), float64[], float64[], int32, float64)
#
#
#  def call_capsule(capsule, in_arr, out_arr, nb, shift):
#      in_ptr = as_ctypes(in_arr)
#      out_ptr = as_ctypes(out_arr)
#      r = capsule(in_ptr, out_ptr)
#      return r
