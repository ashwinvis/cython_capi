.PHONY: build

_cleanso:
	rm *.so

clean: _cleanso
	rm rect_api.h rect.cpp rect.h
	rm -rf build

build:
	python setup.py build_ext -i
	pythran -v rect_pythran.py

test:
	python test.py
