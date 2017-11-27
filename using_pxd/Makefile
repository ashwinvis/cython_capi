.PHONY: build

clean:
	rm cy_myfunc.c *.so
	rm -rf build
	rm myfunc.o

build:
	gcc -c myfunc.c -o myfunc.o
	python setup.py
	pythran -v myfunc.py

test:
	python test.py
