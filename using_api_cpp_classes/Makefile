.PHONY: build

_cleanso:
	rm *.so

clean: _cleanso
	rm *_api.h
	rm -rf build

build:
	python setup.py build_ext -i

test:
	python test.py
