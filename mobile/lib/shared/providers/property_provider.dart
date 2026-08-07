import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/property_service.dart';
import 'package:reservatior/shared/repositories/property_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/enums/listing_status.dart';
import 'package:reservatior/shared/enums/property_category.dart';
import 'package:reservatior/shared/enums/listing_type.dart';
import 'dio_client_provider.dart';

// Service and Repository Providers
final propertyServiceProvider = Provider<PropertyService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyService(dioClient);
});

final propertyRepositoryProvider = Provider<PropertyRepository>((ref) {
  final service = ref.watch(propertyServiceProvider);
  return PropertyRepositoryImpl(service);
});

// Advanced Filtered Provider
final filteredPropertyProvider = FutureProvider.family.autoDispose<List<Property>, Map<String, dynamic>>((ref, filters) async {
  final repository = ref.watch(propertyRepositoryProvider);
  return repository.getAll(filters: filters);
});

// Basic Property Providers
final propertyListProvider = FutureProvider.autoDispose<List<Property>>((ref) async {
  final repository = ref.watch(propertyRepositoryProvider);
  return repository.getAll();
});

final propertyDetailsProvider = FutureProvider.family.autoDispose<Property, String>((ref, propertyId) async {
  final repository = ref.watch(propertyRepositoryProvider);
  return repository.getById(propertyId);
});

final propertyAffiliateOffersProvider = FutureProvider.family.autoDispose<List<dynamic>, String>((ref, propertyId) async {
  final dioClient = ref.watch(dioClientProvider);
  final response = await dioClient.dio.get('/property/$propertyId/affiliate-offers');
  return response.data['data'] as List<dynamic>;
});

// Search and Filter Providers
final propertySearchProvider = StateNotifierProvider<PropertySearchNotifier, List<Property>>((ref) {
  return PropertySearchNotifier(ref.watch(propertyRepositoryProvider));
});

final propertyFilterProvider = StateNotifierProvider<PropertyFilterNotifier, PropertyFilterState>((ref) {
  return PropertyFilterNotifier(ref.watch(propertyRepositoryProvider));
});

final filteredPropertiesProvider = Provider<List<Property>>((ref) {
  final allProperties = ref.watch(propertyListProvider);
  final searchResults = ref.watch(propertySearchProvider);
  final filterState = ref.watch(propertyFilterProvider);
  
  return allProperties.when(
    data: (properties) {
      List<Property> result = searchResults.isNotEmpty ? searchResults : properties;
      final filtered = _applyFilters(result, filterState);
      
      if (filterState.sortBy != null) {
        if (filterState.sortBy == 'PRICE_ASC') {
          filtered.sort((a, b) => (a.listingPrice ?? 0).compareTo(b.listingPrice ?? 0));
        } else if (filterState.sortBy == 'PRICE_DESC') {
          filtered.sort((a, b) => (b.listingPrice ?? 0).compareTo(a.listingPrice ?? 0));
        } else if (filterState.sortBy == 'NEWEST') {
          filtered.sort((a, b) => (b.createdAt ?? DateTime.now()).compareTo(a.createdAt ?? DateTime.now()));
        } else if (filterState.sortBy == 'AREA_DESC') {
          filtered.sort((a, b) => (b.areaSqm ?? 0).compareTo(a.areaSqm ?? 0));
        }
      }
      
      return filtered;
    },
    loading: () => [],
    error: (error, stack) => [],
  );
});

// Map View Provider
final propertyMapProvider = StateNotifierProvider<PropertyMapNotifier, PropertyMapState>((ref) {
  return PropertyMapNotifier();
});

// Favorites Provider
final propertyFavoritesProvider = StateNotifierProvider<PropertyFavoritesNotifier, Set<String>>((ref) {
  return PropertyFavoritesNotifier();
});

// Notifiers
class PropertySearchNotifier extends StateNotifier<List<Property>> {
  final PropertyRepository _repository;
  
  PropertySearchNotifier(this._repository) : super([]);

  Future<void> search(String query) async {
    if (query.isEmpty) {
      state = [];
      return;
    }
    
    state = [];
    
    try {
      final allProperties = await _repository.getAll();
      final filtered = allProperties.where((property) {
        final searchLower = query.toLowerCase();
        return property.name.toLowerCase().contains(searchLower) ||
               property.addressLine1.toLowerCase().contains(searchLower) ||
               property.city.toLowerCase().contains(searchLower) ||
               (property.mlsNumber?.toLowerCase().contains(searchLower) ?? false);
      }).toList();
      
      state = filtered;
    } catch (e) {
      state = [];
    }
  }

  void clear() => state = [];
}

class PropertyFilterNotifier extends StateNotifier<PropertyFilterState> {
  final PropertyRepository _repository;
  
  PropertyFilterNotifier(this._repository) : super(const PropertyFilterState());

  void updateCategory(PropertyCategory? category) {
    state = state.copyWith(category: category);
  }

  void updateListingType(ListingType? listingType) {
    state = state.copyWith(listingType: listingType);
  }

  void updatePriceRange(double? minPrice, double? maxPrice) {
    state = state.copyWith(minPrice: minPrice, maxPrice: maxPrice);
  }

  void updateBedrooms(String? bedrooms) {
    state = state.copyWith(bedrooms: bedrooms);
  }

  void updateBathrooms(String? bathrooms) {
    state = state.copyWith(bathrooms: bathrooms);
  }

  void updatePropertyType(String? propertyType) {
    state = state.copyWith(propertyType: propertyType);
  }

  void updateListingStatus(ListingStatus? listingStatus) {
    state = state.copyWith(listingStatus: listingStatus);
  }

  void updatePromotion(String? promotion) {
    state = state.copyWith(promotion: promotion);
  }

  void updateSortBy(String? sortBy) {
    state = state.copyWith(sortBy: sortBy);
  }

  void toggleAmenity(String amenity) {
    final currentAmenities = List<String>.from(state.amenities ?? []);
    if (currentAmenities.contains(amenity)) {
      currentAmenities.remove(amenity);
    } else {
      currentAmenities.add(amenity);
    }
    state = state.copyWith(amenities: currentAmenities);
  }

  void toggleCompliance(String compliance) {
    final currentCompliance = List<String>.from(state.compliance ?? []);
    if (currentCompliance.contains(compliance)) {
      currentCompliance.remove(compliance);
    } else {
      currentCompliance.add(compliance);
    }
    state = state.copyWith(compliance: currentCompliance);
  }

  void setMinRoi(String? minRoi) {
    state = state.copyWith(minRoi: minRoi);
  }

  void resetFilters() {
    state = const PropertyFilterState();
  }
}

class PropertyMapNotifier extends StateNotifier<PropertyMapState> {
  PropertyMapNotifier() : super(const PropertyMapState());

  void centerOnAllProperties() {
    state = state.copyWith(centeredOnAll: true);
  }

  void centerOnProperty(String propertyId) {
    state = state.copyWith(centeredPropertyId: propertyId);
  }

  void setZoomLevel(double zoom) {
    state = state.copyWith(zoom: zoom);
  }
}

class PropertyFavoritesNotifier extends StateNotifier<Set<String>> {
  PropertyFavoritesNotifier() : super(const {});

  void toggleFavorite(String propertyId) {
    final favorites = Set<String>.from(state);
    if (favorites.contains(propertyId)) {
      favorites.remove(propertyId);
    } else {
      favorites.add(propertyId);
    }
    state = favorites;
  }

  bool isFavorite(String propertyId) => state.contains(propertyId);
}

// State Classes
class PropertyFilterState {
  final PropertyCategory? category;
  final ListingType? listingType;
  final double? minPrice;
  final double? maxPrice;
  final String? bedrooms;
  final String? bathrooms;
  final String? propertyType;
  final ListingStatus? listingStatus;
  final String? promotion;
  final String? sortBy;
  final List<String>? amenities;
  final List<String>? compliance;
  final String? minRoi;

  const PropertyFilterState({
    this.category,
    this.listingType,
    this.minPrice,
    this.maxPrice,
    this.bedrooms,
    this.bathrooms,
    this.propertyType,
    this.listingStatus,
    this.promotion,
    this.sortBy,
    this.amenities,
    this.compliance,
    this.minRoi,
  });

  PropertyFilterState copyWith({
    PropertyCategory? category,
    ListingType? listingType,
    double? minPrice,
    double? maxPrice,
    String? bedrooms,
    String? bathrooms,
    String? propertyType,
    ListingStatus? listingStatus,
    String? promotion,
    String? sortBy,
    List<String>? amenities,
    List<String>? compliance,
    String? minRoi,
  }) {
    return PropertyFilterState(
      category: category ?? this.category,
      listingType: listingType ?? this.listingType,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      bedrooms: bedrooms ?? this.bedrooms,
      bathrooms: bathrooms ?? this.bathrooms,
      propertyType: propertyType ?? this.propertyType,
      listingStatus: listingStatus ?? this.listingStatus,
      promotion: promotion ?? this.promotion,
      sortBy: sortBy ?? this.sortBy,
      amenities: amenities ?? this.amenities,
      compliance: compliance ?? this.compliance,
      minRoi: minRoi ?? this.minRoi,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is PropertyFilterState &&
        other.category == category &&
        other.listingType == listingType &&
        other.minPrice == minPrice &&
        other.maxPrice == maxPrice &&
        other.bedrooms == bedrooms &&
        other.bathrooms == bathrooms &&
        other.propertyType == propertyType &&
        other.listingStatus == listingStatus &&
        other.promotion == promotion &&
        other.sortBy == sortBy &&
        _listEquals(other.amenities, amenities) &&
        _listEquals(other.compliance, compliance) &&
        other.minRoi == minRoi;
  }

  bool _listEquals(List<String>? a, List<String>? b) {
    if (a == null) return b == null;
    if (b == null || a.length != b.length) return false;
    for (int i = 0; i < a.length; i++) {
      if (a[i] != b[i]) return false;
    }
    return true;
  }

  @override
  int get hashCode {
    return category.hashCode ^
        listingType.hashCode ^
        minPrice.hashCode ^
        maxPrice.hashCode ^
        bedrooms.hashCode ^
        bathrooms.hashCode ^
        propertyType.hashCode ^
        listingStatus.hashCode ^
        promotion.hashCode ^
        sortBy.hashCode ^
        amenities.hashCode ^
        compliance.hashCode ^
        minRoi.hashCode;
  }
}

class PropertyMapState {
  final bool centeredOnAll;
  final String? centeredPropertyId;
  final double zoom;

  const PropertyMapState({
    this.centeredOnAll = false,
    this.centeredPropertyId,
    this.zoom = 13.0,
  });

  PropertyMapState copyWith({
    bool? centeredOnAll,
    String? centeredPropertyId,
    double? zoom,
  }) {
    return PropertyMapState(
      centeredOnAll: centeredOnAll ?? this.centeredOnAll,
      centeredPropertyId: centeredPropertyId ?? this.centeredPropertyId,
      zoom: zoom ?? this.zoom,
    );
  }
}

// Helper Functions
List<Property> _applyFilters(List<Property> properties, PropertyFilterState filter) {
  return properties.where((property) {
    // Category Filter
    if (filter.category != null && property.propertyCategory != filter.category) {
      return false;
    }
    
    // Listing Type Filter
    if (filter.listingType != null && property.listingType != filter.listingType) {
      return false;
    }
    
    // Price Filter
    if (filter.minPrice != null && (property.listingPrice == null || property.listingPrice! < filter.minPrice!)) {
      return false;
    }
    
    if (filter.maxPrice != null && (property.listingPrice == null || property.listingPrice! > filter.maxPrice!)) {
      return false;
    }
    
    // Bedrooms Filter
    if (filter.bedrooms != null && filter.bedrooms != 'Any' && filter.bedrooms != 'ALL') {
      final requiredBedrooms = int.tryParse(filter.bedrooms!.replaceAll('+', '')) ?? 0;
      if (property.bedrooms == null || property.bedrooms! < requiredBedrooms) {
        return false;
      }
    }
    
    // Bathrooms Filter
    if (filter.bathrooms != null && filter.bathrooms != 'Any' && filter.bathrooms != 'ALL') {
      final requiredBathrooms = int.tryParse(filter.bathrooms!.replaceAll('+', '')) ?? 0;
      if (property.bathrooms == null || property.bathrooms! < requiredBathrooms) {
        return false;
      }
    }

    // Property Type
    if (filter.propertyType != null && filter.propertyType != 'ALL') {
      if (property.type.name != filter.propertyType) {
        return false;
      }
    }

    // Listing Status
    if (filter.listingStatus != null) {
      if (property.listingStatus != filter.listingStatus) {
        return false;
      }
    }

    // Promotion
    if (filter.promotion != null && filter.promotion != 'ALL') {
      if (property.propertyPromotions.isEmpty) {
        return false;
      }
    }

    // Amenities
    if (filter.amenities != null && filter.amenities!.isNotEmpty) {
      final propertyFeatures = property.amenities.map((e) => e.amenity?.name ?? '').toList();
      for (final amenity in filter.amenities!) {
        if (!propertyFeatures.contains(amenity)) {
          return false;
        }
      }
    }

    // Compliance
    if (filter.compliance != null && filter.compliance!.isNotEmpty) {
      for (final compliance in filter.compliance!) {
        final matched = property.compliance.any((c) {
          final typeMatches = c.type.toLowerCase().contains(compliance.toLowerCase());
          final isFailing = c.status.toUpperCase() == 'FAILED' ||
              c.status.toUpperCase() == 'NON_COMPLIANT' ||
              c.status.toUpperCase() == 'ERROR';
          return typeMatches && !isFailing;
        });
        if (!matched) {
          return false;
        }
      }
    }
    
    return true;
  }).toList();
}
