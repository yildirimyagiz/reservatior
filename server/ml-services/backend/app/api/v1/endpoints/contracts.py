from fastapi import APIRouter, HTTPException
from pydantic import BaseModel
from typing import Optional, Dict, Any, List
import datetime
import uuid

router = APIRouter()

# ─── Contract types (mirror of server/config/contract-engine.ts) ────────────
CONTRACT_TYPES = [
    "RESIDENTIAL_LEASE",
    "COMMERCIAL_LEASE",
    "SHORT_TERM_BOOKING",
    "SALES_AGREEMENT",
    "EARNEST_MONEY",
    "EVICTION_COMMITMENT",
    "AGENCY_REPRESENTATION",
    "PROPERTY_MANAGEMENT",
]

LEGACY_TYPE_MAP = {
    "SALES": "SALES_AGREEMENT",
    "RENTAL": "RESIDENTIAL_LEASE",
    "LEASE": "RESIDENTIAL_LEASE",
}

# ─── Country profiles (mirror of country-contract-config.ts) ────────────────
COUNTRY_PROFILES = {
    "TR": {"name_en": "Turkey", "currency": "TRY", "default_lang": "tr", "languages": ["tr", "en"],
           "legal_basis": "Türk Borçlar Kanunu ve Taşınmaz Ticareti Hakkında Yönetmelik",
           "jurisdiction": "Türkiye", "regulator": "Çevre, Şehircilik ve İklim Değişikliği Bakanlığı"},
    "USA": {"name_en": "United States", "currency": "USD", "default_lang": "en", "languages": ["en", "es"],
            "legal_basis": "applicable state statutes and the federal Fair Housing Act",
            "jurisdiction": "the United States", "regulator": "state real estate commissions (NAR code of ethics)"},
    "CA": {"name_en": "Canada", "currency": "CAD", "default_lang": "en", "languages": ["en", "fr"],
           "legal_basis": "applicable provincial statutes and the Canadian federal regulations",
           "jurisdiction": "Canada", "regulator": "provincial real estate councils"},
    "MX": {"name_en": "Mexico", "currency": "MXN", "default_lang": "es", "languages": ["es", "en"],
           "legal_basis": "Código Civil Federal y leyes estatales aplicables",
           "jurisdiction": "México", "regulator": "registros públicos de la propiedad estatales"},
    "UK": {"name_en": "United Kingdom", "currency": "GBP", "default_lang": "en", "languages": ["en"],
           "legal_basis": "the Law of Property Act 1925 and the Housing Act 1988",
           "jurisdiction": "England & Wales", "regulator": "HMRC (Stamp Duty) and property ombudsman"},
    "DE": {"name_en": "Germany", "currency": "EUR", "default_lang": "de", "languages": ["de", "en"],
           "legal_basis": "Bürgerliches Gesetzbuch (BGB)",
           "jurisdiction": "Bundesrepublik Deutschland", "regulator": "Gewerbeämter / Maklerschlichtungsstelle"},
    "FR": {"name_en": "France", "currency": "EUR", "default_lang": "fr", "languages": ["fr", "en"],
           "legal_basis": "Code civil et loi Alur",
           "jurisdiction": "République française", "regulator": "Direction départementale des territoires"},
    "ES": {"name_en": "Spain", "currency": "EUR", "default_lang": "es", "languages": ["es", "en"],
           "legal_basis": "Ley de Arrendamientos Urbanos y Código Civil",
           "jurisdiction": "España", "regulator": "Registradores de la Propiedad"},
    "IT": {"name_en": "Italy", "currency": "EUR", "default_lang": "it", "languages": ["it", "en"],
           "legal_basis": "Codice Civile italiano",
           "jurisdiction": "Italia", "regulator": "Agenzia delle Entrate (registrazione)"},
    "NL": {"name_en": "Netherlands", "currency": "EUR", "default_lang": "nl", "languages": ["nl", "en"],
           "legal_basis": "Burgerlijk Wetboek",
           "jurisdiction": "Nederland", "regulator": "Rijksdienst voor Ondernemend Nederland"},
    "BR": {"name_en": "Brazil", "currency": "BRL", "default_lang": "pt", "languages": ["pt", "en"],
           "legal_basis": "Código Civil e Lei do Inquilinato (Lei 8.245/91)",
           "jurisdiction": "Brasil", "regulator": "Cartórios de Registro de Imóveis"},
    "AR": {"name_en": "Argentina", "currency": "ARS", "default_lang": "es", "languages": ["es", "en"],
           "legal_basis": "Código Civil y Comercial de la Nación",
           "jurisdiction": "Argentina", "regulator": "Dirección Nacional de Registro de la Propiedad"},
    "AU": {"name_en": "Australia", "currency": "AUD", "default_lang": "en", "languages": ["en"],
           "legal_basis": "applicable State and Territory real estate legislation",
           "jurisdiction": "Australia", "regulator": "state/territory real estate regulators"},
    "NZ": {"name_en": "New Zealand", "currency": "NZD", "default_lang": "en", "languages": ["en"],
           "legal_basis": "the Residential Tenancies Act 1986 and Property Law Act 2007",
           "jurisdiction": "New Zealand", "regulator": "Ministry of Business, Innovation and Employment"},
    "JP": {"name_en": "Japan", "currency": "JPY", "default_lang": "ja", "languages": ["ja", "en"],
           "legal_basis": "民法（借地借家法）および宅地建物取引業法",
           "jurisdiction": "日本", "regulator": "国土交通省"},
    "KR": {"name_en": "South Korea", "currency": "KRW", "default_lang": "ko", "languages": ["ko", "en"],
           "legal_basis": "민법 및 주택임대차보호법",
           "jurisdiction": "대한민국", "regulator": "국토교통부"},
    "CN": {"name_en": "China", "currency": "CNY", "default_lang": "zh", "languages": ["zh", "en"],
           "legal_basis": "《中华人民共和国民法典》及房地产相关法规",
           "jurisdiction": "中华人民共和国", "regulator": "住房和城乡建设部"},
    "IN": {"name_en": "India", "currency": "INR", "default_lang": "hi", "languages": ["hi", "en"],
           "legal_basis": "the Transfer of Property Act 1882 and applicable State Rent Acts",
           "jurisdiction": "India", "regulator": "State Registration Departments"},
    "SG": {"name_en": "Singapore", "currency": "SGD", "default_lang": "en", "languages": ["en", "ms"],
           "legal_basis": "the Land Titles Act and Property Tax Act",
           "jurisdiction": "Singapore", "regulator": "Singapore Land Authority"},
    "MY": {"name_en": "Malaysia", "currency": "MYR", "default_lang": "ms", "languages": ["ms", "en"],
           "legal_basis": "National Land Code 1965 and Housing Development Act",
           "jurisdiction": "Malaysia", "regulator": "Lembaga Penilai, Pentaksir, Ejen Harta Tanah"},
    "TH": {"name_en": "Thailand", "currency": "THB", "default_lang": "th", "languages": ["th", "en"],
           "legal_basis": "ประมวลกฎหมายแพ่งและพาณิชย์",
           "jurisdiction": "ประเทศไทย", "regulator": "กรมที่ดิน"},
    "AE": {"name_en": "United Arab Emirates", "currency": "AED", "default_lang": "ar", "languages": ["ar", "en"],
           "legal_basis": "قانون المعاملات المدنية وقوانين الإمارات المحلية",
           "jurisdiction": "الإمارات العربية المتحدة", "regulator": "دوائر الأراضي والأملاك المحلية (دبي: RERA)"},
    "SA": {"name_en": "Saudi Arabia", "currency": "SAR", "default_lang": "ar", "languages": ["ar", "en"],
           "legal_basis": "النظام المدني السعودي والأنظمة العقارية",
           "jurisdiction": "المملكة العربية السعودية", "regulator": "الهيئة العامة للعقار (REGA)"},
}

LANGUAGE_NAMES = {
    "tr": "Türkçe", "en": "English", "ar": "العربية", "de": "Deutsch", "fr": "Français",
    "es": "Español", "it": "Italiano", "ru": "Русский", "pt": "Português", "ja": "日本語",
    "nl": "Nederlands", "ko": "한국어", "zh": "中文", "hi": "हिन्दी", "th": "ไทย", "ms": "Bahasa Melayu",
}

TYPE_TITLES = {
    "RESIDENTIAL_LEASE": {"tr": "Konut Kira Sözleşmesi", "en": "Residential Lease Agreement",
                          "ar": "عقد إيجار سكني", "de": "Mietvertrag (Wohnraum)", "fr": "Contrat de location résidentielle",
                          "es": "Contrato de Arrendamiento de Vivienda", "it": "Contratto di Locazione Residenziale",
                          "ja": "居住用賃貸借契約", "zh": "住宅租赁合同", "ko": "주택임대차계약서"},
    "COMMERCIAL_LEASE": {"tr": "İşyeri Kira Sözleşmesi", "en": "Commercial Lease Agreement",
                         "ar": "عقد إيجار تجاري", "de": "Gewerbemietvertrag", "fr": "Bail commercial",
                         "es": "Contrato de Arrendamiento Comercial", "it": "Contratto di Locazione Commerciale",
                         "ja": "事業用賃貸借契約", "zh": "商业租赁合同", "ko": "상가임대차계약서"},
    "SHORT_TERM_BOOKING": {"tr": "Kısa Süreli Konaklama Sözleşmesi", "en": "Short-Term Booking Agreement",
                           "ar": "عقد إقامة قصيرة الأمد", "de": "Kurzzeitvermietungsvertrag", "fr": "Contrat de séjour de courte durée",
                           "es": "Contrato de Alojamiento de Corta Estancia", "it": "Contratto di Soggiorno di Breve Durata",
                           "ja": "短期滞在予約契約", "zh": "短期住宿协议", "ko": "단기 숙박 계약서"},
    "SALES_AGREEMENT": {"tr": "Gayrimenkul Satış Sözleşmesi", "en": "Property Sale Agreement",
                        "ar": "اتفاقية بيع عقار", "de": "Immobilienkaufvertrag", "fr": "Compromis de vente immobilier",
                        "es": "Contrato de Compraventa Inmobiliaria", "it": "Contratto Preliminare di Compravendita Immobiliare",
                        "ja": "不動産売買契約", "zh": "不动产买卖合同", "ko": "부동산매매계약서"},
    "EARNEST_MONEY": {"tr": "Kapora Sözleşmesi", "en": "Earnest Money Agreement",
                      "ar": "اتفاقية العربون", "de": "Kaufpreisanzahlungsvereinbarung", "fr": "Contrat d'arrhes",
                      "es": "Contrato de Arras", "it": "Contratto di Caparra", "ja": "手付金契約", "zh": "定金协议", "ko": "계약금약정서"},
    "EVICTION_COMMITMENT": {"tr": "Tahliye Taahhüdü", "en": "Eviction Commitment",
                            "ar": "تعهد بالإخلاء", "de": "Räumungsverpflichtung", "fr": "Engagement d'expulsion",
                            "es": "Compromiso de Desocupación", "it": "Impegno di Rilascio", "ja": "明渡しの確約", "zh": "腾退承诺书", "ko": "명도 확약서"},
    "AGENCY_REPRESENTATION": {"tr": "Satılık Emlakçılık Yetki Sözleşmesi", "en": "Agency Representation Agreement",
                              "ar": "اتفاقية تمثيل الوكالة", "de": "Makleralleinauftrag", "fr": "Mandat de représentation",
                              "es": "Contrato de Agencia Inmobiliaria", "it": "Contratto di Mandato d'Agenzia",
                              "ja": "媒介契約書", "zh": "代理委托合同", "ko": "중개대행계약서"},
    "PROPERTY_MANAGEMENT": {"tr": "Gayrimenkul Yönetim Sözleşmesi", "en": "Property Management Agreement",
                            "ar": "اتفاقية إدارة العقارات", "de": "Verwaltungsvertrag", "fr": "Contrat de gestion immobilière",
                            "es": "Contrato de Gestión de la Propiedad", "it": "Contratto di Gestione Immobiliare",
                            "ja": "不動産管理委託契約", "zh": "物业管理委托合同", "ko": "부동산관리위탁계약서"},
}

# ─── Request models ──────────────────────────────────────────────────────────
class PropertyInfo(BaseModel):
    id: Optional[str] = None
    address: str
    city: str
    country: Optional[str] = None
    price: Optional[float] = None
    currency: Optional[str] = None
    property_type: Optional[str] = None
    parcel_id: Optional[str] = None
    type: Optional[str] = None

class PersonInfo(BaseModel):
    full_name: str
    identification_number: Optional[str] = None
    address: Optional[str] = None
    phone: Optional[str] = None
    email: Optional[str] = None

class FinancialsInfo(BaseModel):
    price: Optional[float] = None
    currency: Optional[str] = None
    deposit_amount: Optional[float] = None
    start_date: Optional[str] = None
    end_date: Optional[str] = None
    term_months: Optional[int] = None
    is_zero_deposit: Optional[bool] = False
    commission_rate: Optional[float] = None
    commission_model: Optional[str] = None
    management_fee_pct: Optional[float] = None
    service_fee: Optional[float] = None

class ContractData(BaseModel):
    org_id: Optional[str] = None
    property: Optional[PropertyInfo] = None
    landlord_or_seller: Optional[PersonInfo] = None
    tenant_or_buyer: Optional[PersonInfo] = None
    agent: Optional[PersonInfo] = None
    platform: Optional[PersonInfo] = None
    financials: Optional[FinancialsInfo] = None
    additional_terms: Optional[str] = None

class ContractRequest(BaseModel):
    country: Optional[str] = None
    country_code: Optional[str] = None          # legacy alias
    contract_type: str
    language: Optional[str] = None
    data: Optional[Dict[str, Any]] = None
    # legacy flat fields
    property: Optional[PropertyInfo] = None
    owner: Optional[PersonInfo] = None
    buyer_or_tenant: Optional[PersonInfo] = None
    additional_terms: Optional[str] = None

class ContractResponse(BaseModel):
    contract_id: str
    content_markdown: str
    country_applied: str
    contract_type: str
    language: str
    generated_at: str

# ─── Helpers ─────────────────────────────────────────────────────────────────
def _resolve_country(request: ContractRequest) -> str:
    code = (request.country or request.country_code or "US").upper()
    if code in ("GB",):
        return "UK"
    if code == "US":
        return "USA"
    if code not in COUNTRY_PROFILES:
        raise HTTPException(status_code=400, detail=f"Unsupported country: {code}")
    return code

def _resolve_type(raw: str) -> str:
    ctype = raw.upper()
    if ctype in LEGACY_TYPE_MAP:
        return LEGACY_TYPE_MAP[ctype]
    if ctype not in CONTRACT_TYPES:
        raise HTTPException(status_code=400, detail=f"Unsupported contract type: {raw}")
    return ctype

def _normalise_data(request: ContractRequest) -> ContractData:
    """Accept both the new `data` payload and the legacy flat fields."""
    if request.data:
        return ContractData(**request.data)
    return ContractData(
        property=request.property,
        landlord_or_seller=request.owner,
        tenant_or_buyer=request.buyer_or_tenant,
        additional_terms=request.additional_terms,
    )

def _pick_language(request: ContractRequest, country: str) -> str:
    lang = (request.language or "").lower()
    profile = COUNTRY_PROFILES[country]
    if lang in profile["languages"]:
        return lang
    return profile["default_lang"]

def _title(ctype: str, lang: str) -> str:
    titles = TYPE_TITLES.get(ctype, {})
    return titles.get(lang) or titles.get("en") or ctype.replace("_", " ").title()

def _render(data: ContractData, country: str, ctype: str, lang: str, additional_terms: str) -> str:
    profile = COUNTRY_PROFILES[country]
    fin = data.financials or FinancialsInfo()
    prop = data.property
    owner = data.landlord_or_seller
    party = data.tenant_or_buyer
    agent = data.agent
    currency = fin.currency or profile["currency"]

    property_line = f"{prop.address}, {prop.city}" if prop else "—"
    if prop and (prop.parcel_id or getattr(prop, "type", None)):
        property_line += f" (Ref: {prop.parcel_id or ''})"

    price_label = "Rent" if "LEASE" in ctype or ctype == "SHORT_TERM_BOOKING" else "Price"
    price_line = f"{price_label}: {fin.price} {currency}" if fin.price else f"{price_label}: —"

    md = [
        f"# {_title(ctype, lang)}",
        "",
        f"**Date:** {datetime.date.today().isoformat()}",
        f"**Country:** {profile['name_en']} ({country})",
        f"**Language:** {LANGUAGE_NAMES.get(lang, lang)}",
        f"**Legal Basis:** {profile['legal_basis']}",
        f"**Jurisdiction:** {profile['jurisdiction']}",
        f"**Regulator:** {profile['regulator']}",
        "",
        "## 1. The Parties",
    ]

    if owner:
        md += [
            f"- **{('Seller' if ctype == 'SALES_AGREEMENT' else 'Landlord/Owner')}:** {owner.full_name}",
            f"  ID/Passport: {owner.identification_number or '—'}",
            f"  Address: {owner.address or '—'}",
        ]
    if party:
        role = "Buyer" if ctype == "SALES_AGREEMENT" else "Tenant"
        md += [
            f"- **{role}:** {party.full_name}",
            f"  ID/Passport: {party.identification_number or '—'}",
            f"  Address: {party.address or '—'}",
        ]
    if agent:
        md += [
            f"- **Real Estate Agent:** {agent.full_name}",
            f"  License No: {agent.identification_number or '—'}",
        ]

    md += [
        "",
        "## 2. Property Information",
        f"- Address: {property_line}",
        f"- Property Type: {(prop.type if prop and prop.type else (prop.property_type if prop else '')) or '—'}",
        f"- {price_line}",
    ]

    if ctype in ("RESIDENTIAL_LEASE", "COMMERCIAL_LEASE"):
        md += [
            "- " + (f"Deposit: {fin.deposit_amount} {currency}" if not fin.is_zero_deposit else "Deposit: waived (zero-deposit scheme)"),
            "- " + (f"Term: {fin.term_months} months" if fin.term_months else "Term: —"),
            "- " + (f"Start: {fin.start_date}" if fin.start_date else "Start: —"),
            "- " + (f"End: {fin.end_date}" if fin.end_date else "End: —"),
        ]
    elif ctype in ("AGENCY_REPRESENTATION", "PROPERTY_MANAGEMENT"):
        md += [
            "- " + (f"Commission Rate: {fin.commission_rate}%" if fin.commission_rate else "").rstrip(),
            "- " + (f"Commission Model: {fin.commission_model}" if fin.commission_model else "").rstrip(),
            "- " + (f"Management Fee: {fin.management_fee_pct}%" if fin.management_fee_pct else "").rstrip(),
            "- Scope: marketing, showings, paperwork, and platform compliance duties as mutually agreed.",
        ]
        md = [ln for ln in md if not ln.endswith(": ") and ln != "- "]

    md += [
        "",
        "## 3. Additional Terms",
        additional_terms if additional_terms else "Standard terms and conditions apply.",
        "",
        "## 4. Signatures",
        "",
        "_______________________                     _______________________",
        "Owner Signature                             Counterparty Signature",
        "",
    ]
    if agent:
        md += ["_______________________", "Agent Signature", ""]
    return "\n".join(md)

# ─── Endpoints ───────────────────────────────────────────────────────────────
@router.get("/templates", response_model=Dict[str, Any])
async def list_templates() -> Dict[str, Any]:
    """Catalog of supported countries, contract types and languages."""
    return {
        "success": True,
        "generated_at": datetime.datetime.utcnow().isoformat(),
        "languages": LANGUAGE_NAMES,
        "contract_types": CONTRACT_TYPES,
        "countries": [
            {
                "country": code,
                "country_name_en": p["name_en"],
                "currency": p["currency"],
                "default_language": p["default_lang"],
                "languages": p["languages"],
                "legal_basis": p["legal_basis"],
            }
            for code, p in COUNTRY_PROFILES.items()
        ],
    }

@router.post("/generate", response_model=ContractResponse)
async def generate_contract(request: ContractRequest) -> ContractResponse:
    """AI-assisted contract generation for any supported country & type."""
    country = _resolve_country(request)
    ctype = _resolve_type(request.contract_type)
    lang = _pick_language(request, country)
    data = _normalise_data(request)
    additional_terms = data.additional_terms or request.additional_terms or ""

    markdown = _render(data, country, ctype, lang, additional_terms)

    return ContractResponse(
        contract_id=str(uuid.uuid4()),
        content_markdown=markdown,
        country_applied=country,
        contract_type=ctype,
        language=lang,
        generated_at=datetime.datetime.utcnow().isoformat(),
    )
