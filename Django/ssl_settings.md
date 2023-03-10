1. Certbot 설치
```
# certbot 패키지 저장소 추가
$ sudo add-apt-repository ppa:certbot/certbot
# python-nginx용 certbot 설치
$ sudo apt-get install python3-certbot-nginx
```

2. 인증서 발급 및 적용
```
$ sudo certbot --nginx -d {도메인}

>
# 이메일, 이용 동의 등 입력
1: No redirect - Make no further changes to the webserver configuration.
2: Redirect - Make all requests redirect to secure HTTPS access. Choose this for
new sites, or if you're confident your site works on HTTPS. You can undo this
# 1 : http->https 자동 리다이렉트 지원 X
# 2 : http->https 자동 리다이렉트 지원 O
```