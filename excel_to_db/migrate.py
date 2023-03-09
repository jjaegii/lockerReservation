import pandas as pd
import sqlite3

filename = '2023 컴퓨터공학과 사물함 연장 신청.xlsx'
df = pd.read_excel(filename, engine='openpyxl')


def getLocation(loc):
    location = ''
    if loc['사물함 위치'] == "114호 앞":
        location = 'a'
    elif loc['사물함 위치'] == "113호 앞":
        location = 'b'
    elif loc['사물함 위치'] == "220호 앞":
        location = 'c'
    elif loc['사물함 위치'] == "219호 앞":
        location = 'd'
    elif loc['사물함 위치'] == "221호 앞":
        location = 'e'
    return location


def sendData(location, row, col, studentID):
    conn = sqlite3.connect('db.sqlite3')
    cursor = conn.cursor()
    sql = 'INSERT INTO locker_state_locker(location, row, column, studentID) VALUES (?,?,?,?)'
    cursor.execute(sql, (location, row, col, studentID))
    conn.commit()
    conn.close()


for i in range(len(df)):
    loc = df.loc[i]
    location = getLocation(loc)
    studentID = loc['학번']
    row = loc['행,열'].split(',')[0]
    col = loc['행,열'].split(',')[1]
    print(location, int(row), int(col), str(studentID))
    sendData(location, int(row), int(col), str(studentID))
