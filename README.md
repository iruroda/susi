# 청주여고 3학년 수시지원 관리

고등학교 3학년 수시지원 현황을 학생이 입력하고 교사/관리자가 관리하는 웹 페이지입니다. 순수 정적 사이트(HTML/CSS/JS)이며 별도 서버 없이 GitHub Pages로 호스팅할 수 있습니다.

## 주요 기능
- 학생: 학번 로그인, 지원 대학/학과·전형 등 입력(대학·학과·전형명 자동완성)
- 관리자/교사: 입력 및 수정, 모아보기(학급별·대학별·추천전형), 엑셀 내보내기, 비밀번호 초기화, 골드 설정, 교사 계정 관리
- 스킨(화이트·블랙·옐로·레드·블루·라벤더)과 골드 재화, 골드 충전용 미니게임(피카피카썬더 — 몬스터볼 피하기)과 랭킹

## 배포 (GitHub Pages)
1. 이 폴더의 파일들을 GitHub 저장소에 올립니다.
2. 저장소 **Settings → Pages → Build and deployment**에서 Source를 `Deploy from a branch`, 브랜치를 `main`(폴더 `/root`)으로 지정합니다.
3. 잠시 후 `https://<사용자명>.github.io/<저장소명>/` 로 접속하면 `index.html`이 `susi_admin.html`로 자동 이동합니다.

로컬에서 열 때도 `susi_admin.html`(또는 `index.html`)을 브라우저로 열면 됩니다.

## 데이터 저장 방식과 초기화
골드·스킨·학생 입력·비밀번호·졸업생·교사·게임 랭킹은 **파일이 아니라 접속한 브라우저의 localStorage**에 저장됩니다.
- 따라서 GitHub에 올린 버전은 **새 방문자/새 브라우저마다 빈 상태로 시작**합니다.
- 지금 쓰던 브라우저의 테스트 데이터를 지우려면: 페이지를 연 상태에서 `F12`(개발자도구) → **Console** 탭에 아래를 입력하고 Enter, 새로고침.
  ```js
  localStorage.clear()
  ```
  (또는 브라우저 설정에서 해당 사이트의 저장 데이터/쿠키 삭제)

> 여러 기기·브라우저 간 데이터 공유가 필요하면 Firebase 등 백엔드 연동이 필요합니다(추후 과제).

## 기본 계정
- 관리자: `admin` / `admin1234`
- 학생: 학번 / 초기 비밀번호 = 학번
- 교사: 관리자가 생성, 초기 비밀번호 = `1234`

## 사이트 구성 파일
- `index.html` (진입, `susi_admin.html`로 이동)
- `susi_admin.html` (메인 앱), `susi_db.js` (대학/학과/전형 자동완성 데이터)
- `game.html` (미니게임) + 게임 이미지: `nomove/run1/run2/ball/jamoong/bli1/boksung1/orang1/background1/gotcha/start3/title/gameover.png`
- UI 이미지: `login.png`, `back_tile*.png`, `pikachu1/2`, `rijamong1/2`, `kkobugi1/2`, `kuromi1/2.png`

`*.xlsx`, `*.pdf`, `univ_*.json` 등은 원본/참고 자료로, 사이트 동작에는 필요하지 않습니다.
