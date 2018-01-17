#include <stdio.h>
#include <string.h>
#include <errno.h>
#include <stdlib.h>
#include "Python.h"
#include "twice_api.h"

// Reference: https://docs.python.org/2/extending/extending.html

static void **PyTwice_API;

static int
import_twice2(void)
{
    PyTwice_API = (void **)PyCapsule_Import("twice._C_API", 0);
    return (PyTwice_API != NULL) ? 0 : -1;
}


int
main(int argc, char* argv[]) {
	int arg;

	arg = 123;

	printf("initializing...");
        Py_Initialize();
	printf("importing twice module...");
	/*
	int result;
        if(import_twice() < 0) {
	   printf("error importing! exiting...");
	   return -1;
	}
	printf("calling twice_func...");
	result = twice_func(arg);
	printf("%d", result);
	*/

	// Trying to do everything from scratch
	PyObject *module;
	PyObject *my_callback = NULL;
	PyObject *arglist;
	PyObject *result;
	
	PyImport_ImportModule("twice");
	if(import_twice2() < 0) {
	   printf("error importing! exiting...");
	   return -1;
	}
	/*
	// Time to call the callback 
	arglist = Py_BuildValue("(i)", arg);
	result = PyObject_CallObject(my_callback, arglist);
	Py_DECREF(arglist);
	Py_Finalize();
	*/
	printf("All's well that ends well");
	return 0;
}
