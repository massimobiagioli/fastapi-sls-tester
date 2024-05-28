# FastAPI Serverless Tester

## Pre-requisites

- Python 3.12.x
- Poetry 1.8.x
- Terraform

## Tools and Frameworks

- [x] FastApi
- [x] Uvicorn
- [x] pytest
- [x] pre-commit
- [x] ruff

## Install dependencies

```
poetry install
```

## Terraform live configuration
Create terraform configurations in `infra/live` (a folder per stage, e.g. `dev`, `staging`, `prod`).
Create file `terraform.tfvars` (duplicate `terraform.tfvars.example`).

## Terraform state (S3)
Configure terraform state (S3 backend) in `infra/live/[stage]/config.tf`

## Install pre-commit hooks

```
pre-commit install
```

## Terraform commands (manual)

Format terraform files
```
make terraform-format
```

## Terraform commands (CI)

Init terraform
```
make terraform-init
```

Apply terraform
```
make terraform-apply
```

## Commands

Start local server
```
make start-local
```

Lint
```
make lint
```

Lint and fix
```
make lint-fix
```

Format
```
make format
```

Launch tests
```
make test
```

Launch test with coverage
```
make coverage
```

Run pre-commit hooks
```
make pre-commit
```