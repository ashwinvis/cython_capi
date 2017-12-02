from rect import PyRectangle

# dont export get_area(PyRectangle, int(PyRectangle))
# pythran export get_area(struct, int (struct))
def get_area(py_rect, cy_get_area):
    return cy_get_area(py_rect)
