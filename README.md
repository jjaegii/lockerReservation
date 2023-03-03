# 🐯 영남대학교 사물함 예약 시스템

> **SW중심대학 공동해커톤 2022(디지털전환을 이끄는 힘, 소프트웨어)**  
> **프로젝트 기간 : 2022.06.22(수)~ 2022.06.24(금)**  
> 
> **휠체어 사용자를 위한 외출 보조 앱**  
> **(SwiftUI 사용)**  


## 💻 개발/배포 환경
### Backend
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
### Frontend
```
Flutter 3.7.6
```


## 📌 Commit Convention

<details>
<summary> 컨벤션 보기</summary>
<div markdown="1">
  
```
[CHORE] 코드 수정, 내부 파일 수정, 주석
[FEAT] 새로운 기능 구현
[ADD] Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 파일 생성 시, 에셋 추가
[FIX] 버그, 오류 해결
[DEL] 쓸모없는 코드 삭제
[DOCS] README나 WIKI 등의 문서 개정
[MOVE] 프로젝트 내 파일이나 코드의 이동
[RENAME] 파일 이름 변경이 있을 때 사용합니다
[REFACTOR] 전면 수정이 있을 때 사용합니다
[INIT] 프로젝트 생성
```
  
  </div>
</details>
<br>

## 📌 깃 사용 전략
> Issue -> 브랜치 생성 -> Pull받고 작업 -> Commit -> Pull -> Push -> PR -> Merge

0. 새로운 작업이 진행 전, Pull을 반드시 진행합니다.
1. Issue는 기능 단위로 생성합니다.
2. Issue에 관한 Commit과 Push는 본인 브랜치로 진행합니다.
3. PR은 모든 작업이 완료된 후 진행합니다.

> 커밋 컨벤션
```
[CHORE] 코드 수정, 내부 파일 수정, 주석
[FEAT] 새로운 기능 구현
[ADD] Feat 이외의 부수적인 코드 추가, 라이브러리 추가, 새로운 파일 생성 시, 에셋 추가
[FIX] 버그, 오류 해결
[DEL] 쓸모없는 코드 삭제
[DOCS] README나 WIKI 등의 문서 개정
[MOVE] 프로젝트 내 파일이나 코드의 이동
[RENAME] 파일 이름 변경이 있을 때 사용합니다
[REFACTOR] 전면 수정이 있을 때 사용합니다
[INIT] 프로젝트 생성
```
> 브랜치 전략

- 브랜치는 각 `feat/이슈번호-큰기능명/세부기능명`으로 생성합니다.
- ex. feat/#21-MapView/UI



## 👩‍👩‍👧‍👦 Contributors
- 최재혁 (xxxx@mail.com)
- 김재현 (xxxx@mail.com)
- 원준영 (xxxx@mail.com)
- 정승균 (jskyun98@gmail.com)