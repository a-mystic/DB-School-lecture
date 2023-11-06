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
        returnValue += str(result)
    return returnValue

@app.get("/insert")
async def insert(command: str):
    cursor.execute(command)
    return "입력하신 데이터가 입력되었습니다."

@app.get("/delete")
async def delete(command: str):
    cursor.execute(command)
    return "입력하신 데이터가 삭제되었습니다."

@app.get("/alter")
async def alter(command: str):
    cursor.execute(command)
    return "입력하신 데이터가 적용되었습니다."

@app.get("/update")
async def update(command: str):
    cursor.execute(command)
    return "입력하신 데이터값으로 값이 업데이트 되었습니다."

@app.get("/end")
async def end(command: str):
    disappear()
    return "종료되었습니다."

def disappear():
    connect.commit()
    cursor.close()
    connect.close()
