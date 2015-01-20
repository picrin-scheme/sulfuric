PICRIN=/home/kim/compile/picrin/build/bin/picrin

all: test


test: test-util test-version test-tsort test-nitro

test-util: piclib/util.scm t/util.scm
	$(PICRIN) t/util.scm

test-version: piclib/util/version.scm t/util/version.scm t/util.scm
	$(PICRIN) t/util/version.scm

test-tsort: piclib/tsort.scm piclib/util.scm t/tsort.scm
	 $(PICRIN) t/tsort.scm

test-nitro: piclib/util.scm piclib/util/version.scm piclib/nitro.scm t/nitro.scm
	 $(PICRIN) t/nitro.scm

run-picrin:
	$(PICRIN)
