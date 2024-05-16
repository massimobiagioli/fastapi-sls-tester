.PHONY: help start-local test coverage

default: help

help: # Show help for each of the Makefile recipes.
	@grep -E '^[a-zA-Z0-9 -]+:.*#'  Makefile | sort | while read -r l; do printf "\033[1;32m$$(echo $$l | cut -f 1 -d':')\033[00m:$$(echo $$l | cut -f 2- -d'#')\n"; done

start-local: # Start local server
	uvicorn app.main:app --reload

test: # Run tests
ifdef filter
	poetry run pytest $(filter) -vv
else
	poetry run pytest -vv
endif

coverage: test # Run tests with coverage
	poetry run pytest --cov-report term-missing --cov=app