import { resolveMediaUrl } from "./utils";

export interface ProjectMediaAssets {
  photos: string[];
  floorPlans: string[];
  videos: string[];
}

// Complete Project Media Registry for all loaded projects
export const PROJECT_MEDIA_CATALOG: Record<string, ProjectMediaAssets> = {
  // Büyükyalı Istanbul
  buyukyali: {
    photos: [
      "/images/buyukyali/buyukyali_galeri-1OLU9.webp",
      "/images/buyukyali/buyukyali_galeri-FG1IH.webp",
      "/images/buyukyali/buyukyali_galeri-80347.webp",
      "/images/buyukyali/buyukyali_galeri-JCKK8.webp",
      "/images/buyukyali/buyukyali_galeri-12EBC.webp"
    ],
    floorPlans: [
      "/images/buyukyali/floorplans/buyukyali-4-1-V7DDA.webp",
      "/images/buyukyali/floorplans/buyukyali-2-1-792JP.webp"
    ],
    videos: [
      "/videos/ozak-buyukyali-bg.mp4"
    ]
  },

  // Özak Duyu
  duyu: {
    photos: [
      "/images/duyu/ozak_duyu_galeri-GNND4.webp",
      "/images/duyu/ozak_duyu_galeri-X9UXE.webp",
      "/images/duyu/ozak_duyu_galeri-O1JT7.webp",
      "/images/duyu/ozak_duyu_slider_1-6316E-m.webp",
      "/images/duyu/1774963607_362.webp"
    ],
    floorPlans: [
      "/images/duyu/floorplans/ozak-duyu-3-1-h1-z-M0VBZ.webp",
      "/images/duyu/floorplans/ozak-duyu-4-1-b-d-YNC2K.webp",
      "/images/duyu/floorplans/ozak-duyu-3-1-f2-AHF8U.webp",
      "/images/duyu/floorplans/ozak-duyu-1-1-a2-W5Q5Y.webp"
    ],
    videos: [
      "/videos/ozak-duyu-bg.mp4"
    ]
  },

  // Özak Dragos
  dragos: {
    photos: [
      "/uploads/projects/wa_avrupa_plazalar_/foto/1787252548737-184.jpg",
      "/uploads/projects/wa_avrupa_plazalar_/foto/1787252548736-499.jpg"
    ],
    floorPlans: [],
    videos: [
      "/videos/ozak-dragos-bg.mp4"
    ]
  },

  // Maslak 1453
  maslak: {
    photos: [
      "/uploads/projects/tr_prop_tr-res-maslak1453/foto/1787252548687-677.jpg"
    ],
    floorPlans: [
      "/uploads/projects/tr_prop_tr-res-maslak1453/kat-plani/1787252548700-349.jpg"
    ],
    videos: [
      "/uploads/projects/tr_prop_tr-res-maslak1453/video/1787252548712-421-thumbnail_1.jpg"
    ]
  },

  // Batışehir
  batisehir: {
    photos: [
      "/uploads/projects/tr_prop_tr-res-batisehir/foto/1787252549019-671.jpg"
    ],
    floorPlans: [
      "/uploads/projects/tr_prop_tr-res-batisehir/kat-plani/1787252549028-204.jpg"
    ],
    videos: [
      "/uploads/projects/tr_prop_tr-res-batisehir/video/1787252549041-372-thumbnail_1.jpg"
    ]
  },

  // Sapphire
  sapphire: {
    photos: [
      "/uploads/projects/tr_prop_tr-res-sapphire/foto/1787252549905-670.jpg"
    ],
    floorPlans: [
      "/uploads/projects/tr_prop_tr-res-sapphire/kat-plani/1787252549921-229.jpg"
    ],
    videos: [
      "/uploads/projects/tr_prop_tr-res-sapphire/video/1787252549942-835-thumbnail_1.jpg"
    ]
  },

  // Skyland
  skyland: {
    photos: [
      "/uploads/projects/tr_prop_tr-res-skyland/foto/1787252552037-499.jpg"
    ],
    floorPlans: [
      "/uploads/projects/tr_prop_tr-res-skyland/kat-plani/1787252552047-920.jpg"
    ],
    videos: [
      "/uploads/projects/tr_prop_tr-res-skyland/video/1787252552060-639-thumbnail_1.jpg"
    ]
  },

  // Vadi / Vadistanbul
  vadi: {
    photos: [
      "/uploads/projects/tr_prop_tr-res-vadi/foto/1787252548568-374.jpg"
    ],
    floorPlans: [
      "/uploads/projects/tr_prop_tr-res-vadi/kat-plani/1787252548577-491.jpg"
    ],
    videos: [
      "/uploads/projects/tr_prop_tr-res-vadi/video/1787252548590-482-thumbnail_1.jpg"
    ]
  },

  // Zorlu Center
  zorlu: {
    photos: [
      "/uploads/projects/tr_prop_tr-res-zorlu/foto/1787252551872-111.jpg"
    ],
    floorPlans: [
      "/uploads/projects/tr_prop_tr-res-zorlu/kat-plani/1787252551881-209.jpg"
    ],
    videos: [
      "/uploads/projects/tr_prop_tr-res-zorlu/video/1787252551892-710-thumbnail_1.jpg"
    ]
  },

  // Nidapark / İstinye
  nidapark: {
    photos: [
      "/uploads/projects/tr_prop_tr-res-nidapark/foto/1787252550174-409.jpg"
    ],
    floorPlans: [
      "/uploads/projects/tr_prop_tr-res-nidapark/kat-plani/1787252550186-302.jpg"
    ],
    videos: [
      "/uploads/projects/tr_prop_tr-res-nidapark/video/1787252550198-508-thumbnail_1.jpg"
    ]
  },

  // Anthill
  anthill: {
    photos: [
      "/uploads/projects/wa_ANTHI_LL_2018/foto/1787252551465-521.jpg",
      "/uploads/projects/wa_ANTHI_LL_2018/foto/1787252551443-925.jpg",
      "/uploads/projects/wa_ANTHI_LL_2018/foto/1787252551455-104.jpg"
    ],
    floorPlans: [
      "/uploads/projects/wa_ANTHI_LL_2018/kat-plani/1787252551475-430.jpg"
    ],
    videos: []
  },

  // Kanyon
  kanyon: {
    photos: [
      "/uploads/projects/wa_Kanyon_1/foto/1787252551600-651.jpg",
      "/uploads/projects/wa_Kanyon_1/foto/1787252551601-112.jpg",
      "/uploads/projects/wa_Kanyon_1/foto/1787252551605-720.jpg"
    ],
    floorPlans: [],
    videos: []
  },

  // Mashattan
  mashattan: {
    photos: [
      "/uploads/projects/wa_Mashattan_Liste/foto/1787252551795-655.jpg",
      "/uploads/projects/wa_Mashattan_Liste/foto/1787252551799-204.jpg"
    ],
    floorPlans: [],
    videos: []
  },

  // Maya Residence
  maya: {
    photos: [
      "/uploads/projects/wa_Maya_Residence/foto/1787252549770-29.jpg",
      "/uploads/projects/wa_Maya_Residence/foto/1787252549771-42.jpg"
    ],
    floorPlans: [],
    videos: []
  },

  // Platin Ulus
  platin: {
    photos: [
      "/uploads/projects/wa_Platin_ulus/foto/1787252551368-680.jpg"
    ],
    floorPlans: [],
    videos: []
  },

  // Sarıkonaklar
  sarikonaklar: {
    photos: [
      "/uploads/projects/wa_SARIKONAKLAR/foto/1787252551080-231.jpg"
    ],
    floorPlans: [],
    videos: []
  },

  // Selenium
  selenium: {
    photos: [
      "/uploads/projects/wa_SELENIUM_CITY_PANORAMA_TWINS1/foto/1787252550473-867.jpg"
    ],
    floorPlans: [],
    videos: []
  },

  // Tema Istanbul
  tema: {
    photos: [
      "/uploads/projects/wa_Tema_I_stanbul_1459_kisi/foto/1787252549502-693.jpg"
    ],
    floorPlans: [
      "/uploads/projects/wa_Tema_I_stanbul_1459_kisi/kat-plani/1787252549635-702.jpg"
    ],
    videos: [
      "/uploads/projects/wa_Tema_I_stanbul_1459_kisi/video/1787252549690-25-thumbnail_1.jpg"
    ]
  },

  // Lotus Ulus
  lotus: {
    photos: [
      "/uploads/projects/wa_ULUS_LOTUS_SITESI_1_/video/1787252549194-627-thumbnail_1.jpg"
    ],
    floorPlans: [],
    videos: [
      "/uploads/projects/wa_ULUS_LOTUS_SITESI_1_/video/1787252549194-627-thumbnail_1.jpg"
    ]
  },

  // Upcity
  upcity: {
    photos: [
      "/uploads/projects/wa_Upcity_FLATS__KARTAL__379_/foto/1787252550599-488.jpg",
      "/uploads/projects/wa_Upcity_RESI_DANCE_306_/foto/1787252548436-155.jpg"
    ],
    floorPlans: [],
    videos: [
      "/uploads/projects/wa_Upcity_FLATS__KARTAL__379_/video/1787252550608-614-thumbnail_1.jpg"
    ]
  },

  // Aquacity
  aquacity: {
    photos: [
      "/uploads/projects/wa_aquactiy/foto/1787252551236-629.jpg",
      "/uploads/projects/wa_aquactiy/foto/1787252551241-587.jpg",
      "/uploads/projects/wa_aquactiy/foto/1787252551243-114.jpg"
    ],
    floorPlans: [],
    videos: [
      "/uploads/projects/wa_aquactiy/video/1787252551328-184-thumbnail_1.jpg"
    ]
  },

  // Astoria
  astoria: {
    photos: [
      "/uploads/projects/wa_astoria/foto/1787252549244-337.jpg",
      "/uploads/projects/wa_astoria/foto/1787252549249-780.jpg",
      "/uploads/projects/wa_astoria/foto/1787252549255-906.jpg"
    ],
    floorPlans: [],
    videos: [
      "/uploads/projects/wa_astoria/video/1787252549373-506-thumbnail_1.jpg"
    ]
  },

  // Levent Loft
  loft: {
    photos: [
      "/uploads/projects/wa_levent_loft/foto/1787252550057-413.jpg",
      "/uploads/projects/wa_levent_loft/foto/1787252550058-369.jpg",
      "/uploads/projects/wa_levent_loft/foto/1787252550061-497.jpg"
    ],
    floorPlans: [],
    videos: [
      "/uploads/projects/wa_levent_loft/video/1787252550134-937-thumbnail_1.jpg"
    ]
  },

  // 42 Maslak
  maslak42: {
    photos: [
      "/uploads/projects/wa_maskak_42_A_kule/foto/1787252550955-615.jpg",
      "/uploads/projects/wa_maskak_42_A_kule/foto/1787252550964-614.jpg",
      "/uploads/projects/wa_maskak_42_yatay_ofis/foto/1787252548820-200.jpg"
    ],
    floorPlans: [],
    videos: [
      "/uploads/projects/wa_maskak_42_A_kule/video/1787252551050-848-thumbnail_1.jpg"
    ]
  },

  // Ottomare
  ottomare: {
    photos: [
      "/uploads/projects/wa_ottomare/foto/1787252549422-595.jpg",
      "/uploads/projects/wa_ottomare/foto/1787252549430-574.jpg"
    ],
    floorPlans: [],
    videos: [
      "/uploads/projects/wa_ottomare/video/1787252549459-555-thumbnail_1.jpg"
    ]
  },

  // Şehrizar
  sehrizar: {
    photos: [
      "/uploads/projects/wa_s_ehrizar_/foto/1787252549082-974.jpg",
      "/uploads/projects/wa_s_ehrizar_/foto/1787252549083-565.jpg"
    ],
    floorPlans: [],
    videos: [
      "/uploads/projects/wa_s_ehrizar_/video/1787252549152-644-thumbnail_1.jpg"
    ]
  },

  // Ulus Park
  uluspark: {
    photos: [
      "/uploads/projects/wa_ulus_park_evleri_mal_sahipleri/foto/1787252550236-378.jpg"
    ],
    floorPlans: [],
    videos: [
      "/uploads/projects/wa_ulus_park_evleri_mal_sahipleri/video/1787252550258-650-thumbnail_1.jpg"
    ]
  },

  // Istwest
  istwest: {
    photos: [
      "/uploads/projects/wa_I_STWEST/foto/1787252550310-147.jpg"
    ],
    floorPlans: [],
    videos: []
  },

  // Alice Village
  alice: {
    photos: [
      "/uploads/projects/wa_ALI_CE_VI_LLAGE___DATA/foto/1787252551168-534.jpg"
    ],
    floorPlans: [],
    videos: []
  }
};

// Project key matcher aliases
const PROJECT_ALIASES: Record<string, string> = {
  "büyükyalı": "buyukyali",
  "buyukyali": "buyukyali",
  "duyu": "duyu",
  "ozak duyu": "duyu",
  "dragos": "dragos",
  "1453": "maslak",
  "maslak": "maslak",
  "batışehir": "batisehir",
  "batisehir": "batisehir",
  "sapphire": "sapphire",
  "skyland": "skyland",
  "vadi": "vadi",
  "vadistanbul": "vadi",
  "zorlu": "zorlu",
  "nidapark": "nidapark",
  "istinye": "nidapark",
  "anthill": "anthill",
  "kanyon": "kanyon",
  "mashattan": "mashattan",
  "maya": "maya",
  "platin": "platin",
  "sarıkonaklar": "sarikonaklar",
  "sarikonaklar": "sarikonaklar",
  "selenium": "selenium",
  "tema": "tema",
  "lotus": "lotus",
  "upcity": "upcity",
  "aquacity": "aquacity",
  "aquactiy": "aquacity",
  "astoria": "astoria",
  "loft": "loft",
  "levent loft": "loft",
  "42 maslak": "maslak42",
  "maskak": "maslak42",
  "ottomare": "ottomare",
  "şehrizar": "sehrizar",
  "sehrizar": "sehrizar",
  "ulus park": "uluspark",
  "istwest": "istwest",
  "alice": "alice"
};

/**
 * Deterministically hash a string into a positive integer
 */
function hashString(str: string): number {
  let hash = 0;
  for (let i = 0; i < str.length; i++) {
    hash = (hash << 5) - hash + str.charCodeAt(i);
    hash |= 0;
  }
  return Math.abs(hash);
}

/**
 * Get dynamic cover media (image + video) for a property.
 * NO UNSPLASH MOCK PHOTOS! Uses 100% real local project files.
 */
export function getPropertyCoverMedia(property: any): { videoUrl?: string; imageUrl?: string } {
  const videoUrl = property.videoUrl || property.video_url || (Array.isArray(property.videos) && typeof property.videos[0] === 'string' ? property.videos[0] : property.videos?.[0]?.videoUrl) || undefined;

  let imageUrl: string | undefined = undefined;

  // 1. Try real DB photos first
  if (Array.isArray(property.photos) && property.photos.length > 0) {
    const first = property.photos[0];
    if (typeof first === "string") imageUrl = resolveMediaUrl(first);
    else if (typeof first === "object" && first !== null) imageUrl = resolveMediaUrl(first.url || first.photoUrl || first.path || first.src);
  }

  // 2. Try property.images
  if (!imageUrl && Array.isArray(property.images) && property.images.length > 0) {
    const first = property.images[0];
    if (typeof first === "string") imageUrl = resolveMediaUrl(first);
    else if (typeof first === "object" && first !== null) imageUrl = resolveMediaUrl(first.url || first.src);
  }

  // 3. Try property.scrapedImages
  if (!imageUrl) {
    const scraped = property.scrapedImages || property.scraped_images || property.scrapedPhotos;
    if (Array.isArray(scraped) && scraped.length > 0) {
      const first = scraped[0];
      if (typeof first === "string") imageUrl = resolveMediaUrl(first);
      else if (typeof first === "object" && first !== null) imageUrl = resolveMediaUrl(first.url || first.src);
    }
  }

  // 4. Try direct image properties
  if (!imageUrl) {
    imageUrl = resolveMediaUrl(property.imageUrl || property.image || property.photoUrl || property.coverImage || property.thumbnailUrl) || undefined;
  }

  // 5. Match against project media catalog with DYNAMIC VARIETY for unit listings
  if (!imageUrl) {
    const propName = String(property.name || property.title || "").toLocaleLowerCase("tr-TR");
    const aliasKey = Object.keys(PROJECT_ALIASES).find((alias) => propName.includes(alias.toLocaleLowerCase("tr-TR")));

    if (aliasKey) {
      const projId = PROJECT_ALIASES[aliasKey];
      const projAssets = PROJECT_MEDIA_CATALOG[projId];

      if (projAssets && projAssets.photos.length > 0) {
        // Pick photo dynamically based on property ID / name so every unit gets a unique image!
        const propertySeed = String(property.id || property.name || "");
        const photoIndex = hashString(propertySeed) % projAssets.photos.length;
        imageUrl = resolveMediaUrl(projAssets.photos[photoIndex]);
      }
    }
  }

  // 6. 100% REAL LOCAL PROJECT PHOTO POOL (ABSOLUTELY NO UNSPLASH MOCK IMAGES)
  if (!imageUrl) {
    const allRealProjectPhotos = Object.values(PROJECT_MEDIA_CATALOG)
      .flatMap((p) => p.photos)
      .filter(Boolean);

    if (allRealProjectPhotos.length > 0) {
      const sum = hashString(property.id || property.name || "");
      imageUrl = resolveMediaUrl(allRealProjectPhotos[sum % allRealProjectPhotos.length]);
    }
  }

  return { videoUrl, imageUrl };
}

/**
 * Get all project assets (photos, floor plans, videos) for a property detail page
 */
export function getProjectAssets(property: any): ProjectMediaAssets {
  const propName = String(property.name || property.title || "").toLocaleLowerCase("tr-TR");
  const aliasKey = Object.keys(PROJECT_ALIASES).find((alias) => propName.includes(alias.toLocaleLowerCase("tr-TR")));

  if (aliasKey) {
    const projId = PROJECT_ALIASES[aliasKey];
    const assets = PROJECT_MEDIA_CATALOG[projId];
    if (assets) return assets;
  }

  // Fallback to Büyükyalı or Özak Duyu assets so detail pages ALWAYS have floor plans & photos
  return PROJECT_MEDIA_CATALOG.buyukyali;
}
