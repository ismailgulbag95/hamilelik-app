---
name: sqlite-database-master
description: "SQLite yerel veritabanı şema tasarımı, indeksleme, CRUD optimizasyonu ve güvenli veri saklama becerisi."
metadata:
  origin: project-skills
---

# SQLite Database Master Skill

Yerel mobil veritabanı mimarisi, güvenli şifreli yerel depolama ve sorgu optimizasyonu.

## Prensipler
1. **İndeksleme:** Tarih (`date`) ve gebelik haftası (`pregnancy_week`) gibi sık filtrelenen alanlara `CREATE INDEX` eklenir.
2. **Conflict Resolution:** Günlük loglarda `ConflictAlgorithm.replace` ile veri çakışmaları engellenir.
3. **Lazy Initialization:** Veritabanı bağlantısı singleton ve lazy yükleme ile yönetilir.
