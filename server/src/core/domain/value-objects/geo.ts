export class Geo {
  constructor(
    public readonly lat: number,
    public readonly lng: number
  ) {
    if (lat < -90 || lat > 90) {
      throw new Error("Latitude must be between -90 and 90");
    }
    if (lng < -180 || lng > 180) {
      throw new Error("Longitude must be between -180 and 180");
    }
  }

  /**
   * Calculates distance between this geo point and another using the Haversine formula
   * @returns distance in kilometers
   */
  distanceTo(other: Geo): number {
    const R = 6371; // Earth's radius in km
    const dLat = this.deg2rad(other.lat - this.lat);
    const dLng = this.deg2rad(other.lng - this.lng);
    const a =
      Math.sin(dLat / 2) * Math.sin(dLat / 2) +
      Math.cos(this.deg2rad(this.lat)) * Math.cos(this.deg2rad(other.lat)) *
      Math.sin(dLng / 2) * Math.sin(dLng / 2);
    const c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
    return R * c;
  }

  private deg2rad(deg: number): number {
    return deg * (Math.PI / 180);
  }

  equals(other: Geo): boolean {
    return this.lat === other.lat && this.lng === other.lng;
  }

  toJSON() {
    return {
      lat: this.lat,
      lng: this.lng
    };
  }
}
