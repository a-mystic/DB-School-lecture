from fastapi import FastAPI

app = FastAPI()

@app.get("/select")
async def select(command: str):
    return ""

@app.get("/insert")
async def insert(command: str):
    return ""

@app.get("/delete")
async def delete(command: str):
    return ""
