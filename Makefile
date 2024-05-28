.PHONY: help start-local test coverage lint lint-fix format terraform-init terraform-apply

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

lint: # Run linter
	poetry run ruff check .

lint-fix: # Run linter with fix
	poetry run ruff check --fix .

format: # Run formatter
	poetry run ruff format .

terraform-init: # Initialize terraform
	cd infra/live/${stage} && terraform init

terraform-apply: # Apply terraform
	cd infra/live/${stage} && terraform apply -auto-approve -var "stage=${stage}" -var "region=${region}"