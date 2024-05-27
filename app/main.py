from fastapi import FastAPI
from mangum import Mangum

app = FastAPI()


@app.get("/")
def index():
    return {"healthz": "ok"}


handler = Mangum(app)
