import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/property_valuation_service.dart';
import 'package:reservatior/shared/repositories/property_valuation_repository.dart';
import 'package:reservatior/shared/models/property_valuation.dart';
import 'dio_client_provider.dart';

// Service Provider
final propertyValuationServiceProvider = Provider<PropertyValuationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return PropertyValuationService(dioClient);
});

// Repository Provider
final propertyValuationRepositoryProvider = Provider<PropertyValuationRepository>((ref) {
  final service = ref.watch(propertyValuationServiceProvider);
  return PropertyValuationRepositoryImpl(service);
});

// Basic Data Providers
final propertyValuationListProvider = FutureProvider.autoDispose.family<List<PropertyValuation>, Map<String, dynamic>>((ref, params) async {
  final repository = ref.watch(propertyValuationRepositoryProvider);
  return repository.getAll(
    page: params['page'] ?? 1,
    limit: params['limit'] ?? 20,
    orgId: params['orgId'],
    propertyId: params['propertyId'],
    agentId: params['agentId'],
    status: params['status'],
    valuationType: params['valuationType'],
    filters: params['filters'],
    sortBy: params['sortBy'],
    sortOrder: params['sortOrder'],
  );
});

final propertyValuationByIdProvider = FutureProvider.autoDispose.family<PropertyValuation, String>((ref, id) async {
  final repository = ref.watch(propertyValuationRepositoryProvider);
  return repository.getById(id);
});

// Create Provider
final propertyValuationCreateProvider = AsyncNotifierProvider.autoDispose<PropertyValuationCreateNotifier, PropertyValuation>(() {
  return PropertyValuationCreateNotifier();
});

class PropertyValuationCreateNotifier extends AutoDisposeAsyncNotifier<PropertyValuation> {
  late PropertyValuationRepository _repository;

  @override
  Future<PropertyValuation> build() async {
    _repository = ref.read(propertyValuationRepositoryProvider);
    // Return a dummy valuation initially
    return throw UnimplementedError('Use create() method to create a valuation');
  }

  Future<PropertyValuation> create({
    required String propertyId,
    String? valuationType,
    String? priority,
    Map<String, dynamic>? contactInfo,
    Map<String, dynamic>? propertyData,
    String? videoUrl,
    List<String>? images,
    List<String>? requirements,
  }) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.create(
        propertyId: propertyId,
        valuationType: valuationType,
        priority: priority,
        contactInfo: contactInfo,
        propertyData: propertyData,
        videoUrl: videoUrl,
        images: images,
        requirements: requirements,
      );
      state = AsyncValue.data(result);
      return result;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

// Update Provider
final propertyValuationUpdateProvider = AsyncNotifierProvider.autoDispose<PropertyValuationUpdateNotifier, PropertyValuation>(() {
  return PropertyValuationUpdateNotifier();
});

class PropertyValuationUpdateNotifier extends AutoDisposeAsyncNotifier<PropertyValuation> {
  late PropertyValuationRepository _repository;

  @override
  Future<PropertyValuation> build() async {
    _repository = ref.read(propertyValuationRepositoryProvider);
    return throw UnimplementedError('Use update() method to update a valuation');
  }

  Future<PropertyValuation> updateValuation(String id, {
    double? value,
    double? confidence,
    String? status,
    Map<String, dynamic>? priceRange,
    Map<String, dynamic>? marketTrends,
    List<dynamic>? comparableProperties,
    Map<String, dynamic>? factors,
    Map<String, dynamic>? aiAnalysis,
    Map<String, dynamic>? videoAnalysis,
    Map<String, dynamic>? userBehavior,
    List<String>? recommendations,
  }) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.update(
        id,
        value: value,
        confidence: confidence,
        status: status,
        priceRange: priceRange,
        marketTrends: marketTrends,
        comparableProperties: comparableProperties,
        factors: factors,
        aiAnalysis: aiAnalysis,
        videoAnalysis: videoAnalysis,
        userBehavior: userBehavior,
        recommendations: recommendations,
      );
      state = AsyncValue.data(result);
      return result;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

// Delete Provider
final propertyValuationDeleteProvider = AsyncNotifierProvider.autoDispose<PropertyValuationDeleteNotifier, void>(() {
  return PropertyValuationDeleteNotifier();
});

class PropertyValuationDeleteNotifier extends AutoDisposeAsyncNotifier<void> {
  late PropertyValuationRepository _repository;

  @override
  Future<void> build() async {
    _repository = ref.read(propertyValuationRepositoryProvider);
  }

  Future<void> delete(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.delete(id);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

// Process Valuation Provider
final propertyValuationProcessProvider = AsyncNotifierProvider.autoDispose<PropertyValuationProcessNotifier, PropertyValuation>(() {
  return PropertyValuationProcessNotifier();
});

class PropertyValuationProcessNotifier extends AutoDisposeAsyncNotifier<PropertyValuation> {
  late PropertyValuationRepository _repository;

  @override
  Future<PropertyValuation> build() async {
    _repository = ref.read(propertyValuationRepositoryProvider);
    return throw UnimplementedError('Use process() method to process a valuation');
  }

  Future<PropertyValuation> process(String id) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.processValuation(id);
      state = AsyncValue.data(result);
      return result;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

// Analytics Provider
final propertyValuationAnalyticsProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, String>((ref, id) async {
  final repository = ref.watch(propertyValuationRepositoryProvider);
  return repository.getValuationAnalytics(id);
});

// Reports Providers
final propertyValuationReportsProvider = FutureProvider.autoDispose.family<List<ValuationReport>, String>((ref, id) async {
  final repository = ref.watch(propertyValuationRepositoryProvider);
  return repository.getValuationReports(id);
});

final propertyValuationCreateReportProvider = AsyncNotifierProvider.autoDispose<PropertyValuationCreateReportNotifier, ValuationReport>(() {
  return PropertyValuationCreateReportNotifier();
});

class PropertyValuationCreateReportNotifier extends AutoDisposeAsyncNotifier<ValuationReport> {
  late PropertyValuationRepository _repository;

  @override
  Future<ValuationReport> build() async {
    _repository = ref.read(propertyValuationRepositoryProvider);
    return throw UnimplementedError('Use createReport() method to create a report');
  }

  Future<ValuationReport> createReport(String id, {
    String? reportType,
    String? format,
    Map<String, dynamic>? content,
    String? summary,
    List<String>? insights,
    List<String>? recommendations,
    Map<String, dynamic>? charts,
    bool? isPublic,
  }) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createValuationReport(
        id,
        reportType: reportType,
        format: format,
        content: content,
        summary: summary,
        insights: insights,
        recommendations: recommendations,
        charts: charts,
        isPublic: isPublic,
      );
      state = AsyncValue.data(result);
      return result;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

// Search Provider
final propertyValuationSearchProvider = FutureProvider.autoDispose.family<List<PropertyValuation>, Map<String, dynamic>>((ref, params) async {
  final repository = ref.watch(propertyValuationRepositoryProvider);
  return repository.searchValuations(
    params['query'],
    propertyId: params['propertyId'],
    status: params['status'],
    valuationType: params['valuationType'],
    dateFrom: params['dateFrom'],
    dateTo: params['dateTo'],
  );
});

// Stats Provider
final propertyValuationStatsProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, Map<String, dynamic>>((ref, params) async {
  final repository = ref.watch(propertyValuationRepositoryProvider);
  return repository.getValuationStats(
    orgId: params['orgId'],
    propertyId: params['propertyId'],
    dateFrom: params['dateFrom'],
    dateTo: params['dateTo'],
  );
});

// State Providers
final propertyValuationLoadingProvider = StateProvider<bool>((ref) => false);
final propertyValuationErrorProvider = StateProvider<String?>((ref) => null);
final propertyValuationSelectedProvider = StateProvider<PropertyValuation?>((ref) => null);
