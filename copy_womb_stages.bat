@echo off
chcp 65001 >nul
echo =====================================================================
echo   Aura Pregnancy - 10 Evreli Rahim Ici Fetus Gorselleri Kuruluyor
echo =====================================================================

set "SRC=C:\Users\ismai\.gemini\antigravity-ide\brain\2d687285-9103-42a7-9274-aa547f91f9b2\.user_uploaded"
set "DEST=d:\github\hamilelik-app\assets\images"
set "BAK=d:\github\hamilelik-app\assets\images\old_stages_backup"

if not exist "%BAK%" mkdir "%BAK%"

echo 1. Mevcut evreler yedekleniyor...
copy /y "%DEST%\womb_stage1.jpg" "%BAK%\old_womb_stage1.jpg" >nul
copy /y "%DEST%\womb_stage2.jpg" "%BAK%\old_womb_stage2.jpg" >nul
copy /y "%DEST%\womb_stage3.jpg" "%BAK%\old_womb_stage3.jpg" >nul
copy /y "%DEST%\womb_stage4.jpg" "%BAK%\old_womb_stage4.jpg" >nul
copy /y "%DEST%\womb_stage5.jpg" "%BAK%\old_womb_stage5.jpg" >nul
copy /y "%DEST%\womb_stage6.jpg" "%BAK%\old_womb_stage6.jpg" >nul

echo 2. 10 Evre sirasiyla assets/images/ klasorune kopyalaniyor...
copy /y "%SRC%\media_1788422655394.jpg" "%DEST%\womb_stage1.jpg"
copy /y "%BAK%\old_womb_stage1.jpg" "%DEST%\womb_stage2.jpg"
copy /y "%BAK%\old_womb_stage2.jpg" "%DEST%\womb_stage3.jpg"
copy /y "%SRC%\media_1788422655438.jpg" "%DEST%\womb_stage4.jpg"
copy /y "%BAK%\old_womb_stage3.jpg" "%DEST%\womb_stage5.jpg"
copy /y "%BAK%\old_womb_stage4.jpg" "%DEST%\womb_stage6.jpg"
copy /y "%SRC%\media_1788422655478.jpg" "%DEST%\womb_stage7.jpg"
copy /y "%SRC%\media_1788422655498.jpg" "%DEST%\womb_stage8.jpg"
copy /y "%BAK%\old_womb_stage5.jpg" "%DEST%\womb_stage9.jpg"
copy /y "%BAK%\old_womb_stage6.jpg" "%DEST%\womb_stage10.jpg"

echo.
echo =====================================================================
echo  BASARILI! 10 Evrenin tamami assets/images/ klasorune yerlestirildi.
echo  Simdi Flutter terminalinde 'R' tusuna basarak Hot Restart yapin.
echo =====================================================================
pause
