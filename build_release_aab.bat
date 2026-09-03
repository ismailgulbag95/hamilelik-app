@echo off
set "JAVA_HOME=C:\Program Files\Android\Android Studio\jbr"
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
echo [2/4] Flutter Release AAB derleniyor...
echo ===================================================
call flutter build appbundle --release --android-skip-build-dependency-validation

echo.
echo ===================================================
echo [3/4] Islem tamamlandi!
echo AAB Konumu: build\app\outputs\bundle\release\app-release.aab
echo ===================================================
