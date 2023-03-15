import sqlite3
import os
import numpy as np
import cv2
from PIL import ImageFont, ImageDraw, Image
import json

font = ImageFont.truetype('./GULIM.TTC', 38)  # 폰트경로
font2 = ImageFont.truetype('./GULIM.TTC', 50)  # 폰트경로

conn = sqlite3.connect('../../Django/db.sqlite3')  # db 경로
jfile = open('keeping_list.json')  # 유지 인원 json파일 경로
keep_list = json.load(jfile)

c = conn.cursor()
lock_a = [["0" for col in range(20)] for row in range(5)]
lock_b = [["0" for col in range(6)] for row in range(5)]
lock_c = [["0" for col in range(22)] for row in range(5)]
lock_d = [["0" for col in range(2)] for row in range(5)]
lock_e = [["0" for col in range(12)] for row in range(5)]


for i in c.execute('SELECT * FROM locker_state_locker where location = "a"').fetchall():
    lock_a[i[1]][i[2]] = i[3]
    stid_a = i[3]
    ret = next(
        (item for item in keep_list if item['studentID'] == stid_a), None)
    if (ret == None):
        lock_a[i[1]][i[2]] += '\n'+c.execute(
            'select name from user_user where studentID = "'+stid_a+'"').fetchall()[0][0]  # 이름
    else:
        lock_a[i[1]][i[2]] += '\n'+ret['name']

for i in c.execute('SELECT * FROM locker_state_locker where location = "b"').fetchall():
    lock_b[i[1]][i[2]] = i[3]
    stid_b = i[3]
    ret = next(
        (item for item in keep_list if item['studentID'] == stid_b), None)
    if (ret == None):
        lock_b[i[1]][i[2]] += '\n'+c.execute(
            'select name from user_user where studentID = "'+stid_b+'"').fetchall()[0][0]  # 이름
    else:
        lock_b[i[1]][i[2]] += '\n'+ret['name']

for i in c.execute('SELECT * FROM locker_state_locker where location = "c"').fetchall():
    lock_c[i[1]][i[2]] = i[3]
    stid_c = i[3]
    ret = next(
        (item for item in keep_list if item['studentID'] == stid_c), None)
    if (ret == None):
        lock_c[i[1]][i[2]] += '\n'+c.execute(
            'select name from user_user where studentID = "'+stid_c+'"').fetchall()[0][0]  # 이름
    else:
        lock_c[i[1]][i[2]] += '\n'+ret['name']

for i in c.execute('SELECT * FROM locker_state_locker where location = "d"').fetchall():
    lock_d[i[1]][i[2]] = i[3]
    stid_d = i[3]
    ret = next(
        (item for item in keep_list if item['studentID'] == stid_d), None)
    if (ret == None):
        lock_d[i[1]][i[2]] += '\n'+c.execute(
            'select name from user_user where studentID = "'+stid_d+'"').fetchall()[0][0]  # 이름
    else:
        lock_d[i[1]][i[2]] += '\n'+ret['name']

for i in c.execute('SELECT * FROM locker_state_locker where location = "e"').fetchall():
    lock_e[i[1]][i[2]] = i[3]
    stid_e = i[3]
    ret = next(
        (item for item in keep_list if item['studentID'] == stid_e), None)
    if (ret == None):
        lock_e[i[1]][i[2]] += '\n'+c.execute(
            'select name from user_user where studentID = "'+stid_e+'"').fetchall()[0][0]  # 이름
    else:
        lock_e[i[1]][i[2]] += '\n'+ret['name']


img = np.zeros((2300, 5000, 3), dtype=np.uint8)

cv2.rectangle(img, (0, 0), (5000, 2300), color=(255, 255, 255), thickness=-1)
cv2.rectangle(img, (100, 100), (500, 200), color=(0, 0, 0), thickness=4)


for row in range(len(lock_a)):
    for col in range(len(lock_a[0])):
        ret = next(
            (item for item in keep_list if item['studentID'] == lock_a[row][col][0:8]), None)
        if (ret != None):
            if (ret['location'] == 'a' and ret['row'] == row and ret['column'] == col):
                cv2.rectangle(img, (col*200+100, row*100+200), (col*200+200 +
                              100, row*100+100+200), color=(155, 155, 0), thickness=-1)
        cv2.rectangle(img, (col*200+100, row*100+200), (col*200 +
                      200+100, row*100+100+200), color=(0, 0, 0), thickness=4)

cv2.rectangle(img, (100, 800), (500, 900), color=(0, 0, 0), thickness=4)
for row in range(len(lock_c)):
    for col in range(len(lock_c[0])):
        ret = next(
            (item for item in keep_list if item['studentID'] == lock_c[row][col][0:8]), None)
        if (ret != None):
            if (ret['location'] == 'c' and ret['row'] == row and ret['column'] == col):
                cv2.rectangle(img, (col*200+100, row*100+900), (col*200+200 +
                              100, row*100+100+900), color=(155, 155, 0), thickness=-1)
        cv2.rectangle(img, (col*200+100, row*100+900), (col*200 +
                      200+100, row*100+100+900), color=(0, 0, 0), thickness=4)

cv2.rectangle(img, (100, 1500), (500, 1600), color=(0, 0, 0), thickness=4)
for row in range(len(lock_b)):
    for col in range(len(lock_b[0])):
        ret = next(
            (item for item in keep_list if item['studentID'] == lock_b[row][col][0:8]), None)
        if (ret != None):
            if (ret['location'] == 'b' and ret['row'] == row and ret['column'] == col):
                cv2.rectangle(img, (col*200+100, row*100+1600), (col*200+200 +
                              100, row*100+100+1600), color=(155, 155, 0), thickness=-1)
        cv2.rectangle(img, (col*200+100, row*100+1600), (col*200 +
                      200+100, row*100+100+1600), color=(0, 0, 0), thickness=4)

cv2.rectangle(img, (4300, 100), (4700, 200), color=(0, 0, 0), thickness=4)
for row in range(len(lock_d)):
    for col in range(len(lock_d[0])):
        ret = next(
            (item for item in keep_list if item['studentID'] == lock_d[row][col][0:8]), None)
        if (ret != None):
            if (ret['location'] == 'd' and ret['row'] == row and ret['column'] == col):
                cv2.rectangle(img, (col*200+4300, row*100+200), (col*200+200 +
                              4300, row*100+100+200), color=(155, 155, 0), thickness=-1)
        cv2.rectangle(img, (col*200+4300, row*100+200), (col*200 +
                      200+4300, row*100+100+200), color=(0, 0, 0), thickness=4)

cv2.rectangle(img, (1500, 1500), (1900, 1600), color=(0, 0, 0), thickness=4)
for row in range(len(lock_e)):
    for col in range(len(lock_e[0])):
        ret = next(
            (item for item in keep_list if item['studentID'] == lock_e[row][col][0:8]), None)
        if (ret != None):
            if (ret['location'] == 'e' and ret['row'] == row and ret['column'] == col):
                cv2.rectangle(img, (col*200+1500, row*100+1600), (col*200+200 +
                              1500, row*100+100+1600), color=(155, 155, 0), thickness=-1)
        cv2.rectangle(img, (col*200+1500, row*100+1600), (col*200 +
                      200+1500, row*100+100+1600), color=(0, 0, 0), thickness=4)

cv2.circle(img, (4150, 1750), 50, (155, 155, 0), -1)

# 추가
img = Image.fromarray(img)
draw = ImageDraw.Draw(img)

draw.text((4225, 1725), ': 연장신청', fill='black', font=font2)

# cv2.rectangle(img, (100,100), (500,200), color=(0, 0, 0), thickness=4)
draw.text((100+10, 100+10), "114호 앞", fill='black', font=font2)
for row in range(len(lock_a)):
    for col in range(len(lock_a[0])):
        if (lock_a[row][col] != '0'):
            draw.text((col*200+100+10, row*100+200+10),
                      lock_a[row][col], fill='black', font=font)
        # cv2.rectangle(img, (col*200+100,row*100+200), (col*200+200+100,row*100+100+200), color=(0, 0, 0), thickness=4)

# cv2.rectangle(img, (100,800), (500,900), color=(0, 0, 0), thickness=4)
draw.text((100+10, 800+10), "220호 앞", fill='black', font=font2)
for row in range(len(lock_c)):
    for col in range(len(lock_c[0])):
        if (lock_c[row][col] != '0'):
            draw.text((col*200+100+10, row*100+900+10),
                      lock_c[row][col], fill='black', font=font)
        # cv2.rectangle(img, (col*200+100,row*100+900), (col*200+200+100,row*100+100+900), color=(0, 0, 0), thickness=4)

# cv2.rectangle(img, (100,1500), (500,1600), color=(0, 0, 0), thickness=4)\
draw.text((100+10, 1500+10), "113호 앞", fill='black', font=font2)
for row in range(len(lock_b)):
    for col in range(len(lock_b[0])):
        if (lock_b[row][col] != '0'):
            draw.text((col*200+100+10, row*100+1600+10),
                      lock_b[row][col], fill='black', font=font)
        # cv2.rectangle(img, (col*200+100,row*100+1600), (col*200+200+100,row*100+100+1600), color=(0, 0, 0), thickness=4)

# cv2.rectangle(img, (4300,100), (4700,200), color=(0, 0, 0), thickness=4)
draw.text((4300+10, 100+10), "219호 앞", fill='black', font=font2)
for row in range(len(lock_d)):
    for col in range(len(lock_d[0])):
        if (lock_d[row][col] != '0'):
            draw.text((col*200+4300+10, row*100+200+10),
                      lock_d[row][col], fill='black', font=font)
        # cv2.rectangle(img, (col*200+4300,row*100+200), (col*200+200+4300,row*100+100+200), color=(0, 0, 0), thickness=4)

# cv2.rectangle(img, (1500,1500), (1900,1600), color=(0, 0, 0), thickness=4)
draw.text((1500+10, 1500+10), "221호 앞", fill='black', font=font2)
for row in range(len(lock_e)):
    for col in range(len(lock_e[0])):
        if (lock_e[row][col] != '0'):
            draw.text((col*200+1500+10, row*100+1600+10),
                      lock_e[row][col], fill='black', font=font)
        # cv2.rectangle(img, (col*200+1500,row*100+1600), (col*200+200+1500,row*100+100+1600), color=(0, 0, 0), thickness=4)

# draw.text((30, 30), '텍스트', fill='black', font=font)

img = np.array(img)
# 추가

cv2.imwrite("locker_state.png", img)
c.close()
jfile.close()
