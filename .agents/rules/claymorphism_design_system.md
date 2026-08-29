# Claymorphism UI Tasarım Sistemi Kuralı

Projedeki tüm kullanıcı arayüzü (UI), ekranlar, widget'lar ve bileşenler aşağıdaki Claymorphism kurallarına harfiyen uygun olarak tasarlanacaktır:

---

## 1. Temel Tanım ve Stil Yönergesi (Master Prompt)

> **"Create the surface using claymorphism. Defining signals: the clay shadow recipe on cards and buttons — two inner shadows (light at top, darker at bottom) plus one soft outer drop shadow, e.g. `box-shadow: 0 24px 40px rgba(x,.18), inset 0 -8px 16px rgba(x,.15), inset 0 8px 16px rgba(255,255,255,.55)`; oversized corner radii (border-radius roughly 26px on a 56px control); each element independently colored in light pastels, clearly floating above a soft tinted background; chunky friendly type. Keep the exact hues and illustration flexible. Do not drift into neumorphism: the decisive difference is that clay objects have their own color and a visible drop shadow — never the background's color with shadows alone implying shape. Preserve 4.5:1 text contrast on pastel fills, pressed/hover states that deepen the inner shadows rather than removing them, and visible focus rings."**

---

## 2. Claymorphism Uygulama Prensipleri

### A. Gölge Formülü (Clay Shadow Recipe)
1. **Üst İç Işık (Light Inner Shadow - Top):** `inset 0 8px 16px rgba(255, 255, 255, 0.55 - 0.70)` (Nesneye kabarıklık ve yumuşak plastisite hissi verir).
2. **Alt İç Gölge (Darker Inner Shadow - Bottom):** `inset 0 -8px 16px rgba(x, .15 - .25)` (Nesnenin alt kıvrımını belirginleştirir).
3. **Yumuşak Dış Düşen Gölge (Soft Outer Drop Shadow):** `0 24px 40px rgba(x, .18)` (Nesneyi arka plandan net bir şekilde havaya kaldırır).

### B. Köşe Yuvarlaklığı (Oversized Corner Radii)
- 56px yüksekliğindeki buton ve input kontrollerinde en az `26px` border-radius.
- Kartlarda `30px - 34px` border-radius.
- Rozet ve hap butonlarda tam oval (pill / 999px).

### C. Bağımsız Pastel Renkler (Floating Light Pastels)
- Asla Neumorphism gibi arka planla aynı renk yapılmaz. Her kart ve buton bağımsız, canlı ve sevimli bir pastel renge sahiptir (Romantik Gül Pembesi, Şeftali, Lavanta, Nane Yeşili, Bebek Mavisi, Krem).
- Arka plan daima yumuşak tonlu (soft tinted background) bir renktir (`#FDF7F4`).

### D. Tipografi & Kontrast
- Tıknaz ve dost canlısı (Chunky friendly) yazı tipleri (`Outfit`, `Quicksand`, `Nunito`).
- Pastel yüzeyler üzerinde metin kontrastı en az **4.5:1 (WCAG AA)** standardında tutulur. Koyu başlıklar için `#7A213D`, `#2D232E`, `#5C4F53` gibi kontrastlı renkler kullanılır.

### E. Etkileşim & Odaklanma (Hover / Pressed / Focus)
- **Pressed (Basılma):** İç gölgeler kaybolmaz, aksine derinleşir (`inset 0 -12px 20px ...`), dış gölge küçülür.
- **Focus:** Erişilebilirlik için görünür ve estetik odak halkası (visible focus ring) sağlanır.
