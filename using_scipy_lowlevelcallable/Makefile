build:
	gcc -shared -fPIC -o testlib.so testlib.c
	cythonize -i *.pyx

clean:
	rm -f *.so *_api.h *_cy.c


test:
	python test.py
