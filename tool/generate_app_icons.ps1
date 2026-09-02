Add-Type -AssemblyName System.Drawing

$srcPath = "C:\Users\YSR_MONSTER\.gemini\antigravity-ide\brain\c4e4a1f7-1716-41fd-a437-3d8d10f8c01e\aura_app_icon_1788374954266.jpg"

if (-not (Test-Path $srcPath)) {
    Write-Error "Source image not found: $srcPath"
    exit 1
}

$srcImage = [System.Drawing.Image]::FromFile($srcPath)

function Resize-And-Save {
    param (
        [System.Drawing.Image]$Image,
        [int]$Width,
        [int]$Height,
        [string]$DestPath
    )

    $parentDir = Split-Path -Parent $DestPath
    if (-not (Test-Path $parentDir)) {
        New-Item -ItemType Directory -Path $parentDir -Force | Out-Null
    }

    $destBmp = New-Object System.Drawing.Bitmap $Width, $Height
    $graphics = [System.Drawing.Graphics]::FromImage($destBmp)
    $graphics.InterpolationMode = [System.Drawing.Drawing2D.InterpolationMode]::HighQualityBicubic
    $graphics.SmoothingMode = [System.Drawing.Drawing2D.SmoothingMode]::HighQuality
    $graphics.PixelOffsetMode = [System.Drawing.Drawing2D.PixelOffsetMode]::HighQuality
    $graphics.CompositingQuality = [System.Drawing.Drawing2D.CompositingQuality]::HighQuality

    $graphics.DrawImage($Image, 0, 0, $Width, $Height)
    $graphics.Dispose()

    $destBmp.Save($DestPath, [System.Drawing.Imaging.ImageFormat]::Png)
    $destBmp.Dispose()
    Write-Host "Created: $DestPath (${Width}x${Height})"
}

# Assets folders
Resize-And-Save $srcImage 1024 1024 "c:\Users\YSR_MONSTER\hamilelik\assets\images\app_icon.png"
Resize-And-Save $srcImage 1024 1024 "c:\Users\YSR_MONSTER\hamilelik\assets\images\logo.png"
Resize-And-Save $srcImage 1024 1024 "c:\Users\YSR_MONSTER\hamilelik\assets\icon\appstore-1024.png"
Resize-And-Save $srcImage 512 512 "c:\Users\YSR_MONSTER\hamilelik\assets\icon\playstore-512.png"

# iOS AppIcon.appiconset
$iosDir = "c:\Users\YSR_MONSTER\hamilelik\ios\Runner\Assets.xcassets\AppIcon.appiconset"
Resize-And-Save $srcImage 1024 1024 "$iosDir\Icon-App-1024x1024@1x.png"
Resize-And-Save $srcImage 20 20 "$iosDir\Icon-App-20x20@1x.png"
Resize-And-Save $srcImage 40 40 "$iosDir\Icon-App-20x20@2x.png"
Resize-And-Save $srcImage 60 60 "$iosDir\Icon-App-20x20@3x.png"
Resize-And-Save $srcImage 29 29 "$iosDir\Icon-App-29x29@1x.png"
Resize-And-Save $srcImage 58 58 "$iosDir\Icon-App-29x29@2x.png"
Resize-And-Save $srcImage 87 87 "$iosDir\Icon-App-29x29@3x.png"
Resize-And-Save $srcImage 40 40 "$iosDir\Icon-App-40x40@1x.png"
Resize-And-Save $srcImage 80 80 "$iosDir\Icon-App-40x40@2x.png"
Resize-And-Save $srcImage 120 120 "$iosDir\Icon-App-40x40@3x.png"
Resize-And-Save $srcImage 120 120 "$iosDir\Icon-App-60x60@2x.png"
Resize-And-Save $srcImage 180 180 "$iosDir\Icon-App-60x60@3x.png"
Resize-And-Save $srcImage 76 76 "$iosDir\Icon-App-76x76@1x.png"
Resize-And-Save $srcImage 152 152 "$iosDir\Icon-App-76x76@2x.png"
Resize-And-Save $srcImage 167 167 "$iosDir\Icon-App-83.5x83.5@2x.png"

# Android mipmap icons
$androidRes = "c:\Users\YSR_MONSTER\hamilelik\android\app\src\main\res"
Resize-And-Save $srcImage 48 48 "$androidRes\mipmap-mdpi\ic_launcher.png"
Resize-And-Save $srcImage 72 72 "$androidRes\mipmap-hdpi\ic_launcher.png"
Resize-And-Save $srcImage 96 96 "$androidRes\mipmap-xhdpi\ic_launcher.png"
Resize-And-Save $srcImage 144 144 "$androidRes\mipmap-xxhdpi\ic_launcher.png"
Resize-And-Save $srcImage 192 192 "$androidRes\mipmap-xxxhdpi\ic_launcher.png"

# Web icons & favicon
$webDir = "c:\Users\YSR_MONSTER\hamilelik\web"
Resize-And-Save $srcImage 32 32 "$webDir\favicon.png"
Resize-And-Save $srcImage 192 192 "$webDir\icons\Icon-192.png"
Resize-And-Save $srcImage 512 512 "$webDir\icons\Icon-512.png"
Resize-And-Save $srcImage 192 192 "$webDir\icons\Icon-maskable-192.png"
Resize-And-Save $srcImage 512 512 "$webDir\icons\Icon-maskable-512.png"

$srcImage.Dispose()
Write-Host "All iOS, Android, and Web app icons generated successfully!"
