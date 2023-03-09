import pandas as pd

filename = '2023 컴퓨터공학과 사물함 연장 신청.xlsx'
df = pd.read_excel(filename, engine='openpyxl')

f = open("id.txt", "w")

for i in range(len(df)):
    loc = df.loc[i]
    studentID = loc['학번']
    f.writelines(str(studentID) + '\n')

f.close()
