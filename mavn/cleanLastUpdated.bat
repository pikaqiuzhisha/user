set REPOSITORY_PATH=G:\maven\apache-maven-3.5.2\repository
rem ��������...
for /f "delims=" %%i in ('dir /b /s "%REPOSITORY_PATH%\*lastUpdated*"') do (
    del /s /q %%i
)
rem �������
pause