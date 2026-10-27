@echo off
chcp 949 >nul
cd /d "%~dp0"

echo ========================================
echo    susi 사이트 GitHub 업로드
echo ========================================
echo.

where git >nul 2>nul
if errorlevel 1 goto err_nogit

if exist ".git" goto after_init
echo [1/6] 처음 연결하는 중...
git init -q
if errorlevel 1 goto err_init
git remote add origin https://github.com/iruroda/susi.git
git config user.name "iruroda"
git config user.email "iruroda@gmail.com"
goto after_init_msg
:after_init
echo [1/6] 이미 연결되어 있습니다.
:after_init_msg

echo [2/6] GitHub에서 가져오는 중...
git fetch origin -q
if errorlevel 1 goto err_fetch

set BR=main
git show-ref --verify --quiet refs/remotes/origin/main
if not errorlevel 1 goto branch_found
set BR=master
git show-ref --verify --quiet refs/remotes/origin/master
if not errorlevel 1 goto branch_found
goto err_branch
:branch_found
echo    -^> %BR%

git symbolic-ref HEAD refs/heads/%BR% >nul 2>nul
git reset origin/%BR% >nul 2>nul

echo [3/6] 바뀐 내용 확인 중...
git add -A
git diff --cached --quiet
if errorlevel 1 goto has_changes
echo    -^> 올릴 변경 사항이 없습니다. 이미 최신 상태입니다.
goto done_ok
:has_changes

echo [4/6] 저장 중...
git commit -q -m "susi update"
if errorlevel 1 goto err_commit

echo [5/6] GitHub로 올리는 중...
git push origin %BR%
if errorlevel 1 goto err_push

echo.
echo ========================================
echo    업로드 완료!
echo ========================================
goto done_ok

:err_nogit
echo [오류] git이 설치되어 있지 않습니다. Git을 먼저 설치해 주세요.
goto done_err

:err_init
echo [오류] 초기화에 실패했습니다.
goto done_err

:err_fetch
echo.
echo [오류] GitHub 저장소를 찾지 못했거나 인터넷 연결에 문제가 있습니다.
echo   저장소 주소를 확인하세요: https://github.com/iruroda/susi
goto done_err

:err_branch
echo.
echo [오류] GitHub 기본 브랜치를 찾지 못했습니다.
goto done_err

:err_commit
echo.
echo [오류] 저장에 실패했습니다. 위 메시지를 확인하세요.
goto done_err

:err_push
echo.
echo [오류] 업로드에 실패했습니다. 위 메시지를 확인하세요.
echo   로그인 창이 떴다면 iruroda 깃허브 계정으로 로그인하세요.
goto done_err

:done_err
echo.
echo 아무 키나 누르면 창이 닫힙니다...
pause >nul
exit /b 1

:done_ok
echo.
echo 아무 키나 누르면 창이 닫힙니다...
pause >nul
exit /b 0
