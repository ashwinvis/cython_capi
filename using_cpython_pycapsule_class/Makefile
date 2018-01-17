.PHONY: build

build:
	python setup.py build_ext -i
	pythran -v call_capsule_pythran.py
	gcc `python-config --cflags --ldflags` call_capsule_c.c -o call_capsule_c.out

_cleanso:
	rm -f *.so

clean: _cleanso
	rm -f *.cpp *.out
	rm -f *_api.h
	rm -rf build

test:
	python -Wall test.py
	@echo 'Testing call_capsule_c.c'
	./call_capsule_c.out
