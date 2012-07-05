ifeq ($(OS), MINGW)
OBJS = os_win32.o
CONFIG_FILE = fcgi_config_mingw.h
else
OBJS = os_unix.o
CONFIG_FILE = fcgi_config_linux.h
endif

.PHONY: all
.SUFFIXES: .c

OBJS += fcgiapp.o

all: fcgi_config.h libfastcgi.a

fcgi_config.h: $(CONFIG_FILE)
	cp $< $@

libfastcgi.a: $(OBJS) fcgi_config.h
	ar r $@ $(OBJS)

clean:
	rm -f $(OBJS) libfastcgi.a
	rm -f fcgi_config.h
