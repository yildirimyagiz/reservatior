import 'package:flutter/material.dart';

/// Her oda/bölüm için meta veri
class RoomSection {
  final String id;
  final String nameEn;
  final String nameTr;
  final String icon;         // emoji
  final IconData iconData;
  final Color color;
  final List<String> tips;   // Çekim ipuçları
  final Duration recommendedDuration;
  final bool isRequired;     // Zorunlu mu?
  RoomCaptureStatus status;
  String? capturedVideoPath;
  double? videoTimestamp;    // İlanda buton ile atlamak için saniye

  RoomSection({
    required this.id,
    required this.nameEn,
    required this.nameTr,
    required this.icon,
    required this.iconData,
    required this.color,
    required this.tips,
    required this.recommendedDuration,
    this.isRequired = false,
    this.status = RoomCaptureStatus.pending,
    this.capturedVideoPath,
    this.videoTimestamp,
  });

  String get displayName => nameTr; // locale'den gelecek, şimdilik TR

  RoomSection copyWith({
    RoomCaptureStatus? status,
    String? capturedVideoPath,
    double? videoTimestamp,
  }) => RoomSection(
    id: id, nameEn: nameEn, nameTr: nameTr,
    icon: icon, iconData: iconData, color: color,
    tips: tips, recommendedDuration: recommendedDuration,
    isRequired: isRequired,
    status: status ?? this.status,
    capturedVideoPath: capturedVideoPath ?? this.capturedVideoPath,
    videoTimestamp: videoTimestamp ?? this.videoTimestamp,
  );
}

enum RoomCaptureStatus { pending, recording, captured, skipped }

/// Tüm oda tanımları — global sabit
final kAllRoomSections = <RoomSection>[
  RoomSection(
    id: 'exterior',
    nameEn: 'Exterior / Facade',
    nameTr: 'Dış Cephe',
    icon: '🏠',
    iconData: Icons.home_outlined,
    color: const Color(0xFF4A90D9),
    isRequired: true,
    recommendedDuration: Duration(seconds: 20),
    tips: [
      'Mülkün tüm cephesini gösterecek şekilde geri çekilin',
      'Güneş ışığını arkanıza alın, gölge düşmemesine dikkat edin',
      'Bahçe veya peyzaj varsa mutlaka dahil edin',
      'Giriş kapısında bitiş yapın',
    ],
  ),
  RoomSection(
    id: 'entrance',
    nameEn: 'Entrance / Hallway',
    nameTr: 'Giriş & Hol',
    icon: '🚪',
    iconData: Icons.meeting_room_outlined,
    color: const Color(0xFF7B68EE),
    isRequired: true,
    recommendedDuration: Duration(seconds: 12),
    tips: [
      'Kapıyı açarak girişi gösterin',
      'Hol boyunca yavaşça ilerleyin',
      'Doğal ışık varsa perdeleri açık bırakın',
      'Vestiyar veya depolama alanı varsa gösterin',
    ],
  ),
  RoomSection(
    id: 'living_room',
    nameEn: 'Living Room',
    nameTr: 'Oturma Odası',
    icon: '🛋️',
    iconData: Icons.weekend_outlined,
    color: const Color(0xFFC9A84C),
    isRequired: true,
    recommendedDuration: Duration(seconds: 25),
    tips: [
      'Odaya girerken panoramik bir süpürme hareketi yapın',
      'Pencereleri göstererek manzarayı vurgulayın',
      'Tavan yüksekliğini hissettirmek için kamera açısını değiştirin',
      'Şömine veya özel detayları yakın çekimle gösterin',
    ],
  ),
  RoomSection(
    id: 'kitchen',
    nameEn: 'Kitchen',
    nameTr: 'Mutfak',
    icon: '🍳',
    iconData: Icons.kitchen_outlined,
    color: const Color(0xFFE87D3E),
    isRequired: true,
    recommendedDuration: Duration(seconds: 20),
    tips: [
      'Mutfak adasından veya tezgahtan başlayın',
      'Cihazları ve dolap kalitesini gösterin',
      'Yemek odası bağlantısı varsa geçişi gösterin',
      'Backsplash ve detayları yakın çekimle yakalayın',
    ],
  ),
  RoomSection(
    id: 'master_bedroom',
    nameEn: 'Master Bedroom',
    nameTr: 'Ana Yatak Odası',
    icon: '🛏️',
    iconData: Icons.bed_outlined,
    color: const Color(0xFF9B59B6),
    isRequired: true,
    recommendedDuration: Duration(seconds: 20),
    tips: [
      'Kapıdan tüm odayı gösterecek açıdan başlayın',
      'Pencere ve doğal ışığı vurgulayın',
      'Yatak başına yakın çekim yapın',
      'Odanın genişliğini hissettirin',
    ],
  ),
  RoomSection(
    id: 'bedroom_2',
    nameEn: 'Bedroom 2',
    nameTr: '2. Yatak Odası',
    icon: '🛏️',
    iconData: Icons.bed_outlined,
    color: const Color(0xFF2ECC71),
    recommendedDuration: Duration(seconds: 15),
    tips: [
      'Odaya girişi gösterin',
      'Pencere ve aydınlatmayı vurgulayın',
      'Kullanım amacını (misafir/çocuk odası) hissettirin',
    ],
  ),
  RoomSection(
    id: 'bedroom_3',
    nameEn: 'Bedroom 3',
    nameTr: '3. Yatak Odası',
    icon: '🛏️',
    iconData: Icons.bed_outlined,
    color: const Color(0xFF1ABC9C),
    recommendedDuration: Duration(seconds: 15),
    tips: [
      'Odaya girişi gösterin',
      'Pencere ve aydınlatmayı vurgulayın',
    ],
  ),
  RoomSection(
    id: 'bathroom_master',
    nameEn: 'Master Bathroom',
    nameTr: 'Ana Banyo',
    icon: '🚿',
    iconData: Icons.bathtub_outlined,
    color: const Color(0xFF3498DB),
    isRequired: true,
    recommendedDuration: Duration(seconds: 15),
    tips: [
      'Duş veya küveti net gösterin',
      'Seramik ve kaplama kalitesini vurgulayın',
      'Aydınlatmayı açık bırakın',
      'Pencere veya havalandırmayı gösterin',
    ],
  ),
  RoomSection(
    id: 'bathroom_2',
    nameEn: 'Bathroom 2',
    nameTr: '2. Banyo / Tuvalet',
    icon: '🚿',
    iconData: Icons.bathtub_outlined,
    color: const Color(0xFF5DADE2),
    recommendedDuration: Duration(seconds: 10),
    tips: [
      'Temiz ve aydınlık gösterin',
      'Seramik detaylarını yakalayın',
    ],
  ),
  RoomSection(
    id: 'dressing_room',
    nameEn: 'Dressing Room / Walk-in Closet',
    nameTr: 'Giyinme Odası',
    icon: '👗',
    iconData: Icons.checkroom_outlined,
    color: const Color(0xFFE91E63),
    recommendedDuration: Duration(seconds: 12),
    tips: [
      'Dolap sistemini ve organizasyonu gösterin',
      'Genişliği hissettirin',
      'Aynalar varsa açıdan kaçının (kamera yansıması)',
    ],
  ),
  RoomSection(
    id: 'laundry',
    nameEn: 'Laundry Room',
    nameTr: 'Çamaşır Odası',
    icon: '🫧',
    iconData: Icons.local_laundry_service_outlined,
    color: const Color(0xFF00BCD4),
    recommendedDuration: Duration(seconds: 10),
    tips: [
      'Makinelerin yerleşimini gösterin',
      'Depolama ve raf alanlarını vurgulayın',
    ],
  ),
  RoomSection(
    id: 'balcony',
    nameEn: 'Balcony',
    nameTr: 'Balkon',
    icon: '🌿',
    iconData: Icons.deck_outlined,
    color: const Color(0xFF27AE60),
    recommendedDuration: Duration(seconds: 15),
    tips: [
      'İçeriden balkona çıkışı gösterin',
      'Manzarayı panoramik olarak yakalayın',
      'Sabah veya altın saatte çekin — ışık mükemmel olur',
      'Genişlik ve derinliği hissettirin',
    ],
  ),
  RoomSection(
    id: 'terrace',
    nameEn: 'Terrace / Roof',
    nameTr: 'Teras',
    icon: '🏙️',
    iconData: Icons.roofing_outlined,
    color: const Color(0xFFF39C12),
    recommendedDuration: Duration(seconds: 20),
    tips: [
      'Gündoğumu veya günbatımında çekin',
      '360° dönerek manzarayı gösterin',
      'Oturma alanı veya şezlong varsa dahil edin',
      'Şehir veya deniz manzarası için yavaş pan yapın',
    ],
  ),
  RoomSection(
    id: 'garden',
    nameEn: 'Garden / Pool',
    nameTr: 'Bahçe & Havuz',
    icon: '🌊',
    iconData: Icons.pool_outlined,
    color: const Color(0xFF16A085),
    recommendedDuration: Duration(seconds: 20),
    tips: [
      'Havuz varsa köşeden tüm havuzu gösterin',
      'Peyzajı ve bitkileri vurgulayın',
      'Barbekü veya dış oturma alanlarını gösterin',
      'Altın saat ışığı en güzel sonucu verir',
    ],
  ),
  RoomSection(
    id: 'garage',
    nameEn: 'Garage / Parking',
    nameTr: 'Garaj & Otopark',
    icon: '🚗',
    iconData: Icons.garage_outlined,
    color: const Color(0xFF7F8C8D),
    recommendedDuration: Duration(seconds: 10),
    tips: [
      'Kapasite ve boyutu gösterin',
      'Elektrikli araç şarj noktası varsa vurgulayın',
    ],
  ),
];
