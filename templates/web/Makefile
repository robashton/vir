DEPS_DIR = $(addsuffix /deps, $(realpath .))
ERL_LIBS = $(DEPS_DIR):$(realpath apps)

export DEPS_DIR
export ERL_LIBS

export ERLCFLAGS = +debug_info +warn_export_vars +warn_shadow_vars +warn_obsolete_guard +'{lager_truncation_size, 10240}'
export ERLMIBFLAGS =

DEPS = lager cowboy gproc jsx

dep_lager = git://github.com/basho/lager.git 2.0.1
dep_cowboy = git://github.com/ninenines/cowboy.git master
dep_gproc = git://github.com/esl/gproc.git 0.2.12
dep_jsx = git://github.com/talentdeficit/jsx.git master

erl.mk:
	@wget --no-cache --no-check-certificate -nv -O $@ 'https://raw.github.com/id3as/erl-mk/master/erl.mk' || rm -f $@

-include erl.mk
