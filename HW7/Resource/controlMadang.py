import pymysql

mode = input("아래의 모드중 1개를 선택해주세요.\n1. 데이터 검색, 2. 데이터 삽입, 3. 데이터 삭제\n")
inputCommand = input("아래에 SQL명령어를 입력해주세요:\n")

conn = pymysql.connect(
    host='192.168.56.101',
    port=4567,
    user='dohyunkim',
    password='0000',
    db='madang',
    charset='utf8'
    )
cur = conn.cursor()
cur.execute(inputCommand)

if mode == '1':
    results = cur.fetchall()
    for result in results:
        print(result)

if mode == '2':
    print("입력하신 데이터가 입력되었습니다.\n")

if mode == '3':
    print("입력하신 데이터가 삭제되었습니다.\n")

conn.commit()
cur.close()
conn.close()




