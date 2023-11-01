from fastapi import FastAPI
import pymysql

# initialize
app = FastAPI()
connect = pymysql.connect(
    host='192.168.56.101',
    port=4567,
    user='dohyunkim',
    password='0000',
    db='Termproject',
    charset='utf8'
)
cursor = connect.cursor()

@app.get("/select")
async def select(command: str):
    cursor.execute(command)
    returnValue = ""
    results = cursor.fetchall()
    for result in results:
        returnValue += result
    disappear()
    return returnValue

@app.get("/insert")
async def insert(command: str):
    cursor.execute(command)
    disappear()
    return "입력하신 데이터가 입력되었습니다."

@app.get("/delete")
async def delete(command: str):
    cursor.execute(command)
    disappear()
    return "입력하신 데이터가 삭제되었습니다."

def disappear():
    connect.commit()
    cursor.close()
    connect.close()
