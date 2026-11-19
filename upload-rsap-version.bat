@echo off
set /p bn=BuildName?
echo Confirm:%bn%
pause
echo %bn% > rsapver.txt

del .\RSAP\build\language.zip
7z a ./RSAP/build/language.zip ../lang/*.json

makensis tmpbuild/rsap.nsi
copy .\tmpbuild\Setup.exe .\RSAP\build\RSAP(build%bn%).exe
set "file=.\RSAP\downloads.html"

echo ^<a href="/RSAP/build/RSAP(build%bn%).exe"^>RSAP_Build_%bn%_Setup^</a^> > "%file%.tmp"
echo ^<br^> >> "%file%.tmp"
type "%file%" >> "%file%.tmp"

move /y "%file%.tmp" "%file%" >nul

git add .
git commit -m "RSAP Build %bn% ver.txt"
git push
pause