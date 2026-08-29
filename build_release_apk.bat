@echo off
set "JAVA_HOME=C:\Program Files\Eclipse Adoptium\jdk-17.0.20.101-hotspot"
set "PATH=%JAVA_HOME%\bin;%PATH%"

echo ===================================================
echo [1/4] Kilitli Gradle dosyalari ve surecleri temizleniyor...
echo ===================================================
call flutter config --jdk-dir "%JAVA_HOME%"

if exist "android\.gradle" (
    echo - Eski kilit dosyalari temizleniyor...
    del /f /q /s "android\.gradle\*.lock" >nul 2>&1
)

echo.
echo ===================================================
echo [2/4] Flutter Release APK derleniyor...
echo ===================================================
call flutter build apk --release --android-skip-build-dependency-validation

echo.
echo ===================================================
echo [3/4] Islem tamamlandi!
echo APK Konumu: build\app\outputs\flutter-apk\app-release.apk
echo ===================================================
pause
