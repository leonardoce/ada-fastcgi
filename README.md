Ada FastCgi Binding
===================

This is a simple FastCgi-Ada binding and allows to write web
application that can be connected with any FastCgi-complient web
server as HTTPD, nginx, and others

How to compile
--------------

This package also includes the c fastcgi library sources that you can
easily compile with MinGW and in Linux. To compile your `libfastcgi.a`
you must chdir to the `c` directory and use your copy of GNU Make:

    $ pwd
    [...]/fastcgi/c

    $ make
    [...]
    ar: creating libfastcgi.a

Now you can compile the test application. Chdir in the root dir:

    $ pwd
    [...]/fastcgi
    $ gnatmake -Ptestfcgi.gpr

You will see that in the `obj/testfast` there is the executable file
for a simple test program who listen for requests at the port
5000. Please configure your web server appropriately to use this
server process.

Happy coding.