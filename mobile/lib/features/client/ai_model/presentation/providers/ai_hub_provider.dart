import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/features/client/ai_model/data/repositories/ai_hub_repository.dart';
import 'package:reservatior/shared/providers/dio_client_provider.dart';

final aiHubRepositoryProvider = Provider<AiHubRepository>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return AiHubRepository(dioClient.dio);
});

final aiFraudDetectionsProvider = FutureProvider<List<dynamic>>((ref) async {
  final repo = ref.read(aiHubRepositoryProvider);
  return repo.fetchFraudDetections();
});

final aiMarketAnalysisProvider = FutureProvider<List<dynamic>>((ref) async {
  final repo = ref.read(aiHubRepositoryProvider);
  return repo.fetchMarketAnalysis();
});

final aiSentimentAnalysisProvider = FutureProvider<List<dynamic>>((ref) async {
  final repo = ref.read(aiHubRepositoryProvider);
  return repo.fetchSentimentAnalysis();
});

final aiTenantScreeningsProvider = FutureProvider<List<dynamic>>((ref) async {
  final repo = ref.read(aiHubRepositoryProvider);
  return repo.fetchTenantScreenings();
});

final aiPriceOptimizationsProvider = FutureProvider<List<dynamic>>((ref) async {
  final repo = ref.read(aiHubRepositoryProvider);
  return repo.fetchPriceOptimizations();
});

// Generic provider for others
final aiGenericMetricsProvider = FutureProvider.family<List<dynamic>, String>((ref, endpoint) async {
  final repo = ref.read(aiHubRepositoryProvider);
  return repo.fetchGeneric(endpoint);
});

class AiHubState {
  final bool isLoading;
  final String? errorMessage;
  final Map<String, dynamic>? resultData;

  AiHubState({
    this.isLoading = false,
    this.errorMessage,
    this.resultData,
  });

  AiHubState copyWith({
    bool? isLoading,
    String? errorMessage,
    Map<String, dynamic>? resultData,
  }) {
    return AiHubState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      resultData: resultData,
    );
  }
}

class AiHubNotifier extends StateNotifier<AiHubState> {
  final AiHubRepository _repository;

  AiHubNotifier(this._repository) : super(AiHubState());

  Future<Map<String, dynamic>?> generateDescription(Map<String, dynamic> payload) async {
    state = state.copyWith(isLoading: true);
    final res = await _repository.generatePropertyDescription(payload);
    if (res != null) {
      state = state.copyWith(isLoading: false, resultData: res);
      return res;
    } else {
      state = state.copyWith(isLoading: false, errorMessage: "Description generation failed");
      return null;
    }
  }

  Future<Map<String, dynamic>?> generateImageAnalysis(Map<String, dynamic> payload) async {
    state = state.copyWith(isLoading: true);
    final res = await _repository.generateImageAnalysis(payload);
    if (res != null) {
      state = state.copyWith(isLoading: false, resultData: res);
      return res;
    } else {
      state = state.copyWith(isLoading: false, errorMessage: "Image analysis failed");
      return null;
    }
  }

  Future<Map<String, dynamic>?> generatePriceOptimization(Map<String, dynamic> payload) async {
    state = state.copyWith(isLoading: true);
    final res = await _repository.generatePriceOptimization(payload);
    if (res != null) {
      state = state.copyWith(isLoading: false, resultData: res);
      return res;
    } else {
      state = state.copyWith(isLoading: false, errorMessage: "Price optimization failed");
      return null;
    }
  }

  Future<Map<String, dynamic>?> generateLeadScore(Map<String, dynamic> payload) async {
    state = state.copyWith(isLoading: true);
    final res = await _repository.generateLeadScore(payload);
    if (res != null) {
      state = state.copyWith(isLoading: false, resultData: res);
      return res;
    } else {
      state = state.copyWith(isLoading: false, errorMessage: "Lead scoring failed");
      return null;
    }
  }

  Future<Map<String, dynamic>?> generateSentimentAnalysis(Map<String, dynamic> payload) async {
    state = state.copyWith(isLoading: true);
    final res = await _repository.generateSentimentAnalysis(payload);
    if (res != null) {
      state = state.copyWith(isLoading: false, resultData: res);
      return res;
    } else {
      state = state.copyWith(isLoading: false, errorMessage: "Sentiment analysis failed");
      return null;
    }
  }

  Future<Map<String, dynamic>?> generateTenantScreening(Map<String, dynamic> payload) async {
    state = state.copyWith(isLoading: true);
    final res = await _repository.generateTenantScreening(payload);
    if (res != null) {
      state = state.copyWith(isLoading: false, resultData: res);
      return res;
    } else {
      state = state.copyWith(isLoading: false, errorMessage: "Tenant screening failed");
      return null;
    }
  }

  Future<Map<String, dynamic>?> generateValuation(Map<String, dynamic> payload) async {
    state = state.copyWith(isLoading: true);
    final res = await _repository.generatePropertyValuation(payload);
    if (res != null) {
      state = state.copyWith(isLoading: false, resultData: res);
      return res;
    } else {
      state = state.copyWith(isLoading: false, errorMessage: "Valuation failed");
      return null;
    }
  }
}

final aiHubControllerProvider = StateNotifierProvider<AiHubNotifier, AiHubState>((ref) {
  final repo = ref.watch(aiHubRepositoryProvider);
  return AiHubNotifier(repo);
});
