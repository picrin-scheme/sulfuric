PICRIN=/home/kim/compile/picrin/build/bin/picrin

all: test


test: test-util test-version test-tsort

test-util: piclib/util.scm t/util.scm
	$(PICRIN) t/util.scm

test-version: piclib/util/version.scm t/util/version.scm t/util.scm
	$(PICRIN) t/util/version.scm

test-tsort: piclib/tsort.scm t/tsort.scm t/util.scm
	 $(PICRIN) t/tsort.scm

run-picrin:
	$(PICRIN)
