// Property Data Normalization Service
// Handles automated normalization of bulk property data from various formats

export interface RawPropertyData {
  [key: string]: any;
}

export interface NormalizedProperty {
  propertyName: string;
  address: string;
  city: string;
  state: string;
  zip: string;
  country: string;
  propertyType: PropertyType;
  bedrooms: number;
  bathrooms: number;
  squareFeet: number;
  furnished: FurnishingStatus;
  amenities: string[];
  monthlyRent: number;
  buildingName?: string;
  unitNumber?: string;
  floorNumber?: number;
  yearBuilt?: number;
  seattleNeighborhood?: SeattleNeighborhood;
  buildingType?: BuildingType;
  corporateRate?: number;
  longTermRate?: number;
  midTermRate?: number;
  minStayDuration?: number;
  maxStayDuration?: number;
  confidenceScore: number;
  normalizationFlags: string[];
}

export type PropertyType = 'Studio' | '1BR' | '2BR' | '3BR' | '4BR' | 'Penthouse' | 'Townhouse' | 'Duplex' | 'Loft' | 'Other';
export type FurnishingStatus = 'Furnished' | 'Unfurnished' | 'Partially Furnished';
export type SeattleNeighborhood = 'SLU' | 'Downtown' | 'Bellevue' | 'Queen Anne' | 'Capitol Hill' | 'Fremont' | 'Ballard' | 'West Seattle' | 'Other';
export type BuildingType = 'High-Rise' | 'Mid-Rise' | 'Low-Rise' | 'Townhouse' | 'Other';

export interface NormalizationResult {
  success: boolean;
  normalizedProperty?: NormalizedProperty;
  errors: string[];
  warnings: string[];
  confidenceScore: number;
}

export class PropertyNormalizer {
  private propertyTypeMappings: Map<string, PropertyType> = new Map([
    ['studio', 'Studio'],
    ['0br', 'Studio'],
    ['0 bedroom', 'Studio'],
    ['1br', '1BR'],
    ['1 bedroom', '1BR'],
    ['1 bd', '1BR'],
    ['2br', '2BR'],
    ['2 bedroom', '2BR'],
    ['2 bd', '2BR'],
    ['3br', '3BR'],
    ['3 bedroom', '3BR'],
    ['3 bd', '3BR'],
    ['4br', '4BR'],
    ['4 bedroom', '4BR'],
    ['4 bd', '4BR'],
    ['penthouse', 'Penthouse'],
    ['ph', 'Penthouse'],
    ['townhouse', 'Townhouse'],
    ['th', 'Townhouse'],
    ['duplex', 'Duplex'],
    ['loft', 'Loft'],
  ]);

  private furnishingMappings: Map<string, FurnishingStatus> = new Map([
    ['furnished', 'Furnished'],
    ['fully furnished', 'Furnished'],
    ['unfurnished', 'Unfurnished'],
    ['unfurn', 'Unfurnished'],
    ['partially furnished', 'Partially Furnished'],
    ['semi furnished', 'Partially Furnished'],
    ['partially', 'Partially Furnished'],
  ]);

  private seattleNeighborhoodKeywords: Map<string, SeattleNeighborhood> = new Map([
    ['south lake union', 'SLU'],
    ['slu', 'SLU'],
    ['lake union', 'SLU'],
    ['downtown', 'Downtown'],
    ['dt', 'Downtown'],
    ['bellevue', 'Bellevue'],
    ['queen anne', 'Queen Anne'],
    ['capitol hill', 'Capitol Hill'],
    ['fremont', 'Fremont'],
    ['ballard', 'Ballard'],
    ['west seattle', 'West Seattle'],
  ]);

  private amenityKeywords: string[] = [
    'gym', 'fitness', 'pool', 'parking', 'garage', 'doorman', 'concierge',
    'laundry', 'washer', 'dryer', 'ac', 'air conditioning', 'heating',
    'balcony', 'terrace', 'rooftop', 'garden', 'courtyard', 'bbq',
    'wifi', 'internet', 'cable', 'tv', 'smart tv', 'netflix',
    'kitchen', 'dishwasher', 'refrigerator', 'microwave', 'oven',
    'pet friendly', 'pets allowed', 'dog', 'cat',
    'elevator', 'wheelchair', 'accessible',
  ];

  normalize(rawData: RawPropertyData): NormalizationResult {
    const errors: string[] = [];
    const warnings: string[] = [];
    const flags: string[] = [];
    let confidenceScore = 1.0;

    try {
      const normalized: NormalizedProperty = {
        propertyName: this.normalizeString(rawData.propertyName || rawData.name || rawData.PropertyName || ''),
        address: this.normalizeString(rawData.address || rawData.Address || ''),
        city: this.normalizeString(rawData.city || rawData.City || ''),
        state: this.normalizeString(rawData.state || rawData.State || ''),
        zip: this.normalizeString(rawData.zip || rawData.Zip || rawData.zipCode || ''),
        country: this.normalizeString(rawData.country || rawData.Country || 'US'),
        propertyType: this.normalizePropertyType(rawData),
        bedrooms: this.normalizeNumber(rawData.bedrooms || rawData.Bedrooms || rawData.beds || rawData.Beds),
        bathrooms: this.normalizeNumber(rawData.bathrooms || rawData.Bathrooms || rawData.baths || rawData.Baths),
        squareFeet: this.normalizeNumber(rawData.squareFeet || rawData.SquareFeet || rawData.sqft || rawData.Sqft),
        furnished: this.normalizeFurnishing(rawData),
        amenities: this.normalizeAmenities(rawData),
        monthlyRent: this.normalizeNumber(rawData.monthlyRent || rawData.MonthlyRent || rawData.rent || rawData.Rent),
        buildingName: this.normalizeString(rawData.buildingName || rawData.BuildingName || rawData.building || ''),
        unitNumber: this.normalizeString(rawData.unitNumber || rawData.UnitNumber || rawData.unit || ''),
        floorNumber: this.normalizeNumber(rawData.floorNumber || rawData.FloorNumber || rawData.floor),
        yearBuilt: this.normalizeNumber(rawData.yearBuilt || rawData.YearBuilt || rawData.year),
        seattleNeighborhood: this.detectSeattleNeighborhood(rawData),
        buildingType: this.detectBuildingType(rawData),
        corporateRate: this.normalizeNumber(rawData.corporateRate || rawData.CorporateRate),
        longTermRate: this.normalizeNumber(rawData.longTermRate || rawData.LongTermRate),
        midTermRate: this.normalizeNumber(rawData.midTermRate || rawData.MidTermRate),
        minStayDuration: this.normalizeNumber(rawData.minStayDuration || rawData.MinStayDuration),
        maxStayDuration: this.normalizeNumber(rawData.maxStayDuration || rawData.MaxStayDuration),
        confidenceScore: confidenceScore,
        normalizationFlags: flags,
      };

      // Validation checks
      if (!normalized.address) {
        errors.push('Address is required');
        confidenceScore -= 0.3;
      }
      if (!normalized.city) {
        errors.push('City is required');
        confidenceScore -= 0.2;
      }
      if (normalized.bedrooms === 0 && normalized.propertyType !== 'Studio') {
        warnings.push('Bedrooms count is 0 but property type is not Studio');
        confidenceScore -= 0.1;
      }
      if (normalized.monthlyRent === 0) {
        warnings.push('Monthly rent is 0');
        confidenceScore -= 0.15;
      }

      normalized.confidenceScore = Math.max(0, confidenceScore);

      return {
        success: errors.length === 0,
        normalizedProperty: normalized,
        errors,
        warnings,
        confidenceScore: normalized.confidenceScore,
      };
    } catch (error) {
      return {
        success: false,
        errors: [`Normalization failed: ${error instanceof Error ? error.message : 'Unknown error'}`],
        warnings,
        confidenceScore: 0,
      };
    }
  }

  private normalizeString(value: any): string {
    if (typeof value === 'string') {
      return value.trim();
    }
    if (typeof value === 'number') {
      return value.toString();
    }
    return '';
  }

  private normalizeNumber(value: any): number {
    if (typeof value === 'number') {
      return value;
    }
    if (typeof value === 'string') {
      const parsed = parseFloat(value.replace(/[^0-9.-]/g, ''));
      return isNaN(parsed) ? 0 : parsed;
    }
    return 0;
  }

  private normalizePropertyType(rawData: RawPropertyData): PropertyType {
    const typeField = rawData.propertyType || rawData.PropertyType || rawData.type || rawData.Type || '';
    const bedsField = rawData.bedrooms || rawData.Bedrooms || rawData.beds || rawData.Beds;
    
    // Try direct mapping first
    const normalized = this.propertyTypeMappings.get(typeField.toString().toLowerCase().trim());
    if (normalized) return normalized;

    // Try to infer from bedrooms
    const beds = this.normalizeNumber(bedsField);
    if (beds === 0) return 'Studio';
    if (beds === 1) return '1BR';
    if (beds === 2) return '2BR';
    if (beds === 3) return '3BR';
    if (beds >= 4) return '4BR';

    return 'Other';
  }

  private normalizeFurnishing(rawData: RawPropertyData): FurnishingStatus {
    const furnishedField = rawData.furnished || rawData.Furnished || rawData.furnishing || rawData.Furnishing || '';
    const normalized = this.furnishingMappings.get(furnishedField.toString().toLowerCase().trim());
    return normalized || 'Unfurnished';
  }

  private normalizeAmenities(rawData: RawPropertyData): string[] {
    const amenitiesField = rawData.amenities || rawData.Amenities || rawData.features || rawData.Features || '';
    const amenitiesString = amenitiesField.toString();
    
    const foundAmenities: string[] = [];
    
    for (const keyword of this.amenityKeywords) {
      if (amenitiesString.toLowerCase().includes(keyword)) {
        // Capitalize first letter
        const formatted = keyword.charAt(0).toUpperCase() + keyword.slice(1);
        if (!foundAmenities.includes(formatted)) {
          foundAmenities.push(formatted);
        }
      }
    }

    return foundAmenities;
  }

  private detectSeattleNeighborhood(rawData: RawPropertyData): SeattleNeighborhood | undefined {
    const address = (rawData.address || rawData.Address || '').toString().toLowerCase();
    const city = (rawData.city || rawData.City || '').toString().toLowerCase();
    const zip = (rawData.zip || rawData.Zip || '').toString();

    // Check zip codes for Seattle neighborhoods
    if (zip.startsWith('981')) {
      if (zip.startsWith('98101') || zip.startsWith('98121')) return 'Downtown';
      if (zip.startsWith('98109')) return 'SLU';
      if (zip.startsWith('98102')) return 'Queen Anne';
      if (zip.startsWith('98112')) return 'Capitol Hill';
      if (zip.startsWith('98103')) return 'Fremont';
      if (zip.startsWith('98107')) return 'Ballard';
      if (zip.startsWith('98106')) return 'West Seattle';
    }

    // Bellevue zip codes
    if (zip.startsWith('980')) {
      if (zip.startsWith('98004') || zip.startsWith('98005') || zip.startsWith('98007') || zip.startsWith('98008')) {
        return 'Bellevue';
      }
    }

    // Check address and city for keywords
    const combinedText = `${address} ${city}`;
    for (const [keyword, neighborhood] of this.seattleNeighborhoodKeywords) {
      if (combinedText.includes(keyword)) {
        return neighborhood;
      }
    }

    return undefined;
  }

  private detectBuildingType(rawData: RawPropertyData): BuildingType | undefined {
    const buildingName = (rawData.buildingName || rawData.BuildingName || '').toString().toLowerCase();
    const floors = this.normalizeNumber(rawData.floors || rawData.Floors || rawData.totalFloors);

    if (buildingName.includes('tower') || buildingName.includes('high-rise') || floors > 10) {
      return 'High-Rise';
    }
    if (buildingName.includes('mid-rise') || (floors > 4 && floors <= 10)) {
      return 'Mid-Rise';
    }
    if (buildingName.includes('townhouse') || buildingName.includes('row house')) {
      return 'Townhouse';
    }
    if (floors <= 4) {
      return 'Low-Rise';
    }

    return undefined;
  }

  normalizeBatch(rawDataArray: RawPropertyData[]): NormalizationResult[] {
    return rawDataArray.map(data => this.normalize(data));
  }

  generateCSVTemplate(): string {
    const headers = [
      'PropertyName',
      'Address',
      'City',
      'State',
      'Zip',
      'Country',
      'PropertyType',
      'Bedrooms',
      'Bathrooms',
      'SquareFeet',
      'Furnished',
      'MonthlyRent',
      'BuildingName',
      'UnitNumber',
      'FloorNumber',
      'YearBuilt',
      'Amenities',
      'CorporateRate',
      'LongTermRate',
      'MidTermRate',
      'MinStayDuration',
      'MaxStayDuration',
    ];

    const exampleRow = [
      'Example Property',
      '123 Main St, Apt 4B',
      'Seattle',
      'WA',
      '98101',
      'US',
      '2BR',
      '2',
      '2',
      '1200',
      'Furnished',
      '2500',
      'Met Tower',
      '4B',
      '4',
      '2020',
      'Gym, Pool, Doorman, Parking',
      '3500',
      '2500',
      '3000',
      '30',
      '180',
    ];

    return [headers.join(','), exampleRow.join(',')].join('\n');
  }

  validateCSVStructure(headers: string[]): { valid: boolean; errors: string[] } {
    const requiredHeaders = ['PropertyName', 'Address', 'City', 'State', 'Zip'];
    const errors: string[] = [];

    for (const required of requiredHeaders) {
      if (!headers.includes(required)) {
        errors.push(`Missing required column: ${required}`);
      }
    }

    return {
      valid: errors.length === 0,
      errors,
    };
  }
}

// Singleton instance
export const propertyNormalizer = new PropertyNormalizer();
