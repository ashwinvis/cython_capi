.PHONY: build

_clean:
	rm -rf build
	rm myfunc.o

clean:
	rm cy_myfunc.c
	rm *.so

_compile:
	gcc -c myfunc.c -o myfunc.o

build: _compile
	python setup.py
	pythran -v myfunc.py

test:
	python test.py

clean_pkg: _clean
	rm cy_myfunc.c
	rm pkg/*.so
	rm -rf pkg.egg-info

build_pkg: _compile
	python setup_pkg.py develop
	pythran -v myfunc.py -o pkg/myfunc.so

test_pkg:
	python test_pkg.py

clean_pkg_inplace: _clean
	rm pkg_inplace/cy_myfunc.c
	rm pkg_inplace/*.so
	rm -rf pkg_inplace.egg-info

build_pkg_inplace: _compile
	python setup_pkg_inplace.py develop
	pythran -v myfunc.py -o pkg_inplace/myfunc.so

test_pkg_inplace:
	python test_pkg_inplace.py


all: build test clean

all_pkg: build_pkg test_pkg clean_pkg

all_pkg_inplace: build_pkg_inplace test_pkg_inplace clean_pkg_inplace
