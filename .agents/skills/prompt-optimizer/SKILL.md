---
name: prompt-optimizer
description: "Kullanıcı veya yapay zeka ajanları için istemleri (prompts) analiz eden, yapılandıran, netlik, bağlam, kısıtlamalar ve çıktı formatı açısından en yüksek performansa ulaştıran Prompt Engineering ve Optimizasyon becerisi."
metadata:
  origin: custom
---

# Prompt Optimizer Skill

Bu beceri, LLM ve AI ajanlarına yönelik kullanıcı istemlerini (prompts) analiz ederek en yüksek doğruluk, determinizm ve kaliteyi sağlayacak şekilde yeniden yapılandırır ve optimize eder.

---

## 🎯 Temel Prensipler (Prompt Engineering Framework)

Bir prompt optimize edilirken 6 temel yapı taşı eksiksiz olarak kurgulanır:

1. **Rol ve Uzmanlık (Role & Persona):** Modelin hangi uzman kimliğiyle ve derinlikle yanıt vereceğini belirler.
2. **Görev Tanımı (Task & Objective):** Yapılması istenen işin net, eyleme dönük ve ölçülebilir tanımı.
3. **Bağlam ve Girdiler (Context & Inputs):** Görevin hangi şartlar altında, hangi veri ve referanslarla işleneceği (`<context>`, `<input>` etiketleri).
4. **Kısıtlamalar ve Negatif Kurallar (Constraints & Guardrails):** Asla yapılmaması gerekenler, sınırlar, güvenlik ve doğruluk kuralları.
5. **Çıktı Formatı ve Şeması (Output Specification):** JSON, Markdown, kod bloğu, maddeleme gibi beklenen kesin yanıt biçimi.
6. **Örnekler (Few-Shot Examples):** İhtiyaç duyulan stil veya şemayı modelleyen girdi/çıktı örnekleri.

---

## 🛠️ Prompt Optimizasyon Protokolü

Kullanıcı bir prompt'u geliştirmek istediğinde aşağıdaki 4 adımlı süreç uygulanır:

### Adım 1: Niyet ve Eksiklik Analizi
- Prompttaki belirsizlikler, ucu açık ifadeler ve eksik kısıtlamalar tespit edilir.
- Çıktı formatının net olup olmadığı değerlendirilir.

### Adım 2: Yapısal Düzenleme (XML / Markdown Etiketleme)
Girdiler ve yönergeler birbirine karışmayacak şekilde etiketlenir:
```markdown
<role>
Sen kıdemli bir Flutter ve Dart mimarısın.
</role>

<context>
[İlgili arka plan bilgisi ve ortam]
</context>

<instructions>
1. [Adım 1]
2. [Adım 2]
</instructions>

<constraints>
- [Kural 1: Örn. Asla harici paket kullanma]
- [Kural 2: Örn. 4.5:1 kontrast standardını koru]
</constraints>

<output_format>
[Beklenen format açıklaması]
</output_format>
```

### Adım 3: Düşünme Zinciri ve Kendini Doğrulama (CoT & Verification)
- Karmaşık görevlerde modele "Adım adım düşün" veya doğrulama kontrol listesi eklenir.

### Adım 4: Karşılaştırmalı Sunum
- **Orijinal Prompt:** Kullanıcının verdiği ham metin.
- **Optimize Edilmiş Prompt:** Kullanıma hazır, zenginleştirilmiş nihai versiyon.
- **Yapılan İyileştirmeler:** Neden bu değişikliklerin yapıldığına dair kısa ve net gerekçeler.

---

## 📋 Örnek Optimizasyon Şablonu

```markdown
### 🚀 Optimize Edilmiş Prompt:

<role>
[Belirlenen rol]
</role>

<task>
[Net görev tanımı]
</task>

<context>
[Gerekli tüm bağlam bilgisi]
</context>

<guidelines>
- [Rehber ilke 1]
- [Rehber ilke 2]
</guidelines>

<constraints>
- [Kısıtlama 1]
- [Kısıtlama 2]
</constraints>

<output_format>
[Çıktı şablonu]
</output_format>
```
