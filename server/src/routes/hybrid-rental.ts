import Elysia, { t } from "elysia";
import { hybridRentalEngine, PropertyInputData } from "../services/intelligence/hybrid-rental-engine";

export const hybridRentalRoutes = new Elysia({ prefix: "/api/intelligence/hybrid-rental" })
  .post(
    "/evaluate",
    async ({ body, set }) => {
      try {
        const inputData: PropertyInputData = {
          neighbourhood: body.neighbourhood || "Beyoğlu",
          roomType: (body.roomType as any) || "Entire home/apt",
          accommodates: Number(body.accommodates || 2),
          bedrooms: Number(body.bedrooms || 1),
          bathrooms: Number(body.bathrooms || 1),
          sizeSqm: Number(body.sizeSqm || 75),
          buildingAge: Number(body.buildingAge || 5),
          isFurnished: Boolean(body.isFurnished),
          hasElevator: Boolean(body.hasElevator),
          hasParking: Boolean(body.hasParking),
          hasPoolOrGym: Boolean(body.hasPoolOrGym),
          proximityToMetroMins: Number(body.proximityToMetroMins || 10),
          proximityToAirportMins: Number(body.proximityToAirportMins || 35),
          hasBuildingConsent100Pct: Boolean(body.hasBuildingConsent100Pct),
          hasTourismResidenceLicense: Boolean(body.hasTourismResidenceLicense),
          hasKabisRegistration: Boolean(body.hasKabisRegistration),
          customLongTermRentMonthlyTRY: body.customLongTermRentMonthlyTRY ? Number(body.customLongTermRentMonthlyTRY) : undefined,
          primaryPartnerRole: (body.primaryPartnerRole as any) || undefined,
          primaryPartnerId: body.primaryPartnerId || undefined,
        };

        const evaluation = hybridRentalEngine.evaluateProperty(inputData);
        return { success: true, data: evaluation };
      } catch (error: any) {
        set.status = 500;
        return { success: false, error: error.message };
      }
    },
    {
      body: t.Object({
        neighbourhood: t.String(),
        roomType: t.Optional(t.String()),
        accommodates: t.Optional(t.Number()),
        bedrooms: t.Optional(t.Number()),
        bathrooms: t.Optional(t.Number()),
        sizeSqm: t.Optional(t.Number()),
        buildingAge: t.Optional(t.Number()),
        isFurnished: t.Optional(t.Boolean()),
        hasElevator: t.Optional(t.Boolean()),
        hasParking: t.Optional(t.Boolean()),
        hasPoolOrGym: t.Optional(t.Boolean()),
        proximityToMetroMins: t.Optional(t.Number()),
        proximityToAirportMins: t.Optional(t.Number()),
        hasBuildingConsent100Pct: t.Optional(t.Boolean()),
        hasTourismResidenceLicense: t.Optional(t.Boolean()),
        hasKabisRegistration: t.Optional(t.Boolean()),
        customLongTermRentMonthlyTRY: t.Optional(t.Number()),
        primaryPartnerRole: t.Optional(t.String()),
        primaryPartnerId: t.Optional(t.String())
      })
    }
  );
