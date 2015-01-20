PICRIN=/home/kim/compile/picrin/build/bin/picrin

define TSORT_LOAD
(load "piclib/util.scm")
(load "piclib/tsort.scm")
(load "t/tsort.scm")
endef

export TSORT_LOAD

all: test


test: test-util test-version test-tsort

test-util: piclib/util.scm t/util.scm
	$(PICRIN) -l piclib/util.scm < t/util.scm

test-version: piclib/util/version.scm t/util/version.scm
	$(PICRIN) -l piclib/util/version.scm < t/util/version.scm

test-tsort: piclib/tsort.scm t/tsort.scm
	echo "$$TSORT_LOAD" | $(PICRIN)

run-picrin:
	$(PICRIN)
