#!/usr/bin/env bun
/**
 * Reservatior - Portföy Klasör Yapısı Oluşturucu
 * 
 * Ülke → Eyalet/Bölge → Şehir → İlçe → Mahalle yapısında
 * PropertyType ve ListingType bazında klasör yapısı oluşturur.
 * 
 * Yapı:
 *   data/
 *     TÜRKİYE/
 *       ISTANBUL/
 *         İlçe/
 *           Mahalle/
 *             Projeler/            (Yeni projeler)
 *             Satılık/             (SALE)
 *               Konut/            → Daire, Villa, Müstakil...
 *               Ticari/           → Ofis, Dükkan...
 *               Arsa/
 *             Kiralık/             (RENT)
 *               Konut/
 *               Ticari/
 *             2.El/               (İkinci el)
 *               Konut/
 *               Ticari/
 */

import { mkdirSync, existsSync, writeFileSync } from "fs";
import { join } from "path";

const BASE_DIR = join(__dirname, "..", "data");

// ═══════════════════════════════════════════════════════════════
// Property Type → Turkish Category Mapping
// ═══════════════════════════════════════════════════════════════

const LISTING_CATEGORIES = {
  "Satılık": {  // SALE
    "Konut": {
      subcategories: [
        "Daire",            // APARTMENT, FLAT_MAISONETTE, CONDO_APARTMENT
        "Rezidans",         // PENTHOUSE, STUDIO
        "Villa",            // VILLA, DETACHED_HOUSE
        "Müstakil Ev",      // SINGLE_FAMILY, SEMI_DETACHED_HOUSE
        "Sıra Ev",          // TERRACED_HOUSE, TOWNHOUSE
        "Bungalov",         // BUNGALOW, COTTAGE
        "Yazlık",           // CABIN_TINY_HOUSE, ADU_GUEST_HOUSE
        "Dublex",           // MULTI_FAMILY
        "Site İçi",         // COMPOUND
      ]
    },
    "Ticari": {
      subcategories: [
        "Ofis",             // OFFICE
        "Dükkan",           // RETAIL
        "Mağaza",           // COMMERCIAL_SPACE
        "İş Yeri",          // COMMERCIAL
        "Plaza Katı",
        "Depo",
        "Fabrika",
        "Atölye",
      ]
    },
    "Arsa": {
      subcategories: [
        "İmarlı Arsa",
        "Tarla",
        "Bahçe",
        "Zeytinlik",
        "Sanayi Arsası",
      ]
    },
    "Bina": {
      subcategories: [
        "Komple Bina",
        "Apartman",
        "İş Hanı",
        "Otel",
        "Han",
      ]
    },
  },
  "Kiralık": {  // RENT
    "Konut": {
      subcategories: [
        "Daire",
        "Rezidans",
        "Villa",
        "Müstakil Ev",
        "Stüdyo",
        "Eşyalı",
        "Eşyasız",
      ]
    },
    "Ticari": {
      subcategories: [
        "Ofis",
        "Dükkan",
        "Mağaza",
        "İş Yeri",
        "Showroom",
        "Depo",
      ]
    },
  },
  "Günlük Kiralık": {  // BOOKING
    subcategories: [
      "Daire",
      "Villa",
      "Stüdyo",
      "Apart",
      "Otel",
    ]
  },
  "Projeler": {  // New projects
    subcategories: [] // project folders are created per project
  },
  "2.El": {  // Second hand
    "Konut": {
      subcategories: [
        "Daire",
        "Villa",
        "Müstakil Ev",
        "Dublex",
      ]
    },
    "Ticari": {
      subcategories: [
        "Ofis",
        "Dükkan",
        "İş Yeri",
      ]
    },
  },
};

// ═══════════════════════════════════════════════════════════════
// TÜRKİYE - İstanbul İlçeleri ve Mahalleleri
// ═══════════════════════════════════════════════════════════════

const ISTANBUL_ILCELER: Record<string, string[]> = {
  // ─── Avrupa Yakası ───────────────────────────
  "Arnavutköy": ["Arnavutköy Merkez", "Bolluca", "Hadımköy", "İmrahor", "Tayakadın", "Durusu", "Haraçcı"],
  "Avcılar": ["Ambarlı", "Cihangir", "Denizköşkler", "Firuzköy", "Gümüşpala", "Merkez", "Mustafa Kemal Paşa", "Üniversite", "Yeşilkent"],
  "Bağcılar": ["100. Yıl", "15 Temmuz", "Bağlar", "Barbaros", "Demirkapı", "Evren", "Fatih", "Göztepe", "Güneşli", "Hürriyet", "İnönü", "Kazım Karabekir", "Kemalpaşa", "Kirazlı", "Mahmutbey", "Merkez", "Sancaktepe", "Yavuz Selim", "Yenigün", "Yıldıztepe"],
  "Bahçelievler": ["Bahçelievler Merkez", "Çobançeşme", "Fevzi Çakmak", "Hürriyet", "Kocasinan", "Soğanlı", "Siyavuşpaşa", "Şirinevler", "Yenibosna", "Zafer"],
  "Bakırköy": ["Ataköy 1. Kısım", "Ataköy 2-5-6. Kısım", "Ataköy 3-4-11. Kısım", "Ataköy 7-8-9-10. Kısım", "Basınköy", "Cevizlik", "Florya", "Kartaltepe", "Osmaniye", "Sakızağacı", "Şenlikköy", "Yeşilköy", "Yeşilyurt", "Zuhuratbaba"],
  "Başakşehir": ["Bahçeşehir 1. Kısım", "Bahçeşehir 2. Kısım", "Başak", "Başakşehir Merkez", "Güvercintepe", "İkitelli", "Kayabaşı", "Ziya Gökalp"],
  "Bayrampaşa": ["Altıntepsi", "Cevatpaşa", "İsmetpaşa", "Kocatepe", "Muratpaşa", "Ortamahalle", "Terazidere", "Vatan", "Yenidoğan", "Yıldırım"],
  "Beşiktaş": ["Abbasağa", "Akatlar", "Arnavutköy", "Bebek", "Cihannüma", "Dikilitaş", "Etiler", "Gayrettepe", "Konaklar", "Kuruçeşme", "Levent", "Levazım", "Mecidiye", "Muradiye", "Nisbetiye", "Ortaköy", "Sinanpaşa", "Türkali", "Ulus", "Vişnezade", "Yıldız"],
  "Beylikdüzü": ["Adnan Kahveci", "Barış", "Büyükşehir", "Cumhuriyet", "Dereağzı", "Gürpınar", "İnönü", "Kavaklı", "Marmara", "Sahil", "Yakuplu"],
  "Beyoğlu": ["Asmalımescit", "Bedrettin", "Bereketzade", "Cihangir", "Çukurcuma", "Evliya Çelebi", "Firuzağa", "Galata", "Galatasaray", "Gümüşsuyu", "Hacıahmet", "Hüseyinağa", "İstiklal", "Kalyoncukulluğu", "Katip Mustafa Çelebi", "Kemankeş Karamustafa Paşa", "Kılıçali Paşa", "Kuloğlu", "Müeyyetzade", "Ömeravni", "Pürtelaş", "Şahkulu", "Sütlüce", "Tarlabaşı", "Tomtom"],
  "Büyükçekmece": ["Atatürk", "Batıköy", "Beykent", "Cumhuriyet", "Fatih", "Kamiloba", "Kumburgaz", "Mimarsinan", "Muratçeşme", "Türkoba"],
  "Çatalca": ["Çatalca Merkez", "Ferhatpaşa", "Kaleiçi", "Kestanelik", "Muratbey", "Ovayenice", "Subaşı"],
  "Esenler": ["Atışalanı", "Birlik", "Çiftehavuzlar", "Davutpaşa", "Fatih", "Fevzi Çakmak", "Havaalanı", "Kazım Karabekir", "Kemer", "Menderes", "Mimarsinan", "Namık Kemal", "Oruçreis", "Turgut Reis", "Yavuz Selim"],
  "Esenyurt": ["Ardıçlı", "Cumhuriyet", "Fatih", "İnönü", "Mehmet Akif", "Namık Kemal", "Pınar", "Saadetdere", "Talatpaşa", "Yenikent", "Yeşilkent"],
  "Eyüpsultan": ["Akşemsettin", "Alibeyköy", "Çırçır", "Defterdar", "Düğmeciler", "Esentepe", "Eyüp Merkez", "Göktürk", "Güzeltepe", "İslambey", "Karadolap", "Kemerburgaz", "Merkez", "Mihrişah", "Nişancı", "Pirinççi", "Rami", "Silahtarağa", "Topçular", "Yeşilpınar"],
  "Fatih": ["Aksaray", "Balat", "Beyazıt", "Cerrahpaşa", "Çapa", "Çarşamba", "Edirnekapı", "Eminönü", "Fener", "Haseki", "Karagümrük", "Kumkapı", "Laleli", "Samatya", "Sultanahmet", "Süleymaniye", "Topkapı", "Unkapanı", "Vefa", "Yenikapı", "Zeyrek"],
  "Gaziosmanpaşa": ["Bağlarbaşı", "Barbaros Hayrettin Paşa", "Fevzi Çakmak", "Hürriyet", "Karlıtepe", "Karadeniz", "Kazım Karabekir", "Mevlana", "Merkez", "Sarıgöl", "Şemsipaşa", "Yenimahalle", "Yıldıztabya"],
  "Güngören": ["Abdurrahman Nafiz Gürman", "Akıncılar", "Gençosman", "Güneştepe", "Güven", "Haznedar", "Mareşal Çakmak", "Mehmet Nesih Özmen", "Merkez", "Sanayi", "Tozkoparan"],
  "Kağıthane": ["Çağlayan", "Çeliktepe", "Emniyet", "Gültepe", "Gürsel", "Hamidiye", "Harmantepe", "Hürriyet", "Merkez", "Nurtepe", "Ortabayır", "Sanayi", "Seyrantepe", "Şirintepe", "Talatpaşa", "Yahya Kemal"],
  "Küçükçekmece": ["Atatürk", "Atakent", "Beşyol", "Cennet", "Cumhuriyet", "Fatih", "Fevzi Çakmak", "Gültepe", "Halkalı", "İkitelli", "İnönü", "Kanarya", "Kartaltepe", "Kemalpaşa", "Mehmet Akif", "Söğütlüçeşme", "Sultan Murat", "Tevfikbey", "Yarımburgaz", "Yenimahalle"],
  "Sarıyer": ["Ayazağa", "Bahçeköy", "Baltalimanı", "Büyükdere", "Çamlıtepe", "Çayırbaşı", "Darüşşafaka", "Emirgan", "Fatih Sultan Mehmet", "Ferahevler", "Huzur", "İstinye", "Kireçburnu", "Kumbarahane", "Maslak", "Pınar", "Reşitpaşa", "Rumelihisarı", "Rumelikavağı", "Tarabya", "Uskumruköy", "Yeniköy", "Zekeriyaköy"],
  "Silivri": ["Alibey", "Gümüşyaka", "Kavaklı", "Merkez", "Mimarsinan", "Ortaköy", "Piri Mehmet Paşa", "Selimpaşa", "Semizkumlar", "Yolçatı"],
  "Sultangazi": ["50. Yıl", "75. Yıl", "Cebeci", "Esentepe", "Gazi", "Habipler", "İsmetpaşa", "Malkoçoğlu", "Sultan", "Sultançiftliği", "Uğur Mumcu", "Yayla", "Yunusemre", "Zübeyde Hanım"],
  "Şişli": ["Bomonti", "Cumhuriyet", "Dikilitaş", "Duatepe", "Elmadağ", "Ergenekon", "Esentepe", "Feriköy", "Fulya", "Gülbahar", "Halaskargazi", "Halide Edip Adıvar", "Harbiye", "İnönü", "İzzet Paşa", "Kuştepe", "Mecidiyeköy", "Merkez", "Meşrutiyet", "Nişantaşı", "Osmanbey", "Pangaltı", "Paşa", "Teşvikiye"],
  "Zeytinburnu": ["Beştelsiz", "Çırpıcı", "Gökalp", "Kazlıçeşme", "Maltepe", "Merkezefendi", "Nuripaşa", "Seyitnizam", "Sümer", "Telsiz", "Veliefendi", "Yenidoğan", "Yeşiltepe"],

  // ─── Anadolu Yakası ───────────────────────────
  "Adalar": ["Büyükada", "Heybeliada", "Burgazada", "Kınalıada", "Sedef Adası"],
  "Ataşehir": ["Aşık Veysel", "Atatürk", "Barbaros", "Esatpaşa", "Ferhatpaşa", "Fetih", "İçerenköy", "İnönü", "Kayışdağı", "Küçükbakkalköy", "Mevlana", "Mimar Sinan", "Mustafa Kemal", "Örnek", "Yenişehir"],
  "Beykoz": ["Acarlar", "Akbaba", "Anadoluhisarı", "Çavuşbaşı", "Çubuklu", "Dereseki", "Gümüşsuyu", "İncirköy", "Kavacık", "Kanlıca", "Merkez", "Paşabahçe", "Polonezköy", "Riva", "Rüzgarlıbahçe", "Tokatköy", "Yalıköy"],
  "Çekmeköy": ["Alemdağ", "Çamlık", "Ekşioğlu", "Hamidiye", "Koçullu", "Mehmet Akif", "Merkez", "Mimar Sinan", "Nişantepe", "Ömerli", "Reşadiye", "Soğukpınar", "Sultançiftliği", "Taşdelen"],
  "Kadıköy": ["Acıbadem", "Bostancı", "Caferağa", "Caddebostan", "Erenköy", "Fenerbahçe", "Fikirtepe", "Göztepe", "Hasanpaşa", "Koşuyolu", "Kozyatağı", "Merdivenköy", "Moda", "Osmanağa", "Rasimpaşa", "Sahrayıcedit", "Suadiye", "Zühtüpaşa"],
  "Kartal": ["Atalar", "Cevizli", "Çavuşoğlu", "Dragos", "Esentepe", "Gümüşpınar", "Hürriyet", "Karlıktepe", "Kordonboyu", "Merkez", "Orhantepe", "Petrol İş", "Soğanlık", "Topselvi", "Uğur Mumcu", "Yakacık", "Yukarı"],
  "Maltepe": ["Altayçeşme", "Altıntepe", "Aydınevler", "Bağlarbaşı", "Başıbüyük", "Büyükbakkalköy", "Cevizli", "Çınar", "Dragos", "Esenkent", "Feyzullah", "Fındıklı", "Girne", "Gülsuyu", "İdealtepe", "Küçükyalı", "Yalı", "Zümrütevler"],
  "Pendik": ["Ahmet Yesevi", "Bahçelievler", "Batı", "Çamçeşme", "Çınardere", "Doğu", "Dumlupınar", "Emirli", "Esenler", "Esenyalı", "Fevzi Çakmak", "Güllü Bağlar", "Güzelyalı", "Kaynarca", "Kurtköy", "Orta", "Ramazanoğlu", "Sapanbağları", "Şeyhli", "Tavşantepe", "Velibaba", "Yayalar", "Yenişehir"],
  "Sancaktepe": ["Abdurrahman Gazi", "Akpınar", "Atatürk", "Emek", "Eyüp Sultan", "Fatih", "İnönü", "Meclis", "Mevlana", "Merve", "Osmangazi", "Paşaköy", "Sarıgazi", "Veysel Karani", "Yenidoğan"],
  "Sultanbeyli": ["Abdurrahman", "Ahmet Yesevi", "Battalgazi", "Fatih", "Hamidiye", "Hasanpaşa", "Mecidiye", "Mehmet Akif", "Merkez", "Mimar Sinan", "Necip Fazıl", "Orhangazi", "Turgut Reis", "Yavuz Selim"],
  "Şile": ["Ağva", "Balibey", "Çavuş", "Hacıllı", "Kabakoz", "Kumbaba", "Merkez", "Sahilköy", "Üvezli"],
  "Tuzla": ["Aydınlı", "Aydıntepe", "Cami", "Evliya Çelebi", "Fatih", "İçmeler", "İstasyon", "Mescit", "Mimar Sinan", "Orhanlı", "Postane", "Şifa", "Yayla"],
  "Ümraniye": ["Adem Yavuz", "Altınşehir", "Armağanevler", "Atakent", "Çakmak", "Çamlık", "Dumlupınar", "Elmalıkent", "Esenevler", "Esenkent", "Hekimbaşı", "İnkılap", "İstiklal", "Kazım Karabekir", "Madenler", "Mehmet Akif", "Namık Kemal", "Parseller", "Saray", "Site", "Tantavi", "Tatlısu", "Topağacı", "Yaman Evler"],
  "Üsküdar": ["Acıbadem", "Ahmediye", "Altunizade", "Aziz Mahmut Hüdayi", "Bahçelievler", "Beylerbeyi", "Bulgurlu", "Burhaniye", "Çengelköy", "Çiçekçi", "Ferah", "Güzeltepe", "İcadiye", "Kandilli", "Kısıklı", "Kirazlıtepe", "Kuzguncuk", "Mimar Sinan", "Salacak", "Selimiye", "Sultantepe", "Ünalan", "Validei Atik", "Yavuztürk"],
};

// ═══════════════════════════════════════════════════════════════
// TÜRKİYE - Diğer Büyük Şehirler
// ═══════════════════════════════════════════════════════════════

const TURKIYE_DIGER_SEHIRLER: Record<string, Record<string, string[]>> = {
  "ANKARA": {
    "Çankaya": ["Bahçelievler", "Balgat", "Çayyolu", "Dikmen", "Emek", "GOP", "İncek", "Kavaklıdere", "Kızılay", "Oran", "Tunalı", "Ümitköy", "Yaşamkent"],
    "Keçiören": ["Atapark", "Bağlum", "Etlik", "Kalaba", "Kuşcağız", "Ovacık", "Şefkat"],
    "Yenimahalle": ["Batıkent", "Çayyolu", "Demetevler", "İvedik", "Macunköy", "Ostim", "Ragıp Tüzün", "Şentepe"],
    "Etimesgut": ["Elvankent", "Eryaman", "Bağlıca", "Yapracık", "30 Ağustos"],
    "Mamak": ["Abidinpaşa", "Cengizhan", "Fahrettin Altay", "Kutlu", "Saimekadın"],
    "Sincan": ["Fatih", "Sincan Merkez", "Yenikent", "Tandoğan"],
    "Pursaklar": ["Altınova", "Merkez", "Saray"],
    "Gölbaşı": ["Gölbaşı Merkez", "İncek", "Karagedik"],
  },
  "İZMİR": {
    "Konak": ["Alsancak", "Basmane", "Çankaya", "Göztepe", "Güzelyalı", "Hatay", "Kadifekale", "Kemeraltı"],
    "Karşıyaka": ["Bostanlı", "Çarşı", "Mavişehir", "Alaybey", "Nergiz", "Tersane"],
    "Bayraklı": ["Adalet", "Bayraklı Merkez", "Manavkuyu", "Postacılar", "Turan"],
    "Bornova": ["Büyük Park", "Erzene", "Evka", "Kazımdirik", "Kemalpaşa", "Merkez"],
    "Buca": ["Adatepe", "Efes", "Kuruçeşme", "Şirinyer", "Tınaztepe"],
    "Çeşme": ["Alaçatı", "Dalyan", "Ilıca", "Merkez", "Ovacık"],
    "Urla": ["İskele", "Merkez", "Zeytinalanı"],
    "Karaburun": ["Karaburun Merkez", "Mordoğan"],
    "Seferihisar": ["Merkez", "Sığacık", "Ürkmez"],
    "Narlıdere": ["Çatalkaya", "Merkez", "Sahilevleri"],
    "Balçova": ["Bahçelerarası", "İnciraltı", "Merkez"],
    "Gaziemir": ["Akçay", "Atıfbey", "Gazi", "Merkez", "Sarnıç"],
    "Menemen": ["Merkez", "Seyrek", "Villakent"],
    "Aliağa": ["Çakmaklı", "Merkez", "Yeni Şakran"],
    "Torbalı": ["Ayrancılar", "Merkez", "Pancar", "Subaşı"],
    "Selçuk": ["Efes", "Merkez", "Şirince"],
    "Foça": ["Eski Foça", "Yeni Foça"],
  },
  "ANTALYA": {
    "Muratpaşa": ["Fener", "Güzeloba", "Konyaaltı", "Lara", "Merkez", "Şirinyalı", "Yeşildere"],
    "Konyaaltı": ["Arapsuyu", "Hurma", "Liman", "Merkez", "Sarısu", "Uncalı"],
    "Kepez": ["Düden", "Fabrikalar", "Gülveren", "Kepez Merkez", "Varsak"],
    "Döşemealtı": ["Çığlık", "Merkez", "Yeniköy"],
    "Aksu": ["Altıntaş", "Kumköy", "Merkez"],
    "Kaş": ["Kalkan", "Kaş Merkez", "Patara"],
    "Alanya": ["Cikcilli", "Kargıcak", "Kestel", "Mahmutlar", "Merkez", "Oba", "Tosmur"],
    "Manavgat": ["Çolaklı", "Evrenseki", "Merkez", "Side", "Sorgun", "Titreyengöl"],
    "Serik": ["Belek", "Boğazkent", "Kadriye", "Merkez"],
    "Kemer": ["Beldibi", "Çamyuva", "Göynük", "Kemer Merkez", "Kiriş", "Tekirova"],
    "Kumluca": ["Adrasan", "Kumluca Merkez", "Olympos"],
    "Finike": ["Arif", "Finike Merkez", "Hasyurt"],
    "Demre": ["Demre Merkez", "Beymelek"],
    "Gazipaşa": ["Gazipaşa Merkez", "Selinus"],
  },
  "BURSA": {
    "Osmangazi": ["Çekirge", "Heykel", "Kükürtlü", "Merkez", "Soğanlı"],
    "Nilüfer": ["Beşevler", "Fethiye", "Görükle", "İhsaniye", "Özlüce"],
    "Yıldırım": ["Esenevler", "Millet", "Namazgah", "Yıldırım Merkez"],
    "Mudanya": ["Güzelyalı", "Mudanya Merkez", "Trilye"],
    "Gemlik": ["Gemlik Merkez", "Kurşunlu"],
  },
  "MUĞLA": {
    "Bodrum": ["Bitez", "Göltürkbükü", "Gümbet", "Gündoğan", "Konacık", "Merkez", "Ortakent", "Torba", "Turgutreis", "Yalıkavak", "Yalıçiftlik"],
    "Fethiye": ["Çalış", "Fethiye Merkez", "Hisarönü", "Kayaköy", "Ölüdeniz", "Ovacık"],
    "Marmaris": ["Armutalan", "İçmeler", "Marmaris Merkez", "Siteler", "Turunç"],
    "Milas": ["Güllük", "Merkez", "Ören"],
    "Datça": ["Datça Merkez", "İskele", "Reşadiye"],
    "Dalaman": ["Dalaman Merkez", "Sarıgerme"],
    "Ortaca": ["Dalyan", "Ortaca Merkez"],
    "Köyceğiz": ["Köyceğiz Merkez"],
  },
};

// ═══════════════════════════════════════════════════════════════
// DİĞER ÜLKELER
// ═══════════════════════════════════════════════════════════════

const COUNTRIES: Record<string, Record<string, Record<string, string[]>>> = {
  "UAE": {
    "Dubai": {
      "Dubai Marina": ["JBR", "Marina Walk", "Al Sahab", "Emaar Beachfront"],
      "Downtown Dubai": ["Burj Khalifa District", "Dubai Mall Area", "Business Bay", "DIFC"],
      "Palm Jumeirah": ["Shoreline", "Fairmont", "Atlantis", "Crescent"],
      "JVC": ["District 10", "District 11", "District 12", "District 13"],
      "Dubai Hills": ["Dubai Hills Estate", "Dubai Hills Mall Area", "Park Heights"],
      "Dubai Creek Harbour": ["Creek Beach", "Island District", "Creek Marina"],
      "MBR City": ["District One", "Meydan", "Sobha Hartland"],
      "Dubai South": ["Expo City", "Golf District", "Residential City"],
      "Jumeirah": ["Jumeirah 1", "Jumeirah 2", "Jumeirah 3", "Umm Suqeim"],
      "Al Barsha": ["Al Barsha 1", "Al Barsha 2", "Al Barsha South"],
      "Sports City": ["Dubai Sports City", "Motor City", "Arjan"],
      "Silicon Oasis": ["DSO", "Academic City"],
    },
    "Abu Dhabi": {
      "Saadiyat Island": ["Cultural District", "Saadiyat Beach", "Saadiyat Reserve"],
      "Yas Island": ["Yas Acres", "Yas Bay", "West Yas"],
      "Al Reem Island": ["Marina Square", "Shams", "City of Lights"],
      "Al Raha Beach": ["Al Muneera", "Al Zeina", "Al Bandar"],
      "Khalifa City": ["Khalifa City A", "Khalifa City B"],
      "Masdar City": ["Masdar Neighborhood"],
      "Corniche": ["Corniche Road", "Al Mina"],
    },
    "Sharjah": {
      "Al Mamzar": ["Mamzar Beach"],
      "Al Nahda": ["Al Nahda 1", "Al Nahda 2"],
      "Al Majaz": ["Buhaira Corniche"],
    },
  },
  "USA": {
    "New York": {
      "Manhattan": ["Upper East Side", "Upper West Side", "Midtown", "SoHo", "Tribeca", "Chelsea", "Greenwich Village", "Financial District", "Harlem"],
      "Brooklyn": ["Williamsburg", "DUMBO", "Park Slope", "Brooklyn Heights", "Bushwick", "Bedford-Stuyvesant"],
      "Queens": ["Astoria", "Long Island City", "Flushing", "Jackson Heights"],
      "Bronx": ["Riverdale", "Pelham Bay", "Fordham"],
      "Staten Island": ["St. George", "Tottenville"],
    },
    "California": {
      "Los Angeles": ["Beverly Hills", "Hollywood", "Santa Monica", "Bel Air", "Westwood", "Downtown LA", "Venice", "Malibu"],
      "San Francisco": ["Financial District", "Marina", "Nob Hill", "SoMa", "Pacific Heights", "Castro"],
      "San Diego": ["La Jolla", "Downtown", "Coronado", "Pacific Beach"],
    },
    "Florida": {
      "Miami": ["South Beach", "Brickell", "Downtown", "Coral Gables", "Coconut Grove", "Wynwood", "Key Biscayne"],
      "Orlando": ["Downtown", "Lake Nona", "Winter Park"],
    },
    "Texas": {
      "Houston": ["Downtown", "River Oaks", "Galleria", "Heights", "Montrose"],
      "Dallas": ["Uptown", "Downtown", "Highland Park", "Preston Hollow"],
      "Austin": ["Downtown", "South Congress", "East Austin", "Westlake"],
    },
  },
  "UK": {
    "England": {
      "London": ["Mayfair", "Knightsbridge", "Chelsea", "Kensington", "Westminster", "Canary Wharf", "Shoreditch", "Camden", "Notting Hill", "Hampstead", "Belgravia", "Fulham", "Richmond"],
      "Manchester": ["City Centre", "Didsbury", "Salford Quays", "Chorlton", "Ancoats"],
      "Birmingham": ["City Centre", "Edgbaston", "Jewellery Quarter", "Digbeth"],
      "Liverpool": ["City Centre", "Albert Dock", "Sefton Park"],
      "Bristol": ["Clifton", "Harbourside", "Redland", "Stokes Croft"],
      "Leeds": ["City Centre", "Headingley", "Chapel Allerton", "Roundhay"],
    },
    "Scotland": {
      "Edinburgh": ["New Town", "Old Town", "Stockbridge", "Leith", "Morningside"],
      "Glasgow": ["City Centre", "West End", "Merchant City", "Finnieston"],
    },
  },
  "DE": {
    "Berlin": {
      "Mitte": ["Alexanderplatz", "Potsdamer Platz", "Friedrichstraße"],
      "Charlottenburg": ["Kurfürstendamm", "Savignyplatz", "Westend"],
      "Kreuzberg": ["Bergmannkiez", "Graefekiez", "Wrangelkiez"],
      "Prenzlauer Berg": ["Kollwitzkiez", "Helmholtzkiez", "Kastanienallee"],
    },
    "Munich": {
      "Altstadt": ["Marienplatz", "Lehel", "Isarvorstadt"],
      "Schwabing": ["Schwabing-West", "Maxvorstadt"],
      "Bogenhausen": ["Herzogpark", "Oberföhring"],
    },
    "Frankfurt": {
      "Innenstadt": ["Bankenviertel", "Altstadt", "Sachsenhausen"],
      "Westend": ["Westend-Süd", "Westend-Nord"],
    },
  },
  "FR": {
    "Paris": {
      "1er-4ème": ["Le Marais", "Châtelet", "Louvre", "Île Saint-Louis"],
      "5ème-6ème": ["Saint-Germain", "Quartier Latin", "Luxembourg"],
      "7ème-8ème": ["Champs-Élysées", "Tour Eiffel", "Invalides"],
      "16ème-17ème": ["Trocadéro", "Passy", "Batignolles"],
    },
    "Côte d'Azur": {
      "Nice": ["Promenade", "Vieux Nice", "Cimiez", "Mont Boron"],
      "Cannes": ["La Croisette", "Le Suquet", "Palm Beach"],
      "Monaco": ["Monte Carlo", "La Condamine", "Fontvieille"],
      "Saint-Tropez": ["Centre Ville", "Les Parcs"],
    },
  },
  "ES": {
    "Madrid": {
      "Centro": ["Sol", "Malasaña", "Chueca", "La Latina", "Lavapiés"],
      "Salamanca": ["Recoletos", "Goya", "Castellana"],
      "Chamberí": ["Almagro", "Trafalgar", "Ríos Rosas"],
    },
    "Barcelona": {
      "Eixample": ["Dreta de l'Eixample", "Esquerra de l'Eixample", "Sagrada Família"],
      "Ciutat Vella": ["El Born", "Gótic", "Raval", "Barceloneta"],
      "Sarrià-Sant Gervasi": ["Sarrià", "Sant Gervasi", "Pedralbes"],
    },
    "Costa del Sol": {
      "Marbella": ["Golden Mile", "Puerto Banús", "Nueva Andalucía", "San Pedro"],
      "Málaga": ["Centro", "Este", "Teatinos", "El Palo"],
      "Estepona": ["Centro", "New Golden Mile"],
    },
  },
  "SA": {
    "Riyadh": {
      "Al Olaya": ["King Fahd Road", "Tahlia Street"],
      "Al Malqa": ["KAFD", "Diplomatic Quarter"],
      "Al Nakheel": ["Exit 5", "Exit 6"],
    },
    "Jeddah": {
      "Al Hamra": ["Corniche", "Al Rawdah"],
      "Obhur": ["North Obhur", "South Obhur"],
    },
    "NEOM": {
      "The Line": ["Bay Area", "Mountain Region"],
    },
  },
  "CA": {
    "Ontario": {
      "Toronto": ["Downtown", "Yorkville", "King West", "Liberty Village", "Harbourfront", "Midtown"],
      "Mississauga": ["City Centre", "Port Credit", "Lakeview"],
    },
    "British Columbia": {
      "Vancouver": ["Downtown", "Yaletown", "Kitsilano", "West End", "Coal Harbour", "Mount Pleasant"],
      "Victoria": ["Downtown", "James Bay", "Oak Bay"],
    },
    "Alberta": {
      "Calgary": ["Downtown", "Beltline", "Kensington"],
    },
    "Quebec": {
      "Montreal": ["Downtown", "Old Montreal", "Plateau", "Griffintown"],
    },
  },
  "AU": {
    "New South Wales": {
      "Sydney": ["CBD", "Bondi", "Surry Hills", "Darlinghurst", "Manly", "Mosman", "Double Bay", "Pyrmont"],
    },
    "Victoria": {
      "Melbourne": ["CBD", "Southbank", "Docklands", "South Yarra", "Fitzroy", "St Kilda", "Richmond"],
    },
    "Queensland": {
      "Brisbane": ["CBD", "South Bank", "Fortitude Valley", "New Farm", "West End"],
      "Gold Coast": ["Surfers Paradise", "Broadbeach", "Burleigh Heads", "Main Beach"],
    },
  },
  "IT": {
    "Lazio": {
      "Rome": ["Centro Storico", "Trastevere", "Prati", "Testaccio", "EUR", "Parioli"],
    },
    "Lombardia": {
      "Milan": ["Centro", "Brera", "Navigli", "CityLife", "Porta Nuova", "Isola"],
    },
    "Toscana": {
      "Florence": ["Centro", "Oltrarno", "Santa Croce", "San Lorenzo"],
    },
    "Veneto": {
      "Venice": ["San Marco", "Cannaregio", "Dorsoduro", "Lido"],
    },
  },
  "JP": {
    "Tokyo": {
      "Minato": ["Roppongi", "Azabu", "Akasaka", "Shinagawa", "Shibaura"],
      "Shibuya": ["Shibuya Center", "Harajuku", "Omotesando", "Daikanyama", "Ebisu"],
      "Shinjuku": ["Nishi-Shinjuku", "Kabukicho", "Yotsuya"],
      "Chiyoda": ["Marunouchi", "Otemachi", "Kojimachi"],
    },
    "Osaka": {
      "Kita": ["Umeda", "Nakanoshima", "Tenma"],
      "Chuo": ["Shinsaibashi", "Namba", "Honmachi"],
    },
  },
  "KR": {
    "Seoul": {
      "Gangnam": ["Apgujeong", "Cheongdam", "Samsung", "Yeoksam", "Daechi"],
      "Seocho": ["Banpo", "Jamwon", "Seocho-dong"],
      "Songpa": ["Jamsil", "Garak", "Munjeong"],
      "Yongsan": ["Itaewon", "Hannam", "Ichon"],
      "Mapo": ["Hongdae", "Yeonnam", "Sangsu"],
    },
  },
  "SG": {
    "Singapore": {
      "Central": ["Marina Bay", "Orchard", "River Valley", "Tanglin", "Bukit Timah", "Newton"],
      "East": ["Marine Parade", "Katong", "Bedok", "Tampines"],
      "West": ["Jurong East", "Clementi", "Buona Vista"],
      "North": ["Woodlands", "Yishun", "Ang Mo Kio"],
      "North East": ["Sengkang", "Punggol", "Hougang"],
    },
  },
  "NL": {
    "Noord-Holland": {
      "Amsterdam": ["Centrum", "Zuid", "West", "Oost", "Noord", "De Pijp", "Jordaan"],
    },
    "Zuid-Holland": {
      "Rotterdam": ["Centrum", "Kop van Zuid", "Kralingen", "Delfshaven"],
      "Den Haag": ["Centrum", "Scheveningen", "Benoordenhout", "Statenkwartier"],
    },
  },
  "NZ": {
    "Auckland": {
      "Auckland City": ["CBD", "Ponsonby", "Parnell", "Remuera", "Herne Bay", "Grey Lynn"],
      "North Shore": ["Takapuna", "Devonport", "Milford"],
      "Waitakere": ["Henderson", "Titirangi"],
    },
    "Wellington": {
      "Wellington City": ["CBD", "Oriental Bay", "Thorndon", "Kelburn", "Mt Victoria"],
    },
  },
  "MX": {
    "CDMX": {
      "Mexico City": ["Polanco", "Condesa", "Roma Norte", "Roma Sur", "Santa Fe", "Lomas de Chapultepec", "Coyoacán", "Del Valle"],
    },
    "Quintana Roo": {
      "Cancún": ["Zona Hotelera", "Centro", "Puerto Cancún"],
      "Playa del Carmen": ["Playacar", "Centro", "Coco Beach"],
      "Tulum": ["Tulum Beach", "Tulum Pueblo", "Aldea Zamá"],
    },
    "Jalisco": {
      "Guadalajara": ["Centro", "Chapultepec", "Providencia", "Zapopan"],
      "Puerto Vallarta": ["Marina Vallarta", "Zona Romántica", "Nuevo Vallarta"],
    },
  },
  "BR": {
    "São Paulo": {
      "São Paulo": ["Jardins", "Itaim Bibi", "Vila Olímpia", "Pinheiros", "Moema", "Vila Madalena"],
    },
    "Rio de Janeiro": {
      "Rio de Janeiro": ["Copacabana", "Ipanema", "Leblon", "Barra da Tijuca", "Botafogo", "Flamengo"],
    },
  },
  "IN": {
    "Maharashtra": {
      "Mumbai": ["South Mumbai", "Bandra", "Juhu", "Worli", "Powai", "Andheri", "Lower Parel"],
    },
    "Karnataka": {
      "Bangalore": ["Indiranagar", "Koramangala", "Whitefield", "HSR Layout", "Jayanagar"],
    },
    "Delhi NCR": {
      "New Delhi": ["Lutyens Delhi", "Defence Colony", "Greater Kailash", "Hauz Khas"],
      "Gurgaon": ["DLF Phase 1-5", "Golf Course Road", "Sohna Road", "Sector 42-57"],
    },
  },
  "TH": {
    "Bangkok": {
      "Central": ["Sukhumvit", "Silom", "Sathorn", "Phrom Phong", "Thonglor", "Asoke", "Ploenchit"],
      "Riverside": ["Charoenkrung", "Charoen Nakhon", "Rama III"],
    },
    "Phuket": {
      "West Coast": ["Patong", "Kamala", "Surin", "Bang Tao", "Kata", "Karon"],
      "East Coast": ["Cape Panwa", "Rawai", "Chalong"],
    },
    "Pattaya": {
      "Pattaya": ["Jomtien", "Pratumnak", "Wong Amat", "Na Jomtien"],
    },
  },
  "MY": {
    "Kuala Lumpur": {
      "KL City": ["KLCC", "Bukit Bintang", "KL Sentral", "Bangsar", "Mont Kiara", "Damansara Heights"],
      "Petaling Jaya": ["SS2", "Damansara", "Sunway"],
    },
    "Penang": {
      "George Town": ["Georgetown Centre", "Gurney Drive", "Tanjung Tokong", "Batu Ferringhi"],
    },
    "Johor": {
      "Johor Bahru": ["Iskandar Puteri", "Danga Bay", "Medini"],
    },
  },
  "AR": {
    "Buenos Aires": {
      "Buenos Aires": ["Palermo", "Recoleta", "Puerto Madero", "Belgrano", "San Telmo", "Núñez"],
    },
    "Patagonia": {
      "Bariloche": ["Centro", "Llao Llao", "Lago Moreno"],
    },
  },
};

// ═══════════════════════════════════════════════════════════════
// Klasör Oluşturma
// ═══════════════════════════════════════════════════════════════

let dirCount = 0;

function mkdirSafe(path: string) {
  if (!existsSync(path)) {
    mkdirSync(path, { recursive: true });
    dirCount++;
  }
}

function createListingCategoriesIn(basePath: string) {
  for (const [catName, catValue] of Object.entries(LISTING_CATEGORIES)) {
    const catPath = join(basePath, catName);
    mkdirSafe(catPath);

    if ('subcategories' in catValue) {
      // Simple category with subcategories
      for (const sub of (catValue as any).subcategories) {
        mkdirSafe(join(catPath, sub));
      }
    } else {
      // Nested category (Konut, Ticari, etc.)
      for (const [subCatName, subCatValue] of Object.entries(catValue as Record<string, any>)) {
        const subCatPath = join(catPath, subCatName);
        mkdirSafe(subCatPath);
        if (subCatValue.subcategories) {
          for (const sub of subCatValue.subcategories) {
            mkdirSafe(join(subCatPath, sub));
          }
        }
      }
    }
  }
}

function createReadme(path: string, content: string) {
  const readmePath = join(path, ".gitkeep");
  if (!existsSync(readmePath)) {
    writeFileSync(readmePath, "");
  }
}

async function main() {
  console.log("📂 Reservatior - Ülkelere Göre Portföy Klasör Yapısı Oluşturucu");
  console.log("═".repeat(60));

  // ─── TÜRKİYE / ISTANBUL ─────────────────────
  console.log("\n🇹🇷 TÜRKİYE / ISTANBUL oluşturuluyor...");
  for (const [ilce, mahalleler] of Object.entries(ISTANBUL_ILCELER)) {
    for (const mahalle of mahalleler) {
      const mahallePath = join(BASE_DIR, "TURKİYE", "ISTANBUL", ilce, mahalle);
      mkdirSafe(mahallePath);
      createListingCategoriesIn(mahallePath);
      createReadme(mahallePath, `${ilce} / ${mahalle}`);
    }
    console.log(`  ✅ ${ilce} (${mahalleler.length} mahalle)`);
  }

  // ─── TÜRKİYE / DİĞER ŞEHİRLER ──────────────
  for (const [sehir, ilceler] of Object.entries(TURKIYE_DIGER_SEHIRLER)) {
    console.log(`\n🇹🇷 TÜRKİYE / ${sehir} oluşturuluyor...`);
    for (const [ilce, mahalleler] of Object.entries(ilceler)) {
      for (const mahalle of mahalleler) {
        const mahallePath = join(BASE_DIR, "TURKİYE", sehir, ilce, mahalle);
        mkdirSafe(mahallePath);
        createListingCategoriesIn(mahallePath);
      }
      console.log(`  ✅ ${ilce} (${mahalleler.length} mahalle)`);
    }
  }

  // ─── DİĞER ÜLKELER ──────────────────────────
  for (const [country, regions] of Object.entries(COUNTRIES)) {
    const flagMap: Record<string, string> = {
      UAE: "🇦🇪", USA: "🇺🇸", UK: "🇬🇧", DE: "🇩🇪", FR: "🇫🇷", ES: "🇪🇸",
      SA: "🇸🇦", CA: "🇨🇦", AU: "🇦🇺", IT: "🇮🇹", JP: "🇯🇵", KR: "🇰🇷",
      SG: "🇸🇬", NL: "🇳🇱", NZ: "🇳🇿", MX: "🇲🇽", BR: "🇧🇷", IN: "🇮🇳",
      TH: "🇹🇭", MY: "🇲🇾", AR: "🇦🇷",
    };
    const flag = flagMap[country] || "🌍";
    console.log(`\n${flag} ${country} oluşturuluyor...`);

    for (const [region, cities] of Object.entries(regions)) {
      for (const [city, neighborhoods] of Object.entries(cities)) {
        for (const hood of neighborhoods) {
          const hoodPath = join(BASE_DIR, country, region, city, hood);
          mkdirSafe(hoodPath);
          createListingCategoriesIn(hoodPath);
        }
        console.log(`  ✅ ${region} / ${city} (${neighborhoods.length} bölge)`);
      }
    }
  }

  console.log(`\n${"═".repeat(60)}`);
  console.log(`🎉 Toplam ${dirCount} klasör oluşturuldu!`);
  console.log(`📂 Konum: ${BASE_DIR}`);
  console.log(`\n📋 Yapı Özeti:`);
  console.log(`   Ülke → Eyalet/Bölge → Şehir → İlçe → Mahalle`);
  console.log(`     ├── Projeler/`);
  console.log(`     ├── Satılık/ → Konut, Ticari, Arsa, Bina`);
  console.log(`     ├── Kiralık/ → Konut, Ticari`);
  console.log(`     ├── Günlük Kiralık/`);
  console.log(`     └── 2.El/ → Konut, Ticari\n`);
}

main();
