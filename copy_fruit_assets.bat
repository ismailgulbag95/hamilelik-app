@echo off
chcp 65001 >nul
echo 3D Claymorphic meyve görselleri assets/images/ klasörüne kopyalanıyor...

set "SRC=C:\Users\ismai\.gemini\antigravity-ide\brain\3fd5e23f-3adc-4496-9e1f-4efd6b57fac6"
set "DEST=d:\github\hamilelik-app\assets\images"

copy /y "%SRC%\fruit_seed_1788097558927.jpg" "%DEST%\fruit_seed.jpg"
copy /y "%SRC%\fruit_blueberry_1788097505472.jpg" "%DEST%\fruit_blueberry.jpg"
copy /y "%SRC%\fruit_strawberry_1788097459744.jpg" "%DEST%\fruit_strawberry.jpg"
copy /y "%SRC%\fruit_lemon_1788097474377.jpg" "%DEST%\fruit_lemon.jpg"
copy /y "%SRC%\fruit_peach_1788097641791.jpg" "%DEST%\fruit_peach.jpg"
copy /y "%SRC%\fruit_avocado_1788097445163.jpg" "%DEST%\fruit_avocado.jpg"
copy /y "%SRC%\fruit_banana_1788097489908.jpg" "%DEST%\fruit_banana.jpg"
copy /y "%SRC%\fruit_corn_1788097663505.jpg" "%DEST%\fruit_corn.jpg"
copy /y "%SRC%\fruit_eggplant_1788097575793.jpg" "%DEST%\fruit_eggplant.jpg"
copy /y "%SRC%\fruit_coconut_1788097595343.jpg" "%DEST%\fruit_coconut.jpg"
copy /y "%SRC%\fruit_pineapple_1788097524169.jpg" "%DEST%\fruit_pineapple.jpg"
copy /y "%SRC%\fruit_melon_1788097619147.jpg" "%DEST%\fruit_melon.jpg"
copy /y "%SRC%\fruit_watermelon_1788097541316.jpg" "%DEST%\fruit_watermelon.jpg"

echo.
echo Kopyalama tamamlandı!
echo Şimdi terminalde 'R' tuşuna basarak Hot Restart yapabilirsiniz.
pause
