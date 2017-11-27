.PHONY: build

_cleanso:
	rm *.so

_cleanh:
	rm *.h

_cleanc:
	rm *.c

clean: _cleanso _cleanc _cleanh
	rm -rf build

build:
	python setup_add.py
	python setup_add_int.py
	pythran add_pythran.py -v

test:
	python test.py
