const config = {
  appRoot: process.cwd(),
  bundleId: "com.balax.pregnancy",
  devices: ["pixel-10-pro"],
  locales: ["tr-TR", "en-US"],
  appearance: "light",
  frame: { variant: "17-pro-orange" },
  theme: {
    background: "linear-gradient(160deg, #FDF7F4 0%, #FEE6E0 55%, #FFF0EB 100%)",
    headlineColor: "#2D232E",
    subheadColor: "#7D6B7D",
    fontFamily: '"Nunito", "Segoe UI", sans-serif',
    copyHeightRatio: 0.22,
    deviceWidthRatio: 0.85,
    template: "none",
    layout: "classic",
  },
  store: {
    name: "Aura Pregnancy",
    subtitle: {
      "tr-TR": "Hafta Hafta Hamilelik & Günlük",
      "en-US": "Week by Week Pregnancy & Journal",
    },
    developer: "Aura Health & Care",
    category: "Health & Fitness",
    rating: 4.9,
    ratingCount: "4.8K Değerlendirme",
    ageRating: "4+",
    price: "Ücretsiz",
    description: {
      "tr-TR": "Aura Pregnancy ile hamilelik yolculuğunuzun her anını sevgiyle kaydedin. Hafta hafta 3D bebek gelişimi, su ve kafein takip sayaçları, tıbbi test takvimi ve romantik anı günlüğü tek bir güvenli uygulamada.",
      "en-US": "Cherish every single moment of your pregnancy journey with Aura Pregnancy. Week by week 3D fetal development, hydration and caffeine logs, medical screening planner and multimedia journal.",
    },
  },
  scenes: [
    {
      kind: "screenshot",
      id: "scene_01_dashboard",
      flow: "store-01-dashboard",
      headline: {
        "tr-TR": "Bebeğinizin Büyümesini 3D İzleyin",
        "en-US": "Watch Your Baby Grow in 3D",
      },
      subhead: {
        "tr-TR": "Hafta hafta 3D fetus modeli ve sevimli meyve boyutları.",
        "en-US": "Interactive 3D fetus model and cute fruit comparisons.",
      },
    },
    {
      kind: "screenshot",
      id: "scene_02_ultrasound",
      flow: "store-02-ultrasound",
      headline: {
        "tr-TR": "Canlı Rahim & Ultrason Görünümü",
        "en-US": "Live Fetus & Ultrasound View",
      },
      subhead: {
        "tr-TR": "Bebeğinizin anne karnındaki duruşunu keşfedin.",
        "en-US": "Visualize fetal movements and womb position.",
      },
    },
    {
      kind: "screenshot",
      id: "scene_03_tracker",
      flow: "store-03-tracker",
      headline: {
        "tr-TR": "Su, Kafein & Tekme Takibi",
        "en-US": "Hydration, Caffeine & Kick Counter",
      },
      subhead: {
        "tr-TR": "Günlük sağlık verilerinizi ve tansiyonunuzu izleyin.",
        "en-US": "Monitor daily wellness limits and blood pressure.",
      },
    },
    {
      kind: "screenshot",
      id: "scene_04_journal",
      flow: "store-04-journal",
      headline: {
        "tr-TR": "Romantik Anı Günlüğü & Ses",
        "en-US": "Romantic Memory Journal & Audio",
      },
      subhead: {
        "tr-TR": "Ultrason fotoğrafları, sesli mektuplar ve anılar.",
        "en-US": "Save ultrasound pics, bump photos and voice notes.",
      },
    },
    {
      kind: "screenshot",
      id: "scene_05_milestones",
      flow: "store-05-milestones",
      headline: {
        "tr-TR": "Tıbbi Test & Tarama Takvimi",
        "en-US": "Medical Screening Calendar",
      },
      subhead: {
        "tr-TR": "Trimester testlerini ve randevularınızı kaçırmayın.",
        "en-US": "Never miss trimester prenatal tests and appointments.",
      },
    },
    {
      kind: "screenshot",
      id: "scene_06_emergency",
      flow: "store-06-emergency",
      headline: {
        "tr-TR": "Hızlı Doktor Kartı & Gizlilik",
        "en-US": "Quick Doctor Card & Privacy",
      },
      subhead: {
        "tr-TR": "Tek tıkla acil arama ve %100 yerel veri güvenliği.",
        "en-US": "One-tap emergency call and 100% on-device privacy.",
      },
    },
  ],
};

export default config;
