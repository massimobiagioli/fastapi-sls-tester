from fastapi import FastAPI
from mangum import Mangum

app = FastAPI()


@app.get("/")
def index():
    return {"health": "ok"}


handler = Mangum(app)
