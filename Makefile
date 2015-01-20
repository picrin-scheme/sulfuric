PICRIN=/home/kim/compile/picrin/build/bin/picrin

all: test


test: test-util

test-util: piclib/util.scm t/util.scm
	$(PICRIN) -l piclib/util.scm < t/util.scm

run-picrin:
	$(PICRIN)
