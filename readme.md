# 🐯 영남대학교 사물함 예약 시스템
  
> **최초 배포 버전 개발 기간 : 2023.02 ~ 2023.03**  
> 
> **영남대 컴퓨터공학과 학생들을 위한 사물함 예약 시스템**    

<br>

## 💪Installation
### 장고에서 프로젝트 빌드하기

1. Django 디렉토리 내에서 가상환경 생성

```python
$ python3 -m venv {가상환경이름}
```

1. 가상환경 실행

```python
$ source {가상환경이름}/bin/activate
```

1. pip, setuptools 업그레이드

```python
$ pip install --upgrade pip && pip install --upgrade setuptools
```

1. 패키지 설치

```python
$ pip install -r requirements.txt
```

1. Flutter 빌드 방법

```bash
$ cd lockerReservation/Flutter/locker_reservation_sytem
$ flutter build web
```

1. 장고 실행

```python
$ python3 manage.py runserver 0.0.0.0:8000
```

- 플러터 빌드 파일 변경 시
flutter build 디렉토리 내 web 디렉토리 내부 파일들
Django/flutter_web_app 으로 복사


### Flutter 자동 빌드하기

<aside>
🔥 빌드 파일 .gitignore에 추가함으로써 pull request 후 merge 시 필수적으로 시행해야하는 동작

</aside>

1. flutter 프로젝트 디렉토리로 이동
    
    ```bash
    $ cd Flutter/locker_reservation_system
    ```
    
2. 빌드 자동화 셸 스크립트 실행
    
    ```bash
    $ sh moveBuildFile.sh
    ```
    
3. 장고에서 프로젝트 빌드하기 6번 실행
    
    ```python
    $ python3 manage.py runserver 0.0.0.0:8000
    ```
    

### 서버 URL 수정하기 (.env)

1. flutter 프로젝트파일의 assets/config 디렉토리로 이동
    
    ```bash
    $ cd Flutter/locker_reservation_system/assets/config
    ```
    
2. .env 파일 오픈
    
    ```bash
    vim .env
    ```
    
3. SERVER_URL의 변수 값 수정
    
    ```bash
    SERVER_URL={SERVER_URL}
    ```
<br>

### 전체 배포
위 사항을 따라 설정 완료 되었다면,
1. uwsgi 실행
```bash
$ cd Django

$ uwsgi --ini uwsgi.ini
```

2. Nginx 설치/설정
```bash
$ sudo apt-get install nginx

$ sudo vi /etc/nginx/nginx.conf
>
# http에 upstream django 추가
http {
    upstream django {
        server unix:/home/ubuntu/{프로젝트 폴더}/uwsgi.sock;
    }
}

$ sudo vi /etc/nginx/sites-enabled/default
>
location / {
    # try_files $uri $uri/ =404; 삭제
    include /etc/nginx/uwsgi_params;
    uwsgi_pass django;
}

$ sudo service nginx restart
```

3. letsencrypt https 적용
```bash
$ sudo apt-get install python3-certbot-nginx

$ sudo certbot --nginx -d yucselocker.site
>
# 이메일, 이용 동의 등 입력
1: No redirect - Make no further changes to the webserver configuration.
2: Redirect - Make all requests redirect to secure HTTPS access. Choose this for
new sites, or if you're confident your site works on HTTPS. You can undo this
# 1 : http->https 자동 리다이렉트 지원 X
# 2 : http->https 자동 리다이렉트 지원 O
```

## 💻 개발/배포 환경
### 😇 Frontend
<pre>
<b>Module                  Version</b>
Flutter                 3.7.6
cupertino_icons         1.0.2
provider                6.0.5
fluro                   2.0.5
http                    0.13.5
flutter_dotenv          5.0.2
flutter_svg             2.0.2
</pre>

### 😎 Backend
<pre>
<b>Module                  Version</b>
Python                  3.9
asgiref                 3.6.0
autopep8                2.0.1
backports.zoneinfo      0.2.1
certifi                 2022.12.7
cffi                    1.15.1
charset-normalizer      3.0.1
cryptography            39.0.1
Django                  4.1.6
django-cors-headers     3.13.0
django-filter           22.1
django-session-timeout  0.1.0
djangorestframework     3.14.0
idna                    3.4
pycodestyle             2.10.0
pycparser               2.21
pytz                    2022.7.1
requests                2.28.2
six                     1.16.0
sqlparse                0.4.3
tomli                   2.0.1
urllib3                 1.26.14
uWSGI                   2.0.21
</pre>

## Demo
- 메인화면
    ![Untitled](https://user-images.githubusercontent.com/77189999/223708338-fcc4f87b-fd09-4295-a5b9-cc2292d80834.png)
    
    (로그인 후 좌측 사물함 위치 버튼 눌렀을 때)
    ![2](https://user-images.githubusercontent.com/77189999/223708344-820604af-7911-4280-ac1b-371494209fde.png)

- 로그인
    ![3](https://user-images.githubusercontent.com/77189999/223708349-2c04f62b-ea06-44f0-8733-ba4266c94b9f.png)

- 회원가입
    ![4](https://user-images.githubusercontent.com/77189999/223708352-0b1e85a1-9c48-480c-8522-8039c20be04b.png)

- 채널톡
    ![5](https://user-images.githubusercontent.com/77189999/223708357-5c13529a-74ab-4754-972b-09f320772f50.png)


## 👩‍👩‍👧‍👦 Contributors
![flutter](https://img.shields.io/badge/frontend-02569B?style=for-the-badge&logo=flutter&logoColor=white)
|[정승균](https://github.com/seunggyun-jeong)|[원준영](https://github.com/Junyoung-WON)|
|-----|-----|

![django](https://img.shields.io/badge/backend-092E20?style=for-the-badge&logo=django&logoColor=white)
|[김재현](https://github.com/Grodned)|[최재혁](https://github.com/jjaegii)|
|-----|-----|
