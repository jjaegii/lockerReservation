1. nginx 설치
```
$ sudo apt-get install nginx
```
2. nginx.conf 파일 수정
```
$ sudo vi /etc/nginx/nginx.conf

>
# http에 upstream django 추가
http {
    upstream django {
        server unix:/home/ubuntu/lockerReservation/Django/uwsgi.sock;
    }
}
```

3. site-enabled/default 파일 수정
```
$ sudo vi /etc/nginx/sites-enabled/default

>
location / {
    # try_files $uri $uri/ =404; 삭제
    include /etc/nginx/uwsgi_params;
    uwsgi_pass django;
}

location /static/ {
    alias /home/ubuntu/{프로젝트 static 폴더};
}

location /media/ {
    alias /home/ubuntu/{프로젝트 media 폴더};
}
```

4. nginx 재시작
```
$ sudo service nginx restart
```