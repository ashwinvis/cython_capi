.PHONY: build

_cleanso:
	rm *.so

clean: _cleanso
	rm -rf build
	rm rect.cpp rect.h

build:
	python setup.py build_ext -i
	pythran -v rect_pythran.py

test:
	python -Wall test.py
