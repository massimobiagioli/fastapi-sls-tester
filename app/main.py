from fastapi import FastAPI
from mangum import Mangum

from app.routers import health

app = FastAPI()


app.include_router(health.router)


handler = Mangum(app)
