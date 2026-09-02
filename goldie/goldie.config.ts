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
    fontFamily: '-apple-system, "Nunito", "Quicksand", system-ui, sans-serif',
    copyHeightRatio: 0.22,
    deviceWidthRatio: 0.85,
    template: "editorial",
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
      id: "dashboard",
      flow: "store-01-dashboard",
      headline: {
        "tr-TR": "Hafta Hafta Bebeğinizin Büyümesi",
        "en-US": "Watch Your Baby Grow Week by Week",
      },
      subhead: {
        "tr-TR": "3D meyve boyutları ve günlük gelişim rehberi.",
        "en-US": "3D fruit sizes and daily developmental insights.",
      },
    },
    {
      kind: "screenshot",
      id: "daily_tracker",
      flow: "store-02-tracker",
      headline: {
        "tr-TR": "Su, Kafein & Sağlık Takibi",
        "en-US": "Hydration, Caffeine & Health Logs",
      },
      subhead: {
        "tr-TR": "Günlük sıvı ve kafein limitlerinizi güvenle izleyin.",
        "en-US": "Stay hydrated and track safe caffeine thresholds.",
      },
    },
    {
      kind: "screenshot",
      id: "weekly_panel",
      flow: "store-03-weekly",
      headline: {
        "tr-TR": "Tıbbi Test & Tarama Takvimi",
        "en-US": "Medical Tests & Milestone Checklist",
      },
      subhead: {
        "tr-TR": "Trimester bazlı kritik testleri ve aşıları kaçırmayın.",
        "en-US": "Never miss trimester screening tests and ultrasound visits.",
      },
    },
    {
      kind: "screenshot",
      id: "timeline",
      flow: "store-04-timeline",
      headline: {
        "tr-TR": "Romantik Anı Günlüğü",
        "en-US": "Romantic Memory Journal",
      },
      subhead: {
        "tr-TR": "Fotoğraf ve ses kayıtlarıyla hatıralarınızı saklayın.",
        "en-US": "Preserve ultrasound photos and audio notes forever.",
      },
    },
    {
      kind: "preview",
      id: "preview",
      segments: [
        { id: "open", flow: "store-preview-01-open", holdSeconds: 3 },
        { id: "water", flow: "store-preview-02-water", holdSeconds: 2 },
        { id: "journal", flow: "store-preview-03-journal", holdSeconds: 3 },
      ],
    },
  ],
};

export default config;
