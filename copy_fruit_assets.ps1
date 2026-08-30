$src = "C:\Users\ismai\.gemini\antigravity-ide\brain\3fd5e23f-3adc-4496-9e1f-4efd6b57fac6"
$dest = "d:\github\hamilelik-app\assets\images"

$fruits = @{
    "fruit_seed"       = "fruit_seed_1788097558927.jpg"
    "fruit_blueberry"  = "fruit_blueberry_1788097505472.jpg"
    "fruit_strawberry" = "fruit_strawberry_1788097459744.jpg"
    "fruit_lemon"      = "fruit_lemon_1788097474377.jpg"
    "fruit_peach"      = "fruit_peach_1788097641791.jpg"
    "fruit_avocado"    = "fruit_avocado_1788097445163.jpg"
    "fruit_banana"     = "fruit_banana_1788097489908.jpg"
    "fruit_corn"       = "fruit_corn_1788097663505.jpg"
    "fruit_eggplant"   = "fruit_eggplant_1788097575793.jpg"
    "fruit_coconut"    = "fruit_coconut_1788097595343.jpg"
    "fruit_pineapple"  = "fruit_pineapple_1788097524169.jpg"
    "fruit_melon"      = "fruit_melon_1788097619147.jpg"
    "fruit_watermelon" = "fruit_watermelon_1788097541316.jpg"
}

foreach ($item in $fruits.GetEnumerator()) {
    $sourceFile = Join-Path $src $item.Value
    $destFile = Join-Path $dest ($item.Key + ".jpg")
    if (Test-Path $sourceFile) {
        Copy-Item -Path $sourceFile -Destination $destFile -Force
        Write-Host "Kopyalandı: $($item.Key).jpg" -ForegroundColor Green
    }
}

Write-Host "`nTüm 3D Meyve görselleri assets/images/ dizinine başarıyla kopyalandı!" -ForegroundColor Cyan
Write-Host "Lütfen Flutter terminalinde 'R' (Hot Restart) yapın." -ForegroundColor Yellow
