from fastapi import FastAPI
from fastapi.staticfiles import StaticFiles

app = FastAPI()

# mount front-end
app.mount("/static", StaticFiles(directory="static"), name="static")

@app.get("/")
async def root():
    return {"message": "Test"}