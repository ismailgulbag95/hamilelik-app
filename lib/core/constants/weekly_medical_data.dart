import 'package:flutter/material.dart';

/// Aura Pregnancy - Hafta Hafta Tıbbi Bilgilendirme ve Gelişim Veritabanı (1 - 40 Hafta Eksiksiz)
class WeeklyMedicalData {
  /// Haftalık Bebek ve Anne Gelişim Verisi Modeli (1 - 40 Hafta)
  static Map<int, Map<String, dynamic>> getWeeklyData() {
    return {
      1: {
        'icon': Icons.grain_rounded,
        'fruit_name': 'Haşhaş Tohumu Tomurcuğu',
        'length': '0.1 mm',
        'weight': '< 1 gr',
        'baby_dev': 'Gebelik süreci son adet tarihinizin ilk günüyle başlar. Vücudunuz döllenmeye ve yeni bir yaşama hazırlanıyor.',
        'mother_changes': 'Hormon seviyeleri değişmeye başlar, folik asit takviyesine (400-800 mcg) düzenli devam edin.',
      },
      2: {
        'icon': Icons.grain_rounded,
        'fruit_name': 'Minik Tohum Hücresi',
        'length': '0.2 mm',
        'weight': '< 1 gr',
        'baby_dev': 'Yumurtlama ve döllenme gerçekleşir. Genetik mirasın temelleri bu mucizevi anda atılır.',
        'mother_changes': 'Vücut bazal sıcaklığında hafif bir yükselme ve hormonal değişimler başlar.',
      },
      3: {
        'icon': Icons.spa_rounded,
        'fruit_name': 'Vanilya Çekirdeği',
        'length': '0.5 mm',
        'weight': '< 1 gr',
        'baby_dev': 'Döllenmiş zigot hızla bölünerek blastokist halini alır ve fallop tüplerinden rahme doğru ilerler.',
        'mother_changes': 'Rahim içi tabakası kalınlaşır; bazı anne adaylarında hafif yerleşme (implantasyon) hissi olabilir.',
      },
      4: {
        'icon': Icons.spa_rounded,
        'fruit_name': 'Haşhaş Tohumu',
        'length': '1 mm',
        'weight': '< 1 gr',
        'baby_dev': 'Blastokist rahme güvenle yerleşti. Plasenta ve amniyotik kese hızla oluşmaya başladı.',
        'mother_changes': 'Adet gecikmesi, hafif koku hassasiyeti ve göğüslerde dolgunluk hissedilebilir.',
      },
      5: {
        'icon': Icons.radio_button_checked_rounded,
        'fruit_name': 'Susam Tanesi',
        'length': '2 mm',
        'weight': '< 1 gr',
        'baby_dev': 'Nöral tüp (beyin ve omurilik taslağı) şekillenmeye başladı. Kalp tüpü ilk ritmik kıpırtılarına hazırlanıyor.',
        'mother_changes': 'Hafif sabah bulantıları, sık idrara çıkma ve halsizlik görülebilir.',
      },
      6: {
        'icon': Icons.circle_rounded,
        'fruit_name': 'Mercimek Tanesi',
        'length': '4 mm',
        'weight': '< 1 gr',
        'baby_dev': 'Minik kalp dakikada yaklaşık 100-115 vuruşla atmaya başlar. Kol ve bacak tomurcukları belirir.',
        'mother_changes': 'Koku hassasiyeti artabilir. Bol sıvı alımı ve dinlenme önemlidir.',
      },
      7: {
        'icon': Icons.bubble_chart_rounded,
        'fruit_name': 'Yaban Mersini',
        'length': '10 mm',
        'weight': '~1 gr',
        'baby_dev': 'Beyin yarım küreleri hızla gelişiyor. Göz ve kulak kabarcıkları belirginleşmeye başlar.',
        'mother_changes': 'Bulantılar yoğunlaşabilir. Zencefilli çaylar ve kuru krakerler rahatlatıcı olabilir.',
      },
      8: {
        'icon': Icons.scatter_plot_rounded,
        'fruit_name': 'Ahududu',
        'length': '16 mm',
        'weight': '1.5 gr',
        'baby_dev': 'Kalbi dakikada yaklaşık 150-160 atıyor. El ve ayak parmak tomurcukları uzuyor.',
        'mother_changes': 'Rahim büyümeye devam ederken hafif kasık çekilmeleri hissedilebilir.',
      },
      9: {
        'icon': Icons.lens_rounded,
        'fruit_name': 'Yeşil Zeytin',
        'length': '23 mm',
        'weight': '2 gr',
        'baby_dev': 'Göz kapakları ve burun ucu şekilleniyor. Eklem ve kaslar ilk istemsiz minik hareketleri üretir.',
        'mother_changes': 'Hormonlara bağlı duygu durum dalgalanmaları normaldir, dinlenmeye özen gösterin.',
      },
      10: {
        'icon': Icons.eco_rounded,
        'fruit_name': 'Çilek',
        'length': '31 mm',
        'weight': '4 gr',
        'baby_dev': 'Embriyonik dönem tamamlandı, artık resmi olarak bir fetüs! Tüm hayati organ taslakları tamamlandı.',
        'mother_changes': 'Rahim bir portakal büyüklüğüne ulaştı. Bel çevresinde hafif bir yumuşama başlar.',
        'milestone_test': {
          'code': 'NIPT',
          'title': 'Non-invaziv Prenatal Test (NIPT)',
          'desc': 'Kromozomal anomalileri (Down Sendromu vb.) anne kanındaki serbest fetal DNA ile %99 doğrulukla taramak için 10. haftadan itibaren NIPT testi yapılabilir.',
          'action': 'Doktorunuzla NIPT seçeneğini değerlendirin.'
        }
      },
      11: {
        'icon': Icons.brightness_1_rounded,
        'fruit_name': 'Misket Limonu',
        'length': '41 mm',
        'weight': '7 gr',
        'baby_dev': 'Kemikleri sertleşmeye başladı, tırnak yatakları ve saç folikülleri oluşuyor.',
        'mother_changes': 'Bulantılar yavaş yavaş hafiflemeye başlayabilir, kan hacmi ve dolaşım hızlanır.',
        'milestone_test': {
          'code': 'NT_DOUBLE_START',
          'title': 'İkili Tarama Testi Başlangıcı (11-13. Hafta)',
          'desc': 'Ense kalınlığı (NT) ultrason ölçümü ve kan tahlili (PAPP-A, serbest β-hCG) için randevunuzu planlayın.',
          'action': '11-13+6 haftalar arasında ikili test randevusu alın.'
        }
      },
      12: {
        'icon': Icons.brightness_high_rounded,
        'fruit_name': 'Erik / Şeftali Tomurcuğu',
        'length': '54 mm',
        'weight': '14 gr',
        'baby_dev': 'Refleksleri gelişiyor, parmaklarını açıp kapayabiliyor ve hıçkırma hareketleri yapabiliyor.',
        'mother_changes': 'Rahim pelvisin dışına doğru yükselir. Mesane üzerindeki erken baskı bir miktar azalır.',
        'milestone_test': {
          'code': 'DOUBLE_TEST',
          'title': 'İkili Tarama Testi ve NT Ölçümü',
          'desc': 'Ense kalınlığı (NT) ultrasonu ve kan biyokimyası ile en kritik birinci trimester taraması bu hafta uygulanmalıdır.',
          'action': 'İkili tarama sonucunuzu kadın doğum uzmanınızla görüşün.'
        }
      },
      13: {
        'icon': Icons.yard_rounded,
        'fruit_name': 'Bezelye Kabuğu',
        'length': '7.4 cm',
        'weight': '23 gr',
        'baby_dev': '1. Trimesterın son haftası! Ses telleri oluştu, minik parmak izleri şekilleniyor.',
        'mother_changes': 'Enerjiniz kademeli olarak geri gelir; iştahınızda düzelmeler başlar.',
      },
      14: {
        'icon': Icons.flare_rounded,
        'fruit_name': 'Limon',
        'length': '8.7 cm',
        'weight': '43 gr',
        'baby_dev': '2. Trimester başlangıcı! Yüz kasları gelişti, kaşlarını çatabilir veya gülümseyebilir.',
        'mother_changes': 'Enerjiniz geri geliyor, bulantılar büyük oranda geriler. Hamilelik ışıltısı dönemi başlar.',
      },
      15: {
        'icon': Icons.circle_notifications_rounded,
        'fruit_name': 'Elma',
        'length': '10.1 cm',
        'weight': '70 gr',
        'baby_dev': 'Işığı ayırt edebiliyor. İncecik bacakları uzuyor ve kemik mineralizasyonu hızlanıyor.',
        'mother_changes': 'Burun tıkanıklığı hissedilebilir (hamilelik riniti); bol su içmeye devam edin.',
      },
      16: {
        'icon': Icons.nature_rounded,
        'fruit_name': 'Avokado',
        'length': '11.6 cm',
        'weight': '100 gr',
        'baby_dev': 'Gözleri ışığa duyarlı. Bacakları kollarından daha uzun ve eklemleri son derece esnek.',
        'mother_changes': 'Bazı anneler minik kelebek kanadı gibi ilk kıpırtıları hissetmeye başlayabilir.',
        'milestone_test': {
          'code': 'TRIPLE_QUAD',
          'title': 'Üçlü / Dörtlü Tarama Testi (15-18. Hafta)',
          'desc': 'AFP, hCG, estriol ve inhibin-A değerlerinin inceleneceği biyokimyasal tarama testi bu haftalarda planlanır.',
          'action': 'İkili test yapılmadıysa veya ek değerlendirme gerekiyorsa doktorunuza danışın.'
        }
      },
      17: {
        'icon': Icons.grain_rounded,
        'fruit_name': 'Nar',
        'length': '13.0 cm',
        'weight': '140 gr',
        'baby_dev': 'İskeleti kıkırdaktan sert kemik dokusuna dönüşüyor. Yağ dokusu depolamaya başlıyor.',
        'mother_changes': 'İştahınız artabilir. Sağlıklı atıştırmalıklar ve kalsiyum zengini besinler tercih edin.',
      },
      18: {
        'icon': Icons.local_florist_rounded,
        'fruit_name': 'Dolmalık Biber',
        'length': '14.2 cm',
        'weight': '190 gr',
        'baby_dev': 'Kulakları tam yerini aldı ve sesleri duyabiliyor! Sizin sesinizi ve kalp atışınızı dinliyor.',
        'mother_changes': 'Tansiyonunuz bir miktar düşebilir; ani ayağa kalkmalarda dikkatli olun.',
      },
      19: {
        'icon': Icons.brightness_medium_rounded,
        'fruit_name': 'Mango',
        'length': '15.3 cm',
        'weight': '240 gr',
        'baby_dev': 'Beyninde koku, tat, işitme, görme ve dokunma için özelleşmiş merkezler oluşuyor.',
        'mother_changes': 'Ciltte hafif gerilmeler ve çatlak eğilimi görülebilir; nemlendirici bakım uygulayın.',
      },
      20: {
        'icon': Icons.wb_sunny_rounded,
        'fruit_name': 'Muz',
        'length': '25.6 cm',
        'weight': '300 gr',
        'baby_dev': 'Yolun yarısı! Cildi verniks kazeoza adlı koruyucu kremsi tabaka ile kaplanıyor.',
        'mother_changes': 'Göbek deliğiniz hafifçe dışarı çıkabilir. Bebek tekmeleri artık belirgin hissedilir.',
        'milestone_test': {
          'code': 'DETAILED_USG',
          'title': 'Ayrıntılı Ultrason (2. Trimester Morfoloji Taraması)',
          'desc': 'Bebeğin tüm organları, beyni, kalbi, omurgası, böbrekleri ve uzuvları perinatolog/uzman tarafından milimetrik incelenir.',
          'action': '20-22. haftalarda Ayrıntılı Ultrason randevunuzu mutlaka yaptırınız.'
        }
      },
      21: {
        'icon': Icons.eco_rounded,
        'fruit_name': 'Havuç',
        'length': '26.7 cm',
        'weight': '360 gr',
        'baby_dev': 'Kemik iliği kan hücresi üretimine başladı. Bebeğiniz amniyotik sıvıyı düzenli yutkunuyor.',
        'mother_changes': 'Varis ve bacak kramplarını önlemek için ayaklarınızı dinlendirirken yüksekte tutun.',
      },
      22: {
        'icon': Icons.circle_rounded,
        'fruit_name': 'Papaya',
        'length': '27.8 cm',
        'weight': '430 gr',
        'baby_dev': 'Göz kapakları ve kaşları tam olarak şekillendi. Dokunma duyusu son derece hassas.',
        'mother_changes': 'Cildiniz daha parlak görünebilir. Düzenli yürüyüşler sırt ağrılarına iyi gelir.',
      },
      23: {
        'icon': Icons.brightness_7_rounded,
        'fruit_name': 'Greyfurt',
        'length': '28.9 cm',
        'weight': '500 gr',
        'baby_dev': 'Yarım kilo sınırını aştı! Hızlı göz hareketleri (REM uykusu) ile rüya görme fazı başlar.',
        'mother_changes': 'Ayak ve el bileklerinde hafif ödem hissedilebilir; tuz tüketimini dengeleyin.',
      },
      24: {
        'icon': Icons.grass_rounded,
        'fruit_name': 'Mısır Koçanı',
        'length': '30.0 cm',
        'weight': '600 gr',
        'baby_dev': 'Akciğerlerinde sürfaktan maddesi üretilmeye başlandı. Tat tomurcukları tamamen gelişti.',
        'mother_changes': 'Gözlerde kuruluk ve cilt gerginliği hissedilebilir, bol su için.',
        'milestone_test': {
          'code': 'OGTT_DIABETES',
          'title': 'Gestasyonel Diyabet Taraması (Şeker Yükleme Testi)',
          'desc': '50 gr glukoz yükleme testi ile gebelik şekeri taraması 24-28. haftalar arasında uygulanır.',
          'action': 'Açlık kan şekeri ve 50 gr glukoz taramasını yaptırın.'
        }
      },
      25: {
        'icon': Icons.nature_people_rounded,
        'fruit_name': 'Karnabahar',
        'length': '34.6 cm',
        'weight': '660 gr',
        'baby_dev': 'Seslere daha net tepki verir. Omurga yapıları güçleniyor ve nefes alma pratikleri yapıyor.',
        'mother_changes': 'Saçlarınız dökülmek yerine daha gür ve canlı hissedilebilir.',
      },
      26: {
        'icon': Icons.yard_rounded,
        'fruit_name': 'Kabak',
        'length': '35.6 cm',
        'weight': '760 gr',
        'baby_dev': 'Gözlerini aralamaya başlar. Akciğer damarlanması hızla ilerliyor.',
        'mother_changes': 'Braxton Hicks hazırlık kasılmaları hafifçe hissedilmeye başlayabilir.',
      },
      27: {
        'icon': Icons.park_rounded,
        'fruit_name': 'Brokoli',
        'length': '36.6 cm',
        'weight': '875 gr',
        'baby_dev': '2. Trimesterın son haftası! Beyin dokusu katlanarak yüzey alanını genişletiyor.',
        'mother_changes': 'Uyku pozisyonunda sol yana yatış kan dolaşımı için en idealidir.',
      },
      28: {
        'icon': Icons.wb_twilight_rounded,
        'fruit_name': 'Büyük Patlıcan',
        'length': '37.6 cm',
        'weight': '1000 gr (1 kg)',
        'baby_dev': '3. Trimester başladı! Gözlerini açıp kapayabiliyor, REM uykusu fazına geçiyor.',
        'mother_changes': 'Ayak bileklerinde hafif şişlikler ve nefes darlığı hissedilebilir, dinlenmeye özen gösterin.',
        'milestone_test': {
          'code': 'ANTI_D_NST',
          'title': 'Anti-D İğnesi & NST Kontrolleri Başlangıcı',
          'desc': 'Anne Rh (-) negatif, baba Rh (+) pozitif ise kan uyuşmazlığı iğnesi (Anti-D immünglobulin) bu hafta uygulanır. Rutin NST takipleri planlanır.',
          'action': 'Kan grubunuz Rh negatifse doktorunuza Anti-D aşısını hatırlatın.'
        }
      },
      29: {
        'icon': Icons.circle_rounded,
        'fruit_name': 'Balkabağı Dilimi',
        'length': '38.6 cm',
        'weight': '1150 gr',
        'baby_dev': 'Kasları ve akciğerleri güçleniyor. Başını hareket ettirerek çevreye tepki verir.',
        'mother_changes': 'Sık idrara çıkma isteği rahim mesane baskısıyla yeniden artabilir.',
      },
      30: {
        'icon': Icons.filter_vintage_rounded,
        'fruit_name': 'Lahana',
        'length': '39.9 cm',
        'weight': '1320 gr',
        'baby_dev': 'Kemik iliği tamamen kırmızı kan hücresi üretimini üstlendi. Vücut ısısını düzenlemeye başlar.',
        'mother_changes': 'Mide yanması ve reflü durumunda az ve sık beslenmeye özen gösterin.',
      },
      31: {
        'icon': Icons.circle_rounded,
        'fruit_name': 'Hindistan Cevizi',
        'length': '41.1 cm',
        'weight': '1500 gr (1.5 kg)',
        'baby_dev': '5 temel duyunun tümü aktif! Başını bir yandan diğerine rahatça çevirebilir.',
        'mother_changes': 'Doğum çantası hazırlık listelerini oluşturmaya başlamak için harika bir hafta.',
      },
      32: {
        'icon': Icons.star_rounded,
        'fruit_name': 'Ananas',
        'length': '42.4 cm',
        'weight': '1700 gr',
        'baby_dev': 'Tüm tırnakları uzadı, kemikleri güçlü. Yağ depolamaya devam ederek tombişleşiyor.',
        'mother_changes': 'Braxton Hicks kasılmaları belirginleşebilir; rahat nefes egzersizleri yapın.',
      },
      33: {
        'icon': Icons.spa_rounded,
        'fruit_name': 'Kereviz Demeti',
        'length': '43.7 cm',
        'weight': '1900 gr',
        'baby_dev': 'Bağışıklık sistemi anneden geçen antikorlarla güçleniyor. Kemikleri tamamen sertleşti.',
        'mother_changes': 'Pelvik bölgede baskı hissedilebilir; rahat ayakkabılar tercih edin.',
      },
      34: {
        'icon': Icons.circle_rounded,
        'fruit_name': 'Kavun',
        'length': '45.0 cm',
        'weight': '2150 gr',
        'baby_dev': 'Akciğer gelişimi büyük ölçüde tamamlandı. Cildi pembeleşti ve pürüzsüzleşiyor.',
        'mother_changes': 'Dinlenme aralıklarını artırın, ağır yük kaldırmaktan kaçının.',
      },
      35: {
        'icon': Icons.circle_rounded,
        'fruit_name': 'Tatlı Kavun',
        'length': '46.2 cm',
        'weight': '2380 gr',
        'baby_dev': 'Böbrekleri tamamen işlevsel. Çoğu bebek bu haftalarda doğum baş pozisyonunu alır.',
        'mother_changes': 'Bebek aşağı indikçe mide yanmanız hafifleyebilir ancak mesane baskısı artar.',
      },
      36: {
        'icon': Icons.yard_rounded,
        'fruit_name': 'Marul Demeti',
        'length': '47.4 cm',
        'weight': '2600 gr',
        'baby_dev': 'Doğum pozisyonu almaya başladı. Emme ve yutkunma koordinasyonu kusursuz.',
        'mother_changes': 'Haftalık doktor kontrolleri ve NST izlemleri başlayabilir.',
      },
      37: {
        'icon': Icons.grass_rounded,
        'fruit_name': 'Pazı Demeti',
        'length': '48.6 cm',
        'weight': '2850 gr',
        'baby_dev': 'Erken dönem tam miad (Early Term)! Bebeğiniz artık dünyaya gelmeye tıbben hazır.',
        'mother_changes': 'Nişan gelmesi veya su sızıntısı gibi doğum belirtilerine karşı dikkatli olun.',
      },
      38: {
        'icon': Icons.eco_rounded,
        'fruit_name': 'Kış Kabağı',
        'length': '49.8 cm',
        'weight': '3080 gr',
        'baby_dev': 'Organları tamamen olgunlaştı. Cildindeki lanugo tüyleri neredeyse tamamen döküldü.',
        'mother_changes': 'Doğum sancılarını ve kasılma aralıklarını takip etmek için hazırlıklı olun.',
      },
      39: {
        'icon': Icons.circle_rounded,
        'fruit_name': 'Mini Karpuz',
        'length': '50.7 cm',
        'weight': '3290 gr',
        'baby_dev': 'Tam miad! Bebeğiniz kordon aracılığıyla antikor almaya ve güç depolamaya devam ediyor.',
        'mother_changes': 'Sancılar 5 dakikada bire indiğinde veya su geldiğinde derhal hastaneye başvurun.',
      },
      40: {
        'icon': Icons.circle_rounded,
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
    final clampedWeek = week.clamp(1, 40);
    if (data.containsKey(clampedWeek)) {
      return data[clampedWeek]!;
    }
    return data[1]!;
  }
}
