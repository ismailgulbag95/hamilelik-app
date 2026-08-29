/// Aura Pregnancy - Hafta Hafta Tıbbi Bilgilendirme ve Gelişim Veritabanı (1 - 40 Hafta)
class WeeklyMedicalData {
  /// Haftalık Bebek ve Anne Gelişim Verisi Modeli
  static Map<int, Map<String, dynamic>> getWeeklyData() {
    return {
      1: {
        'fruit': '✨',
        'fruit_name': 'Yolculuk Başlangıcı',
        'length': '0 mm',
        'weight': '0 gr',
        'baby_dev': 'Gebelik süreci son adet tarihinizin ilk günüyle başlar. Vücudunuz döllenmeye hazırlanıyor.',
        'mother_changes': 'Hormon seviyeleri değişmeye başlar, folik asit takviyesine devam edin.',
      },
      4: {
        'fruit': '🌱',
        'fruit_name': 'Haşhaş Tohumu',
        'length': '1 mm',
        'weight': '< 1 gr',
        'baby_dev': 'Blastokist rahme yerleşti. Plasenta ve amniyotik kese oluşmaya başladı.',
        'mother_changes': 'Adet gecikmesi, hafif koku hassasiyeti ve göğüslerde dolgunluk hissedilebilir.',
      },
      8: {
        'fruit': '🫐',
        'fruit_name': 'Yaban Mersini',
        'length': '16 mm',
        'weight': '1 gr',
        'baby_dev': 'Kalbi dakikada yaklaşık 150-160 atıyor. El ve ayak parmak tomurcukları belirginleşiyor.',
        'mother_changes': 'Sabah bulantıları ve yorgunluk hissi en yoğun döneminde olabilir.',
      },
      10: {
        'fruit': '🍓',
        'fruit_name': 'Çilek',
        'length': '31 mm',
        'weight': '4 gr',
        'baby_dev': 'Embriyonik dönem tamamlandı, artık fetüs olarak adlandırılıyor. Tüm hayati organlar oluştu.',
        'mother_changes': 'Rahim bir portakal büyüklüğüne ulaştı. Bel çevresinde hafif genişleme başlar.',
        'milestone_test': {
          'code': 'NIPT',
          'title': '🧬 Non-invaziv Prenatal Test (NIPT)',
          'desc': 'Kromozomal anomalileri (Down Sendromu vb.) anne kanındaki serbest fetal DNA ile %99 doğrulukla taramak için 10. haftadan itibaren NIPT testi yapılabilir.',
          'action': 'Doktorunuzla NIPT seçeneğini değerlendirin.'
        }
      },
      11: {
        'fruit': '🍋',
        'fruit_name': 'Misket Limonu',
        'length': '41 mm',
        'weight': '7 gr',
        'baby_dev': 'Kemikleri sertleşmeye başladı, tırnak yatakları ve saç kökleri oluşuyor.',
        'mother_changes': 'Bulantılar yavaş yavaş hafiflemeye başlayabilir, kan hacmi artıyor.',
        'milestone_test': {
          'code': 'NT_DOUBLE_START',
          'title': '🩺 İkili Tarama Testi Başlangıcı (11-13. Hafta)',
          'desc': 'Ense kalınlığı (NT) ultrason ölçümü ve kan tahlili (PAPP-A, serbest β-hCG) için randevunuzu planlayın.',
          'action': '11-13+6 haftalar arasında ikili test randevusu alın.'
        }
      },
      12: {
        'fruit': '🍑',
        'fruit_name': 'Erik / Şeftali Tomurcuğu',
        'length': '54 mm',
        'weight': '14 gr',
        'baby_dev': 'Refleksleri gelişiyor, parmaklarını açıp kapayabiliyor ve hıçkırabiliyor.',
        'mother_changes': 'Rahim pelvisin dışına çıkmaya başlar. İdrara çıkma sıklığı bir miktar azalabilir.',
        'milestone_test': {
          'code': 'DOUBLE_TEST',
          'title': '📋 İkili Tarama Testi ve NT Ölçümü',
          'desc': 'Ense kalınlığı (NT) ultrasonu ve kan biyokimyası ile en kritik birinci trimester taraması bu hafta uygulanmalıdır.',
          'action': 'İkili tarama sonucunuzu kadın doğum uzmanınızla görüşün.'
        }
      },
      14: {
        'fruit': '🍋',
        'fruit_name': 'Limon',
        'length': '8.7 cm',
        'weight': '43 gr',
        'baby_dev': '2. Trimester başlangıcı! Yüz kasları gelişti, kaşlarını çatabilir veya gülümseyebilir.',
        'mother_changes': 'Enerjiniz geri geliyor, bulantılar büyük oranda geriler. "Hamilelik ışıltısı" dönemi.',
      },
      16: {
        'fruit': '🥑',
        'fruit_name': 'Avokado',
        'length': '11.6 cm',
        'weight': '100 gr',
        'baby_dev': 'Gözleri ışığa duyarlı hale geldi. Bacakları kollarından daha uzun ve hareketli.',
        'mother_changes': 'Bazı anneler minik kelebek kanadı gibi ilk seğirmeleri hissetmeye başlayabilir.',
        'milestone_test': {
          'code': 'TRIPLE_QUAD',
          'title': '🧪 Üçlü / Dörtlü Tarama Testi (15-18. Hafta)',
          'desc': 'AFP, hCG, estriol ve inhibin-A değerlerinin inceleneceği biyokimyasal tarama testi bu haftalarda planlanır.',
          'action': 'İkili test yapılmadıysa veya ek değerlendirme gerekiyorsa doktorunuza danışın.'
        }
      },
      18: {
        'fruit': '🥒',
        'fruit_name': 'Dolmalık Biber',
        'length': '14.2 cm',
        'weight': '190 gr',
        'baby_dev': 'Kulakları tam yerini aldı ve sesleri duyabiliyor! Sizin sesinizi ve kalp atışınızı dinliyor.',
        'mother_changes': 'Tansiyonunuz biraz düşebilir, ani ayağa kalkmalarda baş dönmesine dikkat edin.',
      },
      20: {
        'fruit': '🍌',
        'fruit_name': 'Muz',
        'length': '25.6 cm',
        'weight': '300 gr',
        'baby_dev': 'Yolun yarısı! Cildi verniks kazeoza adlı koruyucu kremsi tabaka ile kaplanıyor.',
        'mother_changes': 'Göbek deliğiniz hafifçe dışarı çıkabilir. Bebek tekmeleri artık net hissedilir.',
        'milestone_test': {
          'code': 'DETAILED_USG',
          'title': '🔍 Ayrıntılı Ultrason (2. Trimester Morfoloji Taraması)',
          'desc': 'Bebeğin tüm organları, beyni, kalbi, omurgası, böbrekleri ve uzuvları perinatolog/uzman tarafından milimetrik incelenir.',
          'action': '20-22. haftalarda Ayrıntılı Ultrason randevunuzu mutlaka yaptırınız.'
        }
      },
      24: {
        'fruit': '🌽',
        'fruit_name': 'Mısır Koçanı',
        'length': '30.0 cm',
        'weight': '600 gr',
        'baby_dev': 'Akciğerlerinde sürfaktan maddesi üretilmeye başlandı. Tat tomurcukları tamamen gelişti.',
        'mother_changes': 'Gözlerde kuruluk ve ciltte gerilme hissedilebilir, bol su için.',
        'milestone_test': {
          'code': 'OGTT_DIABETES',
          'title': '🩸 Gestasyonel Diyabet Taraması (Şeker Yükleme Testi)',
          'desc': '50 gr glukoz yükleme testi ile gebelik şekeri taraması 24-28. haftalar arasında uygulanır.',
          'action': 'Açlık kan şekeri ve 50 gr glukoz taramasını yaptırın.'
        }
      },
      28: {
        'fruit': '🍆',
        'fruit_name': 'Büyük Patlıcan',
        'length': '37.6 cm',
        'weight': '1000 gr (1 kg)',
        'baby_dev': '3. Trimester başladı! Gözlerini açıp kapayabiliyor, REM uykusu fazına geçiyor ve rüya görüyor.',
        'mother_changes': 'Ayak bileklerinde hafif şişlikler ve nefes darlığı hissedilebilir, dinlenmeye özen gösterin.',
        'milestone_test': {
          'code': 'ANTI_D_NST',
          'title': '💉 Anti-D İğnesi & NST Kontrolleri Başlangıcı',
          'desc': 'Anne Rh (-) negatif, baba Rh (+) pozitif ise kan uyuşmazlığı iğnesi (Anti-D immünglobulin) bu hafta uygulanır. Rutin NST takipleri planlanır.',
          'action': 'Kan grubunuz Rh negatifse doktorunuza Anti-D aşısını hatırlatın.'
        }
      },
      32: {
        'fruit': '🍍',
        'fruit_name': 'Ananas',
        'length': '42.4 cm',
        'weight': '1700 gr',
        'baby_dev': 'Tüm tırnakları uzadı, kemikleri güçlü. Yağ depolamaya devam ederek tombişleşiyor.',
        'mother_changes': 'Braxton Hicks (hazırlık) kasılmaları hissedilebilir. Doğum çantası hazırlığına başlayın.',
      },
      36: {
        'fruit': '🥬',
        'fruit_name': 'Marul / Kavun',
        'length': '47.4 cm',
        'weight': '2600 gr',
        'baby_dev': 'Doğum pozisyonu almaya (baş aşağı dönmeye) başladı. Akciğer gelişimi neredeyse tamamlandı.',
        'mother_changes': 'Bebek aşağı indiğinde mide yanmanız hafifleyebilir, ancak mesane baskısı artar.',
      },
      40: {
        'fruit': '🍉',
        'fruit_name': 'Karpuz',
        'length': '51.2 cm',
        'weight': '3400 gr',
        'baby_dev': 'Büyük gün geldi! Bebeğiniz tamamen hazır ve sizinle kavuşmayı bekliyor.',
        'mother_changes': 'Düzenli sancılar, nişan gelmesi veya su sızıntısı durumunda hemen doktorunuza haber verin.',
      }
    };
  }

  /// Belirtilen haftanın en yakın tıbbi bilgisini döndürür
  static Map<String, dynamic> getInfoForWeek(int week) {
    final data = getWeeklyData();
    if (data.containsKey(week)) {
      return data[week]!;
    }
    // Eğer o hafta tam yoksa en yakın alt haftayı al
    int closest = 1;
    for (var k in data.keys) {
      if (k <= week && k > closest) closest = k;
    }
    final base = data[closest]!;
    return {
      'fruit': '✨',
      'fruit_name': '$week. Hafta Gelişimi',
      'length': '~${(week * 1.25).toStringAsFixed(1)} cm',
      'weight': '~${(week * 85)} gr',
      'baby_dev': base['baby_dev'],
      'mother_changes': base['mother_changes'],
      'milestone_test': base['milestone_test'],
    };
  }
}
