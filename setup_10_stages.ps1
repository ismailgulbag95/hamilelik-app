$brainDir = "C:\Users\ismai\.gemini\antigravity-ide\brain\2d687285-9103-42a7-9274-aa547f91f9b2\.user_uploaded"
$imagesDir = "d:\github\hamilelik-app\assets\images"
$backupDir = "d:\github\hamilelik-app\assets\images\old_stages_backup"

if (!(Test-Path $backupDir)) {
    New-Item -ItemType Directory -Force -Path $backupDir | Out-Null
}

Write-Host "1. Eski evreler yedekleniyor..." -ForegroundColor Cyan
for ($i = 1; $i -le 6; $i++) {
    $oldFile = Join-Path $imagesDir "womb_stage$i.jpg"
    if (Test-Path $oldFile) {
        Copy-Item -Path $oldFile -Destination (Join-Path $backupDir "old_womb_stage$i.jpg") -Force
    }
}

$mapping = @{
    1  = (Join-Path $brainDir "media_1788422655394.jpg")
    2  = (Join-Path $backupDir "old_womb_stage1.jpg")
    3  = (Join-Path $backupDir "old_womb_stage2.jpg")
    4  = (Join-Path $brainDir "media_1788422655438.jpg")
    5  = (Join-Path $backupDir "old_womb_stage3.jpg")
    6  = (Join-Path $backupDir "old_womb_stage4.jpg")
    7  = (Join-Path $brainDir "media_1788422655478.jpg")
    8  = (Join-Path $brainDir "media_1788422655498.jpg")
    9  = (Join-Path $backupDir "old_womb_stage5.jpg")
    10 = (Join-Path $backupDir "old_womb_stage6.jpg")
}

Write-Host "`n2. 10 Evreli Fetus siralamasi assets/images dizinine kopyalaniyor..." -ForegroundColor Yellow
foreach ($stageNum in 1..10) {
    $src = $mapping[$stageNum]
    $dst = Join-Path $imagesDir "womb_stage$stageNum.jpg"
    if (Test-Path $src) {
        Copy-Item -Path $src -Destination $dst -Force
        $size = (Get-Item $dst).Length / 1KB
        Write-Host "   [OK] Stage $stageNum -> womb_stage$stageNum.jpg ($([math]::Round($size)) KB)" -ForegroundColor Green
    } else {
        Write-Host "   [HATA] Kaynak bulunamadi: $src" -ForegroundColor Red
    }
}

Write-Host "`n10 Evre basariyla kuruldu! Flutter terminalinde 'r' veya 'R' basarak yenileyebilirsiniz." -ForegroundColor Cyan
