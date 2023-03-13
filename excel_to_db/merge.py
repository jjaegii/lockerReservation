import pandas as pd
import sqlite3
import json

filename = '2023 컴퓨터공학과 사물함 연장 신청.xlsx'
df = pd.read_excel(filename, engine='openpyxl')
list =[]

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


for i in range(len(df)):
    loc = df.loc[i]
    location = getLocation(loc)
    studentID = loc['학번']
    row = loc['행,열'].split(',')[0]
    col = loc['행,열'].split(',')[1]
    name = loc['이름']
    #print(location, int(row), int(col), str(studentID),str(name))
    dic = {'location':location,'row':int(row),'column':int(col),'studentID':str(studentID),'name':str(name)}
    list.append(dic)
    #sendData(location, int(row), int(col), str(studentID))
with open('./keeping_list.json', 'w') as outfile:
    json.dump(list, outfile, indent=4,ensure_ascii=False)