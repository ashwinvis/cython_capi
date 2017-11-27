.PHONY: build

clean:
	rm cy_add_int.c *.so
	rm -rf build
	rm add_int.o

build:
	gcc -c add_int.c -o add_int.o
	python setup.py
