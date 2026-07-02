import { useQuery, useMutation } from "@tanstack/react-query";
import { hotelAlternativesApi, HotelAlternativeSearchInput } from "@/lib/api/hotel-alternatives";
import { useAppState } from "./use-app-state";
import { useToast } from "./use-toast";

export const hotelKeys = {
  all: ["hotel-alternatives"] as const,
  alternatives: (input: HotelAlternativeSearchInput) =>
    [...hotelKeys.all, "alternatives", input] as const,
  hasCheaper: (input: Partial<HotelAlternativeSearchInput>) =>
    [...hotelKeys.all, "has-cheaper", input] as const,
};

export const useHotelAlternatives = (input: HotelAlternativeSearchInput | null) => {
  const { setError } = useAppState();
  const { toast } = useToast();

  return useQuery({
    queryKey: hotelKeys.alternatives(input || ({} as any)),
    queryFn: () => hotelAlternativesApi.getAlternatives(input!),
    enabled: !!input && !!input.destination && !!input.checkIn && !!input.checkOut,
    staleTime: 60_000,
    retry: 1,
  });
};

export const useHasCheaperHotels = (input: Partial<HotelAlternativeSearchInput> | null) => {
  return useQuery({
    queryKey: hotelKeys.hasCheaper(input || ({} as any)),
    queryFn: () => hotelAlternativesApi.hasCheaper(input!),
    enabled: !!input && !!input.destination,
    staleTime: 60_000,
  });
};

export const useSearchHotels = (params: {
  destination?: string;
  checkIn?: string;
  checkOut?: string;
  guests?: string;
}) => {
  return useQuery({
    queryKey: ["hotel-search", params],
    queryFn: () =>
      hotelAlternativesApi.searchHotels({
        destination: params.destination!,
        checkIn: params.checkIn!,
        checkOut: params.checkOut!,
        guests: params.guests || "2",
      }),
    enabled: !!params.destination && !!params.checkIn && !!params.checkOut,
    staleTime: 120_000,
  });
};
