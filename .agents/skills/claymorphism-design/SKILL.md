---
name: claymorphism-design
description: "Claymorphism UI tasarım kuralları, çift iç gölge formülü, yumuşak dış gölge, pastel renk paletleri ve erişilebilirlik standartları."
metadata:
  origin: project-skills
---

# Claymorphism Design Skill

Bu beceri, projede geliştirilen tüm arayüz bileşenlerinin saf Claymorphism tasarım diliyle üretilmesini garanti eder.

## Temel Göstergeler ve Formüller

1. **Gölge Formülü (Clay Shadow Recipe):**
   ```css
   box-shadow: 
     0 24px 40px rgba(x, 0.18),             /* Yumuşak dış taban gölgesi */
     inset 0 -8px 16px rgba(x, 0.15),       /* Alt iç koyu gölge */
     inset 0 8px 16px rgba(255, 255, 255, 0.55); /* Üst iç beyaz ışık */
   ```
2. **Köşe Yuvarlaklığı (Oversized Corner Radii):**
   - 56px kontrollerde `border-radius: ~26px`
   - Kartlarda `border-radius: 30px - 34px`
   - Rozet ve butonlarda `border-radius: 999px` (Pill)
3. **Bağımsız Pastel Renkler (Floating Light Pastels):**
   - Her eleman yumuşak tonlu arka plan üzerinde bağımsız renkli bir yüzeye sahiptir.
   - Neumorphism'e kayılmaz; nesnenin kendi dolgu rengi vardır.
4. **4.5:1 Metin Kontrastı:**
   - Açık pastel zeminler üzerinde daima yüksek kontrastlı başlık ve metin renkleri kullanılır (`#7A213D`, `#2D232E`).
5. **Etkileşim Durumları (Pressed / Active):**
   - Basıldığında iç gölgeler daha da derinleşir (`inset 0 -12px 20px ...`).
