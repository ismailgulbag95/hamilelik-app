import os
import shutil

brain_uploaded_dir = r"C:\Users\ismai\.gemini\antigravity-ide\brain\2d687285-9103-42a7-9274-aa547f91f9b2\.user_uploaded"
images_dir = r"d:\github\hamilelik-app\assets\images"
backup_dir = r"d:\github\hamilelik-app\assets\images\old_stages_backup"

os.makedirs(images_dir, exist_ok=True)
os.makedirs(backup_dir, exist_ok=True)

# 1. Eski 6 evreyi yedekle
print("1. Mevcut evreler yedekleniyor...")
for i in range(1, 7):
    old_file = os.path.join(images_dir, f"womb_stage{i}.jpg")
    if os.path.exists(old_file):
        shutil.copy2(old_file, os.path.join(backup_dir, f"old_womb_stage{i}.jpg"))
        print(f"   Yedeklendi: womb_stage{i}.jpg -> backup/old_womb_stage{i}.jpg")

# 2. Yeni 4 görseli yükleme dizininden al
new_img_5w  = os.path.join(brain_uploaded_dir, "media_1788422655394.jpg") # 5-6 hafta (Kalp tüpü & Yolk)
new_img_16w = os.path.join(brain_uploaded_dir, "media_1788422655438.jpg") # 15-16 hafta (Başparmak emme)
new_img_26w = os.path.join(brain_uploaded_dir, "media_1788422655478.jpg") # 25-26 hafta (Gözlerin açılışı)
new_img_32w = os.path.join(brain_uploaded_dir, "media_1788422655498.jpg") # 31-32 hafta (Tombul yanak & REM)

# 3. 10 Evreli Mükemmel Kronolojik Sıralamayı Oluştur
stage_mapping = {
    1: new_img_5w,                                               # 1-6. Hafta: İlk Kalp Atımı & Erken Embriyo
    2: os.path.join(backup_dir, "old_womb_stage1.jpg"),          # 7-9. Hafta: 8. Hafta Embriyo
    3: os.path.join(backup_dir, "old_womb_stage2.jpg"),          # 10-13. Hafta: 11-12. Hafta Fetus
    4: new_img_16w,                                              # 14-17. Hafta: 15-16. Hafta Başparmak Emme
    5: os.path.join(backup_dir, "old_womb_stage3.jpg"),          # 18-21. Hafta: 18-20. Hafta Fetus & Tekmeler
    6: os.path.join(backup_dir, "old_womb_stage4.jpg"),          # 22-25. Hafta: 22-24. Hafta Morfoloji & Kordon
    7: new_img_26w,                                              # 26-29. Hafta: 25-26. Hafta Gözlerin Açılışı
    8: new_img_32w,                                              # 30-33. Hafta: 31-32. Hafta Tombul Yanaklar & REM
    9: os.path.join(backup_dir, "old_womb_stage5.jpg"),          # 34-36. Hafta: 34-36. Hafta Fetal Büyüme
    10: os.path.join(backup_dir, "old_womb_stage6.jpg"),         # 37-40. Hafta: Doğuma Hazır Bebek
}

print("\n2. 10 Evreli sıralama assets/images dizinine kopyalanıyor...")
for stage_num, src_path in stage_mapping.items():
    dst_path = os.path.join(images_dir, f"womb_stage{stage_num}.jpg")
    if os.path.exists(src_path):
        shutil.copy2(src_path, dst_path)
        size_kb = os.path.getsize(dst_path) // 1024
        print(f"   [OK] Stage {stage_num:2d} -> womb_stage{stage_num}.jpg ({size_kb} KB)")
    else:
        print(f"   [HATA] Kaynak bulunamadı: {src_path}")

print("\n10 Evre başarıyla kuruldu! Flutter ekranı için Hot Reload yapabilirsiniz.")
