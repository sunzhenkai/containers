SHELL := /bin/bash

prepare:
	env ENV=$(env) bash scripts/prepare.sh

clean:
	env ENV=$(ENV) bash scripts/clean.sh

stop:
	env ENV=$(env) bash scripts/run.sh stop

start:
	env ENV=$(env) bash scripts/run.sh start
