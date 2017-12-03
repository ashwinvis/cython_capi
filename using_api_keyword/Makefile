.PHONY: build

build:
	python setup_add.py
	pythran add_pythran.py -v

_cleanso:
	rm -f *.so

_cleanh:
	rm -f *.h

_cleanc:
	rm -f *.c

clean: _cleanc _cleanh _cleanso
	rm -rf build

test:
	python test.py
