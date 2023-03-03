# 🐯 영남대학교 사물함 예약 시스템

> **영남대학교 학생회**  
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

## 💻 개발/배포 환경
### 😎Backend
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
</pre>
### 😇Frontend
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

## 👩‍👩‍👧‍👦 Contributors
- 최재혁 (xxxx@mail.com)
- 김재현 (xxxx@mail.com)
- 원준영 (xxxx@mail.com)
- 정승균 (jskyun98@gmail.com)