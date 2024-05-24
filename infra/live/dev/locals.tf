locals {
  app = {
    name        = "fastapi-starter-${var.stage}"
    description = "FastAPI starter application"
  }

  lambda = {
    main = {
      handler    = "app.main.handler"
      source_dir = "../../../app"
    }
  }

  layer = {
    dependencies = {
      name        = "fastapi-starter-dependencies-${var.stage}"
      description = "FastAPI Starter Dependencies Layer"
      build_dir   = "../../build/layers"
    }
  }

  tags = {
    Owner   = "Massimo Biagioli"
    Destroy = "false"
  }
}