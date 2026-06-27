import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/enums/property_type.dart';

class PropertyFilters {
  final String? query;
  final List<PropertyType> types;
  final double? minPrice;
  final double? maxPrice;
  final int? minBedrooms;
  final String? location;

  PropertyFilters({
    this.query,
    this.types = const [],
    this.minPrice,
    this.maxPrice,
    this.minBedrooms,
    this.location,
  });

  PropertyFilters copyWith({
    String? query,
    List<PropertyType>? types,
    double? minPrice,
    double? maxPrice,
    int? minBedrooms,
    String? location,
  }) {
    return PropertyFilters(
      query: query ?? this.query,
      types: types ?? this.types,
      minPrice: minPrice ?? this.minPrice,
      maxPrice: maxPrice ?? this.maxPrice,
      minBedrooms: minBedrooms ?? this.minBedrooms,
      location: location ?? this.location,
    );
  }
}

class PropertyFilterNotifier extends StateNotifier<PropertyFilters> {
  PropertyFilterNotifier() : super(PropertyFilters());

  void setQuery(String? query) => state = state.copyWith(query: query);
  void toggleType(PropertyType type) {
    final types = List<PropertyType>.from(state.types);
    if (types.contains(type)) {
      types.remove(type);
    } else {
      types.add(type);
    }
    state = state.copyWith(types: types);
  }

  void setPriceRange(double? min, double? max) =>
      state = state.copyWith(minPrice: min, maxPrice: max);
  void setBedrooms(int? beds) => state = state.copyWith(minBedrooms: beds);
  void setLocation(String? loc) => state = state.copyWith(location: loc);
  void clear() => state = PropertyFilters();
}

final propertyFilterProvider =
    StateNotifierProvider<PropertyFilterNotifier, PropertyFilters>((ref) {
      return PropertyFilterNotifier();
    });
