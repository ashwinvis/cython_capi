.PHONY: build

_cleanso:
	rm *.so

_cleanh:
	rm *.h

_cleanc:
	rm *.c

_cleancpp:
	rm *.cpp

clean: _cleanso _cleanc _cleanh _cleancpp
	rm -rf build

build:
	python setup_add.py
	python setup_add_int.py
	pythran add2.py -v

test:
	python test.py
