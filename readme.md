# 🐯 영남대학교 컴퓨터공학과 사물함 예약 시스템
  
> **최초 배포 버전 개발 기간 : 2023.02 ~ 2023.03**  
> 
> **영남대 컴퓨터공학과 학생들을 위한 사물함 예약 시스템**    

배포 진행했던 링크 - ~~[yucselocker.site](http://yucselocker.site/)~~ (현재 예약 종료, 매년 초 오픈)

<br>

## 💪Installation
### 프로젝트 빌드하기

1. 파이썬 패키지 설치

    ```bash
    $ pip install -r requirements.txt
    ```

2. Flutter 빌드

    2.1. 수동 빌드

    ```bash
    $ cd lockerReservation/Flutter/locker_reservation_system
    $ flutter build web
    ```
    Flutter/locker_reservation_system/web/ 내부 파일들을
    Django/flutter_web_app으로 이동

    2.2. 스크립트를 사용한 자동 빌드

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

3. 배포

    3.1. uwsgi 실행
    ```bash
    $ cd Django

    $ uwsgi --ini uwsgi.ini
    ```

    3.2. Nginx 설치/설정
    ```bash
    $ sudo apt-get install nginx

    $ sudo vi /etc/nginx/nginx.conf
    >
    # http에 upstream django 추가
    http {
        upstream django {
            server unix:{프로젝트 폴더 경로}/uwsgi.sock;
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

    3.3. letsencrypt https 적용
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

### 사물함 데이터 처리
1. 연장 신청 데이터 -> 데이터베이스 추가

    data_processing/excel_processing/2023 컴퓨터공학과 사물함 연장 신청.xlsx

    의 양식은 아래와 같다.

    ![엑셀양식](https://user-images.githubusercontent.com/77189999/225254114-84774016-ce86-4cc0-8fcd-06192e144098.png)


    연장신청 액셀 데이터 설정이 완료되었다면

    data_processing 디렉토리에서
    ```bash
    $ bash run.sh migrate
    ```

2. 사물함 예약 데이터베이스 -> UI로 결과 출력
    ```bash
    $ bash run.sh result
    ```
    실행하여 생긴 locker_state.png를 사용하면 됨.

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
crypto                  3.0.2
url_strategy            0.2.0
</pre>

### 😎 Backend
<pre>
<b>Package                 Version</b>
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

### Data Processing
<pre>
<b>Module                  Version</b>
et-xmlfile              1.1.0
numpy                   1.24.2
opencv-python           4.7.0.72
openpyxl                3.1.2
pandas                  1.5.3
Pillow                  9.4.0
python-dateutil         2.8.2
pytz                    2022.7.1
six                     1.16.0
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

- 결과 출력
    ![locker_state](https://user-images.githubusercontent.com/77189999/225255366-41b22e25-2a36-4417-862a-41b6fbfafee4.png)


## 👩‍👩‍👧‍👦 Contributors

<table border="1">
    <th colspan="2">
        <img src="https://img.shields.io/badge/frontend-02569B?style=for-the-badge&logo=flutter&logoColor=white"></img>
    </th>
    <tr>
        <td align="center">
            <img src="https://avatars.githubusercontent.com/u/77708819?v=4" width="100px;"></img><br/>
            <a href="https://github.com/seunggyun-jeong">정승균</a>
        </td>
        <td align="center">
            <img src="https://avatars.githubusercontent.com/u/92203597?v=4" width="100px;"> <br/>
            <a href="https://github.com/Junyoung-WON">원준영</a></td>
    </tr>
</table>

<table border="1">
    <th colspan="2" >
        <img src="https://img.shields.io/badge/backend-092E20?style=for-the-badge&logo=django&logoColor=white"></img>
    </th>
    <tr>
        <td align="center">
            <img src="https://avatars.githubusercontent.com/u/84281599?v=4" width="100px;"></img><br/>
            <a href="https://github.com/Gordned">김재현</a>
        </td>
        <td align="center">
            <img src="https://avatars.githubusercontent.com/u/77189999?v=4" width="100px;"> <br/>
            <a href="https://github.com/jjaegii">최재혁</a></td>
    </tr>
</table>
