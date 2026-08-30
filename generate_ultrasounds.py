import os
import math
import random
from PIL import Image, ImageDraw, ImageFilter

def create_noise(width, height, intensity=0.15):
    noise = Image.new("L", (width, height), 0)
    pixels = noise.load()
    for y in range(height):
        for x in range(width):
            val = int(random.gauss(128, 40))
            val = max(0, min(255, val))
            pixels[x, y] = val
    return noise

def create_ultrasound_image(stage, output_path):
    width, height = 600, 600
    img = Image.new("RGB", (width, height), (8, 10, 14))
    draw = ImageDraw.Draw(img)

    # 1. Sektör Koni Alanı
    cone_mask = Image.new("L", (width, height), 0)
    cone_draw = ImageDraw.Draw(cone_mask)
    apex = (width // 2, -40)
    cone_draw.polygon([apex, (30, height), (width - 30, height)], fill=255)
    
    # Koni arka plan eko gradyanı
    for r in range(height, 0, -2):
        alpha = int(25 + (r / height) * 45)
        color = (int(18 + r*0.02), int(24 + r*0.03), int(34 + r*0.04))
        draw.arc([-width*0.2 + (height-r)*0.5, apex[1] - r*0.2, width*1.2 - (height-r)*0.5, r*1.3], 
                 start=35, end=145, fill=color, width=3)

    # Evreye göre Fetüs Çizimi (Sepya-Altın 4D HD Live Tonları veya Akustik Ekojenik Beyaz)
    # Stage 1: 1-8 Hafta (Gebelik Kesesi & Yolk Sac & Embriyo)
    if stage == 1:
        # Gestasyonel Kese
        draw.ellipse([200, 220, 400, 380], fill=(22, 28, 38), outline=(180, 195, 210), width=6)
        draw.ellipse([215, 235, 385, 365], fill=(12, 16, 24))
        # Yolk Sac
        draw.ellipse([250, 270, 290, 310], outline=(220, 230, 240), width=3)
        # Embriyo Kutbu
        draw.rounded_rectangle([300, 280, 345, 315], radius=10, fill=(240, 245, 255))
        # Atan Kalp Parlaması
        draw.ellipse([310, 290, 325, 305], fill=(255, 100, 120))

    # Stage 2: 9-13 Hafta (12. Hafta NT Fetüs Profili)
    elif stage == 2:
        # Amniyotik Membran
        draw.ellipse([140, 150, 460, 450], outline=(100, 120, 140), width=2)
        # Kafa (Kranium)
        draw.ellipse([200, 200, 290, 290], fill=(190, 170, 150), outline=(255, 240, 220), width=5)
        # Yüz Profili & Burun
        draw.polygon([(205, 235), (185, 248), (200, 258), (192, 270), (220, 285)], fill=(230, 210, 190))
        # Ense Kalınlığı (NT Eko Lüsens Alanı)
        draw.arc([195, 210, 285, 285], start=100, end=190, fill=(60, 180, 220), width=4)
        # Omurga (Spine)
        for i in range(12):
            t = i / 11.0
            x = 265 + int(t * 80)
            y = 265 + int(math.sin(t * math.pi) * 60)
            draw.ellipse([x-4, y-4, x+4, y+4], fill=(255, 255, 255))
        # Kollar & Bacaklar
        draw.line([(250, 280), (225, 310), (240, 320)], fill=(240, 220, 200), width=6)
        draw.line([(320, 310), (310, 350), (290, 355)], fill=(240, 220, 200), width=6)
        # Kalp
        draw.ellipse([250, 275, 270, 295], fill=(255, 80, 100))

    # Stage 3: 14-20 Hafta (2. Trimester Erken Dönem)
    elif stage == 3:
        # 3D HD Live Altın-Sepya Sıcaklığı
        draw.ellipse([180, 180, 300, 300], fill=(210, 160, 120), outline=(255, 230, 200), width=6)
        # Burun ve Dudak
        draw.polygon([(190, 230), (165, 245), (180, 255), (170, 268), (200, 285)], fill=(240, 190, 150))
        # Gövde & Sırt
        draw.ellipse([260, 240, 390, 360], fill=(190, 140, 100), outline=(255, 220, 180), width=5)
        # Omurga dizilimi
        for i in range(14):
            t = i / 13.0
            x = 270 + int(t * 110)
            y = 250 + int(math.sin(t * math.pi) * 65)
            draw.ellipse([x-5, y-5, x+5, y+5], fill=(255, 250, 240))
        # El ve Parmaklar yüze yakın
        draw.line([(240, 270), (200, 260), (190, 250)], fill=(250, 200, 160), width=7)
        # Femur Kemiği
        draw.line([(350, 320), (390, 370), (370, 390)], fill=(255, 255, 255), width=7)
        # Kalp Odacıkları
        draw.ellipse([255, 270, 280, 295], fill=(255, 70, 90))

    # Stage 4: 21-27 Hafta (Ayrıntılı 3D/4D Morfoloji)
    elif stage == 4:
        # 4D Canlı Yüz & Detaylı Fetüs
        draw.ellipse([160, 170, 300, 310], fill=(225, 175, 130), outline=(255, 235, 205), width=6)
        # Yüz Profili (Alın, Burun Kemik, Çene)
        draw.polygon([(170, 215), (140, 235), (160, 248), (150, 262), (185, 285)], fill=(250, 200, 160))
        # Burun Kemiği (Nasal Bone) Eko Çizgisi
        draw.line([(155, 230), (170, 220)], fill=(255, 255, 255), width=4)
        # Göz Çukuru ve Kapalı Göz Kapağı
        draw.arc([185, 225, 215, 245], start=10, end=170, fill=(120, 80, 50), width=3)
        # Gövde ve Karın (Abdomen)
        draw.ellipse([250, 230, 420, 380], fill=(200, 150, 110), outline=(255, 225, 190), width=6)
        # Omurga
        for i in range(16):
            t = i / 15.0
            x = 260 + int(t * 140)
            y = 240 + int(math.sin(t * math.pi) * 80)
            draw.ellipse([x-5, y-5, x+5, y+5], fill=(255, 255, 255))
        # Kordon
        draw.line([(310, 330), (340, 380), (370, 360)], fill=(80, 200, 240), width=6)
        # Kalp Dört Odacık
        draw.ellipse([260, 270, 290, 300], fill=(255, 60, 80))

    # Stage 5: 28-34 Hafta (3. Trimester Fetal Büyüme)
    elif stage == 5:
        # Dolgun Yanaklı 4D Yüz
        draw.ellipse([150, 160, 320, 330], fill=(235, 185, 140), outline=(255, 240, 215), width=7)
        draw.polygon([(160, 210), (130, 230), (150, 245), (140, 260), (142, 275), (180, 300)], fill=(255, 205, 165))
        draw.arc([180, 220, 215, 245], start=0, end=180, fill=(140, 90, 60), width=4)
        # Yanak Dolgunluğu
        draw.ellipse([170, 245, 230, 290], fill=(245, 195, 155))
        # Geniş Gövde
        draw.ellipse([240, 220, 460, 410], fill=(215, 165, 125), outline=(255, 235, 200), width=7)
        # Kalp
        draw.ellipse([265, 270, 300, 305], fill=(255, 50, 75))

    # Stage 6: 35-40 Hafta (Doğuma Hazır Tam Bebek)
    else:
        # Büyük Baş ve Yüz
        draw.ellipse([140, 150, 330, 340], fill=(240, 190, 145), outline=(255, 245, 225), width=8)
        draw.polygon([(150, 200), (120, 225), (145, 240), (135, 255), (138, 270), (175, 305)], fill=(255, 210, 170))
        draw.arc([175, 215, 215, 245], start=0, end=180, fill=(150, 100, 70), width=4)
        draw.ellipse([160, 240, 235, 295], fill=(250, 205, 165))
        # Gövde
        draw.ellipse([230, 200, 480, 430], fill=(225, 175, 135), outline=(255, 240, 210), width=8)
        # El yüze dokunuyor
        draw.ellipse([180, 270, 220, 310], fill=(255, 215, 175))
        # Kalp
        draw.ellipse([270, 265, 310, 305], fill=(255, 40, 70))

    # Akustik Gürültü ve Doku Filtresi Ekle (Gerçekçi Ultrason Eko Hissi)
    noise = create_noise(width, height)
    img_blurred = img.filter(ImageFilter.GaussianBlur(radius=1.5))
    
    # Maskele ve kaydet
    final_img = Image.composite(img_blurred, Image.new("RGB", (width, height), (6, 8, 12)), cone_mask)
    final_img.save(output_path, "PNG")
    print(f"Generated: {output_path}")

if __name__ == "__main__":
    out_dir = r"d:\github\hamilelik-app\assets\images"
    os.makedirs(out_dir, exist_ok=True)
    for stage in range(1, 7):
        out_path = os.path.join(out_dir, f"ultrasound_stage{stage}.png")
        create_ultrasound_image(stage, out_path)
    print("All ultrasound stages generated successfully!")
