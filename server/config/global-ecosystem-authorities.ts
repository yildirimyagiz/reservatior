/**
 * Reservatior Global Peripheral Ecosystems & Listing Compliance Engine
 * Maps 23 countries to their exact authorities for Valuation, Conveyancing,
 * Deposit Protection, Golden Visa / Citizenship programs, and required listing documents.
 */

export type RegionCode = 
  | "TR" | "US" | "CA" | "UK" | "DE" | "FR" | "ES" | "IT" 
  | "PT" | "GR" | "AE" | "SA" | "NL" | "BE" | "CH" | "AT" 
  | "AU" | "NZ" | "MY" | "SG" | "JP" | "KR" | "PL";

export type ConveyancingSystem = 
  | "CIVIL_NOTARY_MANDATORY"       // e.g. Germany (Notar), France (Notaire), Spain, Italy
  | "SOLICITOR_MANDATORY"          // e.g. UK, Australia, Ireland, New Zealand
  | "TITLE_INSURANCE_ESCROW"       // e.g. USA, Canada (Title Companies)
  | "HYBRID_LAND_REGISTRY";        // e.g. Turkey (TKGM Web-Tapu & Noter), BAE (DLD Oqood/RERA)

export interface CitizenshipOrResidencyProgram {
  programName: string;
  minValuationUSD: number;
  holdingPeriodYears: number;
  regulatoryAuthority: string;
  mandatoryDocuments: string[];
}

export interface CountryEcosystemProfile {
  regionCode: RegionCode;
  countryName: string;
  conveyancingSystem: ConveyancingSystem;
  valuationAuthority: string;
  valuationRequiredFor: Array<"MORTGAGE" | "CITIZENSHIP_OR_VISA" | "FOREIGNER_SALE" | "TAX_ASSESS">;
  depositProtectionScheme?: string;
  citizenshipOrVisaProgram?: CitizenshipOrResidencyProgram;
  listingOnboardingRequirement: {
    requireTitleDeedDate: boolean;
    requireDeclaredValue: boolean;
    requireValuationReport: boolean;
    mandatoryUploads: Array<{ id: string; name: string; description: string }>;
  };
}

export const GLOBAL_ECOSYSTEM_AUTHORITIES: Record<RegionCode, CountryEcosystemProfile> = {
  TR: {
    regionCode: "TR",
    countryName: "Turkey",
    conveyancingSystem: "HYBRID_LAND_REGISTRY",
    valuationAuthority: "SPK / BDDK (WEB-TAPU Lisanslı Gayrimenkul Değerleme)",
    valuationRequiredFor: ["CITIZENSHIP_OR_VISA", "MORTGAGE", "FOREIGNER_SALE", "TAX_ASSESS"],
    depositProtectionScheme: "TBK Art. 342 Conditional Time-Deposit Bank Account",
    citizenshipOrVisaProgram: {
      programName: "Turkish Citizenship by Investment (İstisnai Vatandaşlık)",
      minValuationUSD: 400000,
      holdingPeriodYears: 3,
      regulatoryAuthority: "TKGM / Göç İdaresi / Çevre Şehircilik Bakanlığı",
      mandatoryDocuments: ["SPK_VALUATION_REPORT", "DAB_BANK_EXCHANGE_RECEIPT", "TITLE_DEED"]
    },
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: true,
      mandatoryUploads: [
        { id: "tapu", name: "Tapu Senedi (Title Deed)", description: "Web-Tapu barkodlu güncel tapu kaydı veya senedi" },
        { id: "spk_report", name: "SPK Değerleme Raporu", description: "Vatandaşlık veya yabancı satışı / kredi için onaylı eksper raporu" },
        { id: "epc_document", name: "Enerji Kimlik Belgesi (EKB)", description: "Yasal zorunlu bina enerji verimliliği belgesi" }
      ]
    }
  },
  UK: {
    regionCode: "UK",
    countryName: "United Kingdom",
    conveyancingSystem: "SOLICITOR_MANDATORY",
    valuationAuthority: "RICS (Royal Institution of Chartered Surveyors)",
    valuationRequiredFor: ["MORTGAGE", "TAX_ASSESS"],
    depositProtectionScheme: "TDS / DPS / MyDeposits Mandatory Government Pool",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: false,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "title_absolute", name: "HM Land Registry Title Absolute", description: "Official Title Plan and Register register from HM Land Registry" },
        { id: "epc", name: "EPC Certificate (Grade A-E)", description: "Energy Performance Certificate with min band E rating" },
        { id: "gas_safety", name: "CP12 Gas Safety Record", description: "Mandatory annual Landlord Gas Safety Certificate" }
      ]
    }
  },
  AE: {
    regionCode: "AE",
    countryName: "United Arab Emirates",
    conveyancingSystem: "HYBRID_LAND_REGISTRY",
    valuationAuthority: "RERA Taqyoom / DLD Valuation Department",
    valuationRequiredFor: ["CITIZENSHIP_OR_VISA", "MORTGAGE", "FOREIGNER_SALE"],
    depositProtectionScheme: "RERA Escrow Trust Account",
    citizenshipOrVisaProgram: {
      programName: "UAE 10-Year Golden Visa (Property Investor)",
      minValuationUSD: 545000, // Equivalent to ~2,000,000 AED
      holdingPeriodYears: 0,
      regulatoryAuthority: "Dubai Land Department (DLD) & GDRFA",
      mandatoryDocuments: ["DLD_TITLE_DEED_OR_OQOOD", "TAQYOOM_VALUATION"]
    },
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: true,
      mandatoryUploads: [
        { id: "title_deed", name: "DLD Title Deed / Oqood", description: "Official Dubai Land Department Title Deed or Off-Plan Oqood registration" },
        { id: "taqyoom", name: "RERA Taqyoom Valuation", description: "Official valuation certificate required for mortgage or visa sponsorship" }
      ]
    }
  },
  DE: {
    regionCode: "DE",
    countryName: "Germany",
    conveyancingSystem: "CIVIL_NOTARY_MANDATORY",
    valuationAuthority: "Gutachterausschuss & ImmoWertV Yeminli Değerleme",
    valuationRequiredFor: ["MORTGAGE", "TAX_ASSESS"],
    depositProtectionScheme: "Mietkautionskonto / Kautionsbürgschaft",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "grundbuch", name: "Grundbuchauszug (Land Register Extract)", description: "Current section 1 & 2 land register deed certified by court" },
        { id: "energieausweis", name: "Energieausweis (Energy ID)", description: "Mandatory building efficiency pass (Verbrauch or Bedarf)" },
        { id: "flurkarte", name: "Flurkarte / Liegenschaftskarte", description: "Cadastral map of the property plot" }
      ]
    }
  },
  US: {
    regionCode: "US",
    countryName: "United States",
    conveyancingSystem: "TITLE_INSURANCE_ESCROW",
    valuationAuthority: "Appraisal Institute (MAI) / Fannie Mae AMC",
    valuationRequiredFor: ["MORTGAGE", "TAX_ASSESS"],
    depositProtectionScheme: "State Real Estate Trust / Escrow Account Rules",
    listingOnboardingRequirement: {
      requireTitleDeedDate: false,
      requireDeclaredValue: false,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "title_policy", name: "Title Insurance Policy / Grant Deed", description: "Stewart, First American, or recorded county clerk Grant Deed" },
        { id: "property_tax_statement", name: "County Tax Assessment Statement", description: "Latest property property taxes assessment and lot valuation" }
      ]
    }
  },
  ES: {
    regionCode: "ES",
    countryName: "Spain",
    conveyancingSystem: "CIVIL_NOTARY_MANDATORY",
    valuationAuthority: "Tasación Homologada (Banco de España / RICS)",
    valuationRequiredFor: ["CITIZENSHIP_OR_VISA", "MORTGAGE"],
    depositProtectionScheme: "Fianza deposit (Fincas / Instituto de la Vivienda)",
    citizenshipOrVisaProgram: {
      programName: "Spanish Golden Visa (Inversor Inmobiliario)",
      minValuationUSD: 540000, // ~500,000 EUR unmortgaged
      holdingPeriodYears: 5,
      regulatoryAuthority: "Ministerio de Asuntos Exteriores / Registro de la Propiedad",
      mandatoryDocuments: ["ESCRITURA_PUBLICA", "TASACION_HOMOLOGADA"]
    },
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: true,
      mandatoryUploads: [
        { id: "escritura", name: "Escritura Pública & Nota Simple", description: "Notarized public deed & recent land registry informative note" },
        { id: "cee", name: "Certificado de Eficiencia Energética", description: "Mandatory energy compliance certificate" }
      ]
    }
  },
  GR: {
    regionCode: "GR",
    countryName: "Greece",
    conveyancingSystem: "CIVIL_NOTARY_MANDATORY",
    valuationAuthority: "Certified Valuer (Association of Greek Valuers / RICS)",
    valuationRequiredFor: ["CITIZENSHIP_OR_VISA", "MORTGAGE"],
    depositProtectionScheme: "Bank Escrow / Rental Lease Electronic TaxisNet Registration",
    citizenshipOrVisaProgram: {
      programName: "Greek Golden Visa Program",
      minValuationUSD: 270000, // ~250,000 EUR in specific zones (or ~800,000 EUR in Athens/Mykonos)
      holdingPeriodYears: 5,
      regulatoryAuthority: "Ministry of Migration & Land Registry (Ktimatologio)",
      mandatoryDocuments: ["NOTARIAL_DEED_OF_TRANSFER", "BANK_TRANSFER_RECEIPT"]
    },
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: true,
      mandatoryUploads: [
        { id: "ktimatologio", name: "Ktimatologio Deed Extract", description: "National Cadastre land registry verification" },
        { id: "energy_certificate", name: "PEA Energy Efficiency Certificate", description: "Greek energy performance qualification report" }
      ]
    }
  },
  AU: {
    regionCode: "AU",
    countryName: "Australia",
    conveyancingSystem: "SOLICITOR_MANDATORY",
    valuationAuthority: "Australian Property Institute (API / RICS)",
    valuationRequiredFor: ["MORTGAGE", "FOREIGNER_SALE"],
    depositProtectionScheme: "RTBA (Residential Tenancies Bond Authority) Mandatory Pool",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "pexa_title", name: "PEXA Digital Title / Land Title Certificate", description: "Electronic title registry proof from Torrens Title database" },
        { id: "section_32", name: "Section 32 Vendor Statement", description: "Mandatory seller legal statement of outgoings and covenants" }
      ]
    }
  },
  CA: {
    regionCode: "CA",
    countryName: "Canada",
    conveyancingSystem: "TITLE_INSURANCE_ESCROW",
    valuationAuthority: "Appraisal Institute of Canada (AIC / AACI)",
    valuationRequiredFor: ["MORTGAGE"],
    depositProtectionScheme: "Provincial Residential Tenancies Deposit Regulations",
    listingOnboardingRequirement: {
      requireTitleDeedDate: false,
      requireDeclaredValue: false,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "land_title_certificate", name: "Land Title Registration", description: "Provincial title search proving fee simple ownership" }
      ]
    }
  },
  FR: {
    regionCode: "FR",
    countryName: "France",
    conveyancingSystem: "CIVIL_NOTARY_MANDATORY",
    valuationAuthority: "Expert Immobilier Agréé / TEGoVA",
    valuationRequiredFor: ["MORTGAGE", "TAX_ASSESS"],
    depositProtectionScheme: "Compte Séquestre Notarial or Garantie Visale",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "acte_de_propriete", name: "Acte de Propriété (Notarial Deed)", description: "Certified deed signed and stamped by public Notaire" },
        { id: "dpe", name: "Diagnostic de Performance Énergétique (DPE)", description: "Strict energy pass; housing ratings F & G face rental bans" },
        { id: "loi_carrez", name: "Loi Carrez Surface Certificate", description: "Mandatory professional floor area measurement" }
      ]
    }
  },
  IT: {
    regionCode: "IT",
    countryName: "Italy",
    conveyancingSystem: "CIVIL_NOTARY_MANDATORY",
    valuationAuthority: "Perito Immobiliare / OMI (Agenzia delle Entrate)",
    valuationRequiredFor: ["MORTGAGE", "TAX_ASSESS"],
    depositProtectionScheme: "Deposito Cauzionale in Bank Libretto or Surety",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "atto_di_provenienza", name: "Atto di Provenienza (Title Deed)", description: "Notarized transfer deed registered with Conservatoria" },
        { id: "visura_catastale", name: "Visura Catastale", description: "Official cadastral search with municipal zoning data" },
        { id: "ape", name: "Attestato di Prestazione Energetica (APE)", description: "Compulsory energy performance evaluation" }
      ]
    }
  },
  PT: {
    regionCode: "PT",
    countryName: "Portugal",
    conveyancingSystem: "CIVIL_NOTARY_MANDATORY",
    valuationAuthority: "Perito Avaliador Certificado (CMVM / RICS)",
    valuationRequiredFor: ["MORTGAGE"],
    depositProtectionScheme: "Escrow Bank Account",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "certidao_permanente", name: "Certidão Permanente do Registo Predial", description: "Digital permanent land registry certificate" },
        { id: "caderneta_predial", name: "Caderneta Predial Urbana", description: "Tax office identification document of the property" }
      ]
    }
  },
  SA: {
    regionCode: "SA",
    countryName: "Saudi Arabia",
    conveyancingSystem: "HYBRID_LAND_REGISTRY",
    valuationAuthority: "Taqeem (Saudi Authority for Accredited Valuers)",
    valuationRequiredFor: ["MORTGAGE", "FOREIGNER_SALE", "TAX_ASSESS"],
    depositProtectionScheme: "Ejar Mandatory Electronic Escrow Platform",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: true,
      mandatoryUploads: [
        { id: "moj_title_deed", name: "Ministry of Justice Electronic Title Deed", description: "Digital Sak registered in the national MoJ portal" },
        { id: "taqeem_report", name: "Taqeem Approved Valuation", description: "Official property valuation conducted by licensed Taqeem valuers" }
      ]
    }
  },
  NL: {
    regionCode: "NL",
    countryName: "Netherlands",
    conveyancingSystem: "CIVIL_NOTARY_MANDATORY",
    valuationAuthority: "NWWI (Nederlands Woning Waarde Instituut) / NRVT Valuers",
    valuationRequiredFor: ["MORTGAGE", "TAX_ASSESS"],
    depositProtectionScheme: "Escrow Notary Account (Kwaliteitsrekening)",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: true,
      mandatoryUploads: [
        { id: "kadaster_uittreksel", name: "Kadaster Uittreksel Eigendom", description: "Official excerpt of title ownership from Dutch Kadaster" },
        { id: "energielabel", name: "Definitief Energielabel", description: "Registered digital energy rating index certificate" }
      ]
    }
  },
  BE: {
    regionCode: "BE",
    countryName: "Belgium",
    conveyancingSystem: "CIVIL_NOTARY_MANDATORY",
    valuationAuthority: "Expert Immobilier / Federatie van Immobiliën",
    valuationRequiredFor: ["MORTGAGE", "TAX_ASSESS"],
    depositProtectionScheme: "Compte Bloqué en Banque (Blocked Bank Account)",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "acte_notarié", name: "Notarial Deed of Ownership", description: "Registered title deed executed by Belgian Notary" },
        { id: "peb_certificate", name: "PEB / EPC Energy Certificate", description: "Regional obligatory energy efficiency certificate" }
      ]
    }
  },
  CH: {
    regionCode: "CH",
    countryName: "Switzerland",
    conveyancingSystem: "CIVIL_NOTARY_MANDATORY",
    valuationAuthority: "SEV / SVK Expert Property Valuer",
    valuationRequiredFor: ["MORTGAGE", "FOREIGNER_SALE", "TAX_ASSESS"],
    depositProtectionScheme: "Mietkautionskonto (Max 3 months in regulated escrow)",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "grundbuchauszug", name: "Grundbuchauszug (Land Register Extract)", description: "Certified cantonal land registry excerpt" }
      ]
    }
  },
  AT: {
    regionCode: "AT",
    countryName: "Austria",
    conveyancingSystem: "CIVIL_NOTARY_MANDATORY",
    valuationAuthority: "Gerichtlich zertifizierter Sachverständiger",
    valuationRequiredFor: ["MORTGAGE", "TAX_ASSESS"],
    depositProtectionScheme: "Mietkautionsbuch or Bank Guarantee",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "grundbuchauszug", name: "Grundbuchauszug (Land Register Copy)", description: "Official court extraction from the Austrian Grundbuch" },
        { id: "energieausweis", name: "Energieausweis", description: "Mandatory thermal efficiency calculation report" }
      ]
    }
  },
  NZ: {
    regionCode: "NZ",
    countryName: "New Zealand",
    conveyancingSystem: "SOLICITOR_MANDATORY",
    valuationAuthority: "Property Institute of New Zealand (PINZ / Registered Valuer)",
    valuationRequiredFor: ["MORTGAGE", "FOREIGNER_SALE"],
    depositProtectionScheme: "Tenancy Services Bond (Government Held)",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: false,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "record_of_title", name: "LINZ Record of Title", description: "Official Land Information New Zealand digital title search" }
      ]
    }
  },
  MY: {
    regionCode: "MY",
    countryName: "Malaysia",
    conveyancingSystem: "SOLICITOR_MANDATORY",
    valuationAuthority: "Jabatan Penilaian dan Perkhidmatan Harta (JPPH / RICS)",
    valuationRequiredFor: ["MORTGAGE", "FOREIGNER_SALE"],
    depositProtectionScheme: "Client Account of Registered Property Agency / Escrow",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "geran_tanah", name: "Geran Tanah / Strata Title", description: "Certified copy of national land code grant or strata title" }
      ]
    }
  },
  SG: {
    regionCode: "SG",
    countryName: "Singapore",
    conveyancingSystem: "SOLICITOR_MANDATORY",
    valuationAuthority: "Singapore Institute of Surveyors and Valuers (SISV)",
    valuationRequiredFor: ["MORTGAGE", "TAX_ASSESS", "FOREIGNER_SALE"],
    depositProtectionScheme: "Escrow Account held by Law Firm / CEA Guidelines",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "sla_title_search", name: "SLA INLIS Title Search", description: "Singapore Land Authority integrated digital land title extract" }
      ]
    }
  },
  JP: {
    regionCode: "JP",
    countryName: "Japan",
    conveyancingSystem: "HYBRID_LAND_REGISTRY",
    valuationAuthority: "Fudousan Kanteishi (Licensed Real Estate Appraiser)",
    valuationRequiredFor: ["MORTGAGE", "TAX_ASSESS"],
    depositProtectionScheme: "Escrow managed by Judicial Scrivener (Shiho-shoshi)",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: false,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "tokubi_bo", name: "Toukibo-tohon (Certificate of Registered Matters)", description: "Legal title record issued by the Legal Affairs Bureau" }
      ]
    }
  },
  KR: {
    regionCode: "KR",
    countryName: "South Korea",
    conveyancingSystem: "HYBRID_LAND_REGISTRY",
    valuationAuthority: "Korea Real Estate Appraisal Association (KAPA)",
    valuationRequiredFor: ["MORTGAGE", "TAX_ASSESS"],
    depositProtectionScheme: "Jeonse Title Insurance (HUG / SGI Guarantee)",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "deunggibo", name: "Deunggi-boodoongbbon (Real Estate Registration)", description: "Official registry extract issued by Supreme Court registry office" }
      ]
    }
  },
  PL: {
    regionCode: "PL",
    countryName: "Poland",
    conveyancingSystem: "CIVIL_NOTARY_MANDATORY",
    valuationAuthority: "Rzeczoznawca Majątkowy (Certified Property Valuer)",
    valuationRequiredFor: ["MORTGAGE", "TAX_ASSESS"],
    depositProtectionScheme: "Escrow Account (Rachunek Powierniczy) / Deposit",
    listingOnboardingRequirement: {
      requireTitleDeedDate: true,
      requireDeclaredValue: true,
      requireValuationReport: false,
      mandatoryUploads: [
        { id: "ksiega_wieczysta", name: "Księga Wieczysta (Land & Mortgage Register)", description: "Electronic judicial land registry book extraction" }
      ]
    }
  }
};

/**
 * Helper to fetch onboarding legal rules for any given country code.
 */
export function getCountryEcosystemProfile(code: string): CountryEcosystemProfile {
  const norm = code.toUpperCase() as RegionCode;
  return GLOBAL_ECOSYSTEM_AUTHORITIES[norm] || GLOBAL_ECOSYSTEM_AUTHORITIES["US"];
}
