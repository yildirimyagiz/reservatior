import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/providers/property_valuation_provider.dart';
import 'package:reservatior/shared/models/property_valuation.dart';

// State class for Property Valuation
class PropertyValuationState {
  final List<PropertyValuation> valuations;
  final PropertyValuation? selectedValuation;
  final ValuationReport? selectedReport;
  final Map<String, dynamic> analytics;
  final Map<String, dynamic> stats;
  final bool isLoading;
  final bool isCreating;
  final bool isUpdating;
  final bool isDeleting;
  final bool isProcessing;
  final String? error;
  final String? successMessage;

  const PropertyValuationState({
    this.valuations = const [],
    this.selectedValuation,
    this.selectedReport,
    this.analytics = const {},
    this.stats = const {},
    this.isLoading = false,
    this.isCreating = false,
    this.isUpdating = false,
    this.isDeleting = false,
    this.isProcessing = false,
    this.error,
    this.successMessage,
  });

  PropertyValuationState copyWith({
    List<PropertyValuation>? valuations,
    PropertyValuation? selectedValuation,
    ValuationReport? selectedReport,
    Map<String, dynamic>? analytics,
    Map<String, dynamic>? stats,
    bool? isLoading,
    bool? isCreating,
    bool? isUpdating,
    bool? isDeleting,
    bool? isProcessing,
    String? error,
    String? successMessage,
  }) {
    return PropertyValuationState(
      valuations: valuations ?? this.valuations,
      selectedValuation: selectedValuation ?? this.selectedValuation,
      selectedReport: selectedReport ?? this.selectedReport,
      analytics: analytics ?? this.analytics,
      stats: stats ?? this.stats,
      isLoading: isLoading ?? this.isLoading,
      isCreating: isCreating ?? this.isCreating,
      isUpdating: isUpdating ?? this.isUpdating,
      isDeleting: isDeleting ?? this.isDeleting,
      isProcessing: isProcessing ?? this.isProcessing,
      error: error,
      successMessage: successMessage,
    );
  }
}

// Notifier for Property Valuation
class PropertyValuationNotifier extends StateNotifier<PropertyValuationState> {
  final Ref ref;

  PropertyValuationNotifier(this.ref) : super(const PropertyValuationState());

  Future<void> loadValuations({
    String? orgId,
    String? propertyId,
    String? agentId,
    String? status,
    String? valuationType,
    int page = 1,
    int limit = 20,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final valuations = await ref.read(
        propertyValuationListProvider({
          'orgId': orgId,
          'propertyId': propertyId,
          'agentId': agentId,
          'status': status,
          'valuationType': valuationType,
          'page': page,
          'limit': limit,
        }).future,
      );

      state = state.copyWith(valuations: valuations, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadValuationById(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final valuation = await ref.read(
        propertyValuationByIdProvider(id).future,
      );
      state = state.copyWith(selectedValuation: valuation, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<PropertyValuation> createValuation({
    required String propertyId,
    String? valuationType,
    String? priority,
    Map<String, dynamic>? contactInfo,
    Map<String, dynamic>? propertyData,
    String? videoUrl,
    List<String>? images,
    List<String>? requirements,
  }) async {
    state = state.copyWith(isCreating: true, error: null);

    try {
      final createNotifier = ref.read(propertyValuationCreateProvider.notifier);
      final valuation = await createNotifier.create(
        propertyId: propertyId,
        valuationType: valuationType,
        priority: priority,
        contactInfo: contactInfo,
        propertyData: propertyData,
        videoUrl: videoUrl,
        images: images,
        requirements: requirements,
      );

      // Refresh the list
      await loadValuations();

      state = state.copyWith(
        isCreating: false,
        successMessage: 'mobile.leftovers.valuation_created_successfully'.tr(),
      );

      return valuation;
    } catch (e) {
      state = state.copyWith(isCreating: false, error: e.toString());
      rethrow;
    }
  }

  Future<PropertyValuation> updateValuation(
    String id, {
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
    state = state.copyWith(isUpdating: true, error: null);

    try {
      final updateNotifier = ref.read(propertyValuationUpdateProvider.notifier);
      final valuation = await updateNotifier.updateValuation(
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

      // Update the selected valuation if it's the same
      if (state.selectedValuation?.id == id) {
        state = state.copyWith(selectedValuation: valuation);
      }

      // Refresh the list
      await loadValuations();

      state = state.copyWith(
        isUpdating: false,
        successMessage: 'mobile.leftovers.valuation_updated_successfully'.tr(),
      );

      return valuation;
    } catch (e) {
      state = state.copyWith(isUpdating: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> deleteValuation(String id) async {
    state = state.copyWith(isDeleting: true, error: null);

    try {
      final deleteNotifier = ref.read(propertyValuationDeleteProvider.notifier);
      await deleteNotifier.delete(id);

      // Clear selected valuation if it's the same
      if (state.selectedValuation?.id == id) {
        state = state.copyWith(selectedValuation: null);
      }

      // Refresh the list
      await loadValuations();

      state = state.copyWith(
        isDeleting: false,
        successMessage: 'mobile.leftovers.valuation_deleted_successfully'.tr(),
      );
    } catch (e) {
      state = state.copyWith(isDeleting: false, error: e.toString());
    }
  }

  Future<PropertyValuation> processValuation(String id) async {
    state = state.copyWith(isProcessing: true, error: null);

    try {
      final processNotifier = ref.read(
        propertyValuationProcessProvider.notifier,
      );
      final valuation = await processNotifier.process(id);

      // Update the selected valuation if it's the same
      if (state.selectedValuation?.id == id) {
        state = state.copyWith(selectedValuation: valuation);
      }

      // Refresh the list
      await loadValuations();

      state = state.copyWith(
        isProcessing: false,
        successMessage: 'mobile.leftovers.valuation_processing_started'.tr(),
      );

      return valuation;
    } catch (e) {
      state = state.copyWith(isProcessing: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> loadAnalytics(String id) async {
    try {
      final analytics = await ref.read(
        propertyValuationAnalyticsProvider(id).future,
      );
      state = state.copyWith(analytics: analytics);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> loadStats({
    String? orgId,
    String? propertyId,
    String? dateFrom,
    String? dateTo,
  }) async {
    try {
      final stats = await ref.read(
        propertyValuationStatsProvider({
          'orgId': orgId,
          'propertyId': propertyId,
          'dateFrom': dateFrom,
          'dateTo': dateTo,
        }).future,
      );
      state = state.copyWith(stats: stats);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<ValuationReport> createReport(
    String id, {
    String? reportType,
    String? format,
    Map<String, dynamic>? content,
    String? summary,
    List<String>? insights,
    List<String>? recommendations,
    Map<String, dynamic>? charts,
    bool? isPublic,
  }) async {
    try {
      final createReportNotifier = ref.read(
        propertyValuationCreateReportProvider.notifier,
      );
      final report = await createReportNotifier.createReport(
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

      state = state.copyWith(
        selectedReport: report,
        successMessage: 'mobile.leftovers.report_created_successfully'.tr(),
      );

      return report;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  Future<List<ValuationReport>> loadReports(String id) async {
    try {
      final reports = await ref.read(
        propertyValuationReportsProvider(id).future,
      );
      return reports;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  Future<List<PropertyValuation>> searchValuations(
    String query, {
    String? propertyId,
    String? status,
    String? valuationType,
    String? dateFrom,
    String? dateTo,
  }) async {
    try {
      final valuations = await ref.read(
        propertyValuationSearchProvider({
          'query': query,
          'propertyId': propertyId,
          'status': status,
          'valuationType': valuationType,
          'dateFrom': dateFrom,
          'dateTo': dateTo,
        }).future,
      );

      state = state.copyWith(valuations: valuations);
      return valuations;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  void selectValuation(PropertyValuation? valuation) {
    state = state.copyWith(selectedValuation: valuation);
  }

  void selectReport(ValuationReport? report) {
    state = state.copyWith(selectedReport: report);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearSuccessMessage() {
    state = state.copyWith(successMessage: null);
  }

  void resetState() {
    state = const PropertyValuationState();
  }
}

// Provider
final propertyValuationNotifierProvider =
    StateNotifierProvider<PropertyValuationNotifier, PropertyValuationState>((
      ref,
    ) {
      return PropertyValuationNotifier(ref);
    });

// Filter state
class PropertyValuationFilterState {
  final String? orgId;
  final String? propertyId;
  final String? agentId;
  final String? status;
  final String? valuationType;
  final String? dateFrom;
  final String? dateTo;
  final String? sortBy;
  final String? sortOrder;

  const PropertyValuationFilterState({
    this.orgId,
    this.propertyId,
    this.agentId,
    this.status,
    this.valuationType,
    this.dateFrom,
    this.dateTo,
    this.sortBy,
    this.sortOrder,
  });

  PropertyValuationFilterState copyWith({
    String? orgId,
    String? propertyId,
    String? agentId,
    String? status,
    String? valuationType,
    String? dateFrom,
    String? dateTo,
    String? sortBy,
    String? sortOrder,
  }) {
    return PropertyValuationFilterState(
      orgId: orgId ?? this.orgId,
      propertyId: propertyId ?? this.propertyId,
      agentId: agentId ?? this.agentId,
      status: status ?? this.status,
      valuationType: valuationType ?? this.valuationType,
      dateFrom: dateFrom ?? this.dateFrom,
      dateTo: dateTo ?? this.dateTo,
      sortBy: sortBy ?? this.sortBy,
      sortOrder: sortOrder ?? this.sortOrder,
    );
  }
}

final propertyValuationFilterProvider =
    StateProvider<PropertyValuationFilterState>((ref) {
      return const PropertyValuationFilterState();
    });
