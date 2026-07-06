# 청주여고 3학년 수시지원 관리

청주여자고등학교 3학년 수시지원 현황을 학생이 입력하고 교사/관리자가 관리하는 웹 페이지입니다. 순수 정적 사이트(HTML/CSS/JS)이며 별도 서버 없이 GitHub Pages로 호스팅할 수 있습니다. 데이터는 Firebase Firestore로 실시간 공유됩니다.

## 주요 기능
- 학생: 학번 로그인, 지원 대학/학과·전형 등 입력(대학·학과·전형명 자동완성), 하단 바로가기 모음(대입정보포털 등)
- 관리자/교사: 입력 및 수정, 모아보기(학급별·대학별·추천전형), 엑셀 내보내기, 비밀번호 초기화, 골드 설정, 랭킹 관리(관리자 전용, 기록 수정·삭제), 교사 계정 관리
- 스킨(화이트·블랙·옐로·레드·블루·라벤더)과 골드 재화, 골드 충전용 미니게임(피카피카썬더 — 몬스터볼 피하기)과 랭킹(주간/역대)
- 게임 사운드: BGM(bgm.mp3)과 합성 효과음(열매·필살기·게임오버), 우상단 On/Off 토글(기본 Off)
- 사운드 On/Off·입력칸 보기(줄바꿈/한줄보기) 설정은 사용자 계정에 저장되어 기기 간 유지
- 모든 팝업은 ESC 또는 바깥 클릭으로 닫힘

## 배포 (GitHub Pages)
1. 이 폴더의 파일들을 GitHub 저장소에 올립니다.
2. 저장소 **Settings → Pages → Build and deployment**에서 Source를 `Deploy from a branch`, 브랜치를 `main`(폴더 `/root`)으로 지정합니다.
3. 잠시 후 `https://<사용자명>.github.io/<저장소명>/` 로 접속하면 `index.html`이 `susi_admin.html`로 자동 이동합니다.

로컬에서 열 때도 `susi_admin.html`(또는 `index.html`)을 브라우저로 열면 됩니다.

## 데이터 저장 방식
골드·스킨·학생 입력·비밀번호·졸업생·교사·게임 랭킹 등 전체 상태는 **Firebase Firestore**(프로젝트 `susi-d9f34`, 문서 `state/all`)에 저장되어 **모든 기기·브라우저에서 실시간 공유**됩니다.
- 페이지 접속 시 익명 인증 후 `onSnapshot`으로 실시간 동기화합니다(Firestore 규칙: 인증된 요청만 허용).
- 변경 사항은 0.4초 디바운스 후 자동 저장됩니다.
- 브라우저 localStorage(`susi_state` 키)는 **로컬 캐시(폴백)** 용도입니다. Firebase가 4초 내 응답하지 않거나 인증·동기화에 실패하면 로컬 캐시로 진행합니다.
- 전체 데이터를 초기화하려면 Firebase 콘솔에서 `state/all` 문서를 삭제해야 합니다. `localStorage.clear()`는 현재 브라우저의 캐시만 지워지며, 접속하면 서버 데이터가 다시 내려옵니다.

## 기본 계정
- 관리자: `admin` / `admin1234`
- 학생: 학번 / 초기 비밀번호 = 학번
- 교사: 관리자가 생성, 초기 비밀번호 = `1234`

## 사이트 구성 파일
- `index.html` (진입, `susi_admin.html`로 이동)
- `susi_admin.html` (메인 앱), `susi_db.js` (대학/학과/전형 자동완성 데이터)
- `game.html` (미니게임) + 게임 이미지: `nomove/run1/run2/ball/jamoong/bli1/boksung1/orang1/background1/gotcha/start3/title/gameover.png`
- `bgm.mp3` (게임 배경음악 — Dream Island (Eevee Doll), Pokémon Pokopia OST. 없으면 BGM만 무음, 효과음은 정상)
- UI 이미지: `login.png`, `back_tile*.png`, `pikachu1/2`, `rijamong1/2`, `kkobugi1/2`, `kuromi1/2.png`, `adiga_logo.png`(바로가기 로고)

`*.xlsx`, `*.pdf`, `univ_*.json` 등은 원본/참고 자료로, 사이트 동작에는 필요하지 않습니다.
