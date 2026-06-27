"use strict";
var __awaiter = (this && this.__awaiter) || function (thisArg, _arguments, P, generator) {
    function adopt(value) { return value instanceof P ? value : new P(function (resolve) { resolve(value); }); }
    return new (P || (P = Promise))(function (resolve, reject) {
        function fulfilled(value) { try { step(generator.next(value)); } catch (e) { reject(e); } }
        function rejected(value) { try { step(generator["throw"](value)); } catch (e) { reject(e); } }
        function step(result) { result.done ? resolve(result.value) : adopt(result.value).then(fulfilled, rejected); }
        step((generator = generator.apply(thisArg, _arguments || [])).next());
    });
};
var __generator = (this && this.__generator) || function (thisArg, body) {
    var _ = { label: 0, sent: function() { if (t[0] & 1) throw t[1]; return t[1]; }, trys: [], ops: [] }, f, y, t, g = Object.create((typeof Iterator === "function" ? Iterator : Object).prototype);
    return g.next = verb(0), g["throw"] = verb(1), g["return"] = verb(2), typeof Symbol === "function" && (g[Symbol.iterator] = function() { return this; }), g;
    function verb(n) { return function (v) { return step([n, v]); }; }
    function step(op) {
        if (f) throw new TypeError("Generator is already executing.");
        while (g && (g = 0, op[0] && (_ = 0)), _) try {
            if (f = 1, y && (t = op[0] & 2 ? y["return"] : op[0] ? y["throw"] || ((t = y["return"]) && t.call(y), 0) : y.next) && !(t = t.call(y, op[1])).done) return t;
            if (y = 0, t) op = [op[0] & 2, t.value];
            switch (op[0]) {
                case 0: case 1: t = op; break;
                case 4: _.label++; return { value: op[1], done: false };
                case 5: _.label++; y = op[1]; op = [0]; continue;
                case 7: op = _.ops.pop(); _.trys.pop(); continue;
                default:
                    if (!(t = _.trys, t = t.length > 0 && t[t.length - 1]) && (op[0] === 6 || op[0] === 2)) { _ = 0; continue; }
                    if (op[0] === 3 && (!t || (op[1] > t[0] && op[1] < t[3]))) { _.label = op[1]; break; }
                    if (op[0] === 6 && _.label < t[1]) { _.label = t[1]; t = op; break; }
                    if (t && _.label < t[2]) { _.label = t[2]; _.ops.push(op); break; }
                    if (t[2]) _.ops.pop();
                    _.trys.pop(); continue;
            }
            op = body.call(thisArg, _);
        } catch (e) { op = [6, e]; y = 0; } finally { f = t = 0; }
        if (op[0] & 5) throw op[1]; return { value: op[0] ? op[1] : void 0, done: true };
    }
};
Object.defineProperty(exports, "__esModule", { value: true });
var client_1 = require("@prisma/client");
var prisma = new client_1.PrismaClient();
function id(slug) {
    return "tr_residence_".concat(slug);
}
var TURKEY_RESIDENCES = [
    {
        parcel: "34-IST-001", address: "Levazım, Koru Sokağı No:2, Beşiktaş", city: "Istanbul", zip: "34340", lat: 41.0664, lng: 29.0163,
        name: "Zorlu Center - Luxury Residence", use: "MIXED_USE", yearBuilt: 2013, sqft: 2500, lot: 0,
        beds: 3, baths: 3.5, stories: 1, condition: "EXCELLENT", landVal: 15000000, imprVal: 35000000, totalVal: 50000000,
        district: "Besiktas",
    },
    {
        parcel: "34-IST-002", address: "Huzur Mah. Azerbaycan Cad. Sarıyer", city: "Istanbul", zip: "34396", lat: 41.1070, lng: 28.9897,
        name: "Skyland Istanbul - Sky Residence", use: "MIXED_USE", yearBuilt: 2018, sqft: 1800, lot: 0,
        beds: 2, baths: 2, stories: 1, condition: "EXCELLENT", landVal: 8000000, imprVal: 22000000, totalVal: 30000000,
        district: "Sariyer",
    },
    {
        parcel: "34-IST-003", address: "Cumhuriyet Mah. İncirlidede Cad. Şişli", city: "Istanbul", zip: "34380", lat: 41.0569, lng: 28.9796,
        name: "Anthill Residence - Premium Unit", use: "MIXED_USE", yearBuilt: 2010, sqft: 1200, lot: 0,
        beds: 1, baths: 1.5, stories: 1, condition: "GOOD", landVal: 5000000, imprVal: 12000000, totalVal: 17000000,
        district: "Sisli",
    },
    {
        parcel: "34-IST-004", address: "Kuruçeşme, Muallim Naci Cad. Beşiktaş", city: "Istanbul", zip: "34345", lat: 41.0375, lng: 29.0322,
        name: "Bosphorus View Yalı Dairesi", use: "APARTMENT", yearBuilt: 1995, sqft: 4500, lot: 5500,
        beds: 5, baths: 4, stories: 2, condition: "EXCELLENT", landVal: 80000000, imprVal: 45000000, totalVal: 125000000,
        district: "Besiktas",
    },
    {
        parcel: "35-IZM-001", address: "Adalet Mah. Manas Bulvarı No:47 Bayraklı", city: "Izmir", zip: "35530", lat: 38.4524, lng: 27.1751,
        name: "Folkart Towers - Sea View", use: "MIXED_USE", yearBuilt: 2014, sqft: 2200, lot: 0,
        beds: 3, baths: 2.5, stories: 1, condition: "EXCELLENT", landVal: 4000000, imprVal: 11000000, totalVal: 15000000,
        district: "Bayrakli",
    },
    {
        parcel: "35-IZM-002", address: "Mavişehir Mah. Caher Dudayev Blv.", city: "Izmir", zip: "35590", lat: 38.4682, lng: 27.0851,
        name: "Mavişehir Park Yaşam Residence", use: "APARTMENT", yearBuilt: 2015, sqft: 1650, lot: 0,
        beds: 3, baths: 2, stories: 1, condition: "GOOD", landVal: 3500000, imprVal: 7500000, totalVal: 11000000,
        district: "Karsiyaka",
    },
    {
        parcel: "48-BOD-001", address: "Yalıkavak, Çökertme Cd. No:1 Bodrum", city: "Mugla", zip: "48990", lat: 37.1042, lng: 27.2872,
        name: "Yalıkavak Marina - Private Villa", use: "SINGLE_FAMILY_RESIDENCE", yearBuilt: 2019, sqft: 6500, lot: 15000,
        beds: 6, baths: 6.5, stories: 2, condition: "EXCELLENT", landVal: 60000000, imprVal: 90000000, totalVal: 150000000,
        district: "Bodrum",
    },
    {
        parcel: "06-ANK-001", address: "Turan Güneş Blv. İlkbahar Mah. Çankaya", city: "Ankara", zip: "06550", lat: 39.8519, lng: 32.8550,
        name: "Sinpaş Altınoran - Premium Tower", use: "APARTMENT", yearBuilt: 2016, sqft: 1950, lot: 0,
        beds: 4, baths: 2, stories: 1, condition: "GOOD", landVal: 2000000, imprVal: 6500000, totalVal: 8500000,
        district: "Cankaya",
    },
    {
        parcel: "34-IST-005", address: "Ataköy 1. Kısım Mah. Rauf Orbay Cad.", city: "Istanbul", zip: "34158", lat: 40.9755, lng: 28.8576,
        name: "SeaPearl Ataköy Residence", use: "MIXED_USE", yearBuilt: 2021, sqft: 3100, lot: 0,
        beds: 4, baths: 3, stories: 1, condition: "EXCELLENT", landVal: 12000000, imprVal: 38000000, totalVal: 50000000,
        district: "Bakirkoy",
    },
    {
        parcel: "07-ANT-001", address: "Şirinyalı Mah. Lara Cad. Muratpaşa", city: "Antalya", zip: "07160", lat: 36.8617, lng: 30.7451,
        name: "Lara Yalı Residence - Sea Front", use: "APARTMENT", yearBuilt: 2012, sqft: 2800, lot: 0,
        beds: 4, baths: 3, stories: 1, condition: "GOOD", landVal: 6000000, imprVal: 14000000, totalVal: 20000000,
        district: "Muratpasa",
    }
];
function main() {
    return __awaiter(this, void 0, void 0, function () {
        var org, _i, TURKEY_RESIDENCES_1, p, propId, property;
        return __generator(this, function (_a) {
            switch (_a.label) {
                case 0:
                    console.log("🏙️ Türkiye lüks rezidans projeleri ekleniyor...\n");
                    return [4 /*yield*/, prisma.organization.upsert({
                            where: { id: id("org") },
                            update: {},
                            create: {
                                id: id("org"),
                                name: "Reservatior Turkey - Premium Residences",
                                type: "AGENCY",
                                region: "TR",
                                defaultCurrency: "TRY",
                                defaultLocale: "tr-TR",
                                taxReportingEnabled: true,
                                complianceTracking: true,
                                contactEmail: "tr@reservatior.com",
                                address: "Büyükdere Cad. No:199, Levent, Istanbul 34394",
                            },
                        })];
                case 1:
                    org = _a.sent();
                    console.log("\u2705 Organizasyon olu\u015Fturuldu: ".concat(org.name, " (").concat(org.id, ")\n"));
                    _i = 0, TURKEY_RESIDENCES_1 = TURKEY_RESIDENCES;
                    _a.label = 2;
                case 2:
                    if (!(_i < TURKEY_RESIDENCES_1.length)) return [3 /*break*/, 6];
                    p = TURKEY_RESIDENCES_1[_i];
                    propId = id("prop_".concat(p.parcel));
                    return [4 /*yield*/, prisma.property.upsert({
                            where: { id: propId },
                            update: {},
                            create: {
                                id: propId,
                                orgId: org.id,
                                name: p.name,
                                type: p.use === "SINGLE_FAMILY_RESIDENCE" ? "DETACHED_HOUSE" : "APARTMENT",
                                region: "TR",
                                currency: "TRY",
                                addressLine1: p.address,
                                city: p.city,
                                state: p.city, // For TR, state is often the province/city
                                zip: p.zip,
                                country: "TR",
                                lat: p.lat,
                                lng: p.lng,
                                stateCode: p.district, // using district for stateCode in TR
                                propertyCategory: p.use.includes("MIXED") ? "MIXED_USE" : "RESIDENTIAL",
                                listingType: "SALE",
                                listingStatus: "AVAILABLE",
                                yearBuilt: p.yearBuilt,
                                livingAreaSqFt: p.sqft * 10.7639, // approx sqm to sqft or just use directly if schema expects sqft
                                lotSizeSqFt: p.lot,
                                bedrooms: p.beds,
                                bathrooms: p.baths,
                                stories: Math.floor(p.stories),
                                assessedValue: p.totalVal,
                                marketValue: p.totalVal * 1.10,
                                schoolDistrict: p.district,
                            },
                        })];
                case 3:
                    property = _a.sent();
                    // Listing create for TR residences
                    return [4 /*yield*/, prisma.listing.upsert({
                            where: { id: id("listing_".concat(p.parcel)) },
                            update: {},
                            create: {
                                id: id("listing_".concat(p.parcel)),
                                orgId: org.id,
                                propertyId: property.id,
                                type: "SALE",
                                status: "AVAILABLE",
                                strategy: "LONG_TERM_STABLE",
                                title: p.name,
                                description: "".concat(p.name, " - ").concat(p.city, " ").concat(p.district, " konumunda harika l\u00FCks rezidans."),
                                price: p.totalVal * 1.10,
                                priceCurrency: "TRY",
                            }
                        }).catch(function (e) { return console.log("Listing skip: ".concat(e.message)); })];
                case 4:
                    // Listing create for TR residences
                    _a.sent();
                    console.log("  \uD83D\uDCCB ".concat(p.parcel, " | ").concat(p.address.padEnd(45), " | \u20BA").concat(p.totalVal.toLocaleString().padStart(15)));
                    _a.label = 5;
                case 5:
                    _i++;
                    return [3 /*break*/, 2];
                case 6:
                    console.log("\n\u2705 ".concat(TURKEY_RESIDENCES.length, " T\u00FCrkiye rezidans projesi veritaban\u0131na eklendi."));
                    return [2 /*return*/];
            }
        });
    });
}
main()
    .catch(function (e) { console.error(e); process.exit(1); })
    .finally(function () { return prisma.$disconnect(); });
