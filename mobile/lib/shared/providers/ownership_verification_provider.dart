import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ownership_verification_service.dart';
import 'package:reservatior/shared/repositories/ownership_verification_repository.dart';
import 'package:reservatior/shared/models/ownership_verification.dart';
import 'dio_client_provider.dart';

// Service Provider
final ownershipVerificationServiceProvider = Provider<OwnershipVerificationService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return OwnershipVerificationService(dioClient);
});

// Repository Provider
final ownershipVerificationRepositoryProvider = Provider<OwnershipVerificationRepository>((ref) {
  final service = ref.watch(ownershipVerificationServiceProvider);
  return OwnershipVerificationRepositoryImpl(service);
});

// Basic Data Providers
final ownershipVerificationListProvider = FutureProvider.autoDispose.family<List<PropertyOwnershipVerification>, Map<String, dynamic>>((ref, params) async {
  final repository = ref.watch(ownershipVerificationRepositoryProvider);
  return repository.getAll(params: params);
});

final ownershipVerificationByIdProvider = FutureProvider.autoDispose.family<PropertyOwnershipVerification, String>((ref, id) async {
  final repository = ref.watch(ownershipVerificationRepositoryProvider);
  return repository.getById(id);
});

// Create Provider
final ownershipVerificationCreateProvider = AsyncNotifierProvider.autoDispose<OwnershipVerificationCreateNotifier, PropertyOwnershipVerification>(() {
  return OwnershipVerificationCreateNotifier();
});

class OwnershipVerificationCreateNotifier extends AutoDisposeAsyncNotifier<PropertyOwnershipVerification> {
  late OwnershipVerificationRepository _repository;

  @override
  Future<PropertyOwnershipVerification> build() async {
    _repository = ref.read(ownershipVerificationRepositoryProvider);
    return throw UnimplementedError('Use create() method to create a verification');
  }

  Future<PropertyOwnershipVerification> create(Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.create(data);
      state = AsyncValue.data(result);
      return result;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

// Update Provider
final ownershipVerificationUpdateProvider = AsyncNotifierProvider.autoDispose<OwnershipVerificationUpdateNotifier, PropertyOwnershipVerification>(() {
  return OwnershipVerificationUpdateNotifier();
});

class OwnershipVerificationUpdateNotifier extends AutoDisposeAsyncNotifier<PropertyOwnershipVerification> {
  late OwnershipVerificationRepository _repository;

  @override
  Future<PropertyOwnershipVerification> build() async {
    _repository = ref.read(ownershipVerificationRepositoryProvider);
    return throw UnimplementedError('Use update() method to update a verification');
  }

  Future<PropertyOwnershipVerification> updateVerification(String id, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.update(id, data);
      state = AsyncValue.data(result);
      return result;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

// Delete Provider
final ownershipVerificationDeleteProvider = AsyncNotifierProvider.autoDispose<OwnershipVerificationDeleteNotifier, void>(() {
  return OwnershipVerificationDeleteNotifier();
});

class OwnershipVerificationDeleteNotifier extends AutoDisposeAsyncNotifier<void> {
  late OwnershipVerificationRepository _repository;

  @override
  Future<void> build() async {
    _repository = ref.read(ownershipVerificationRepositoryProvider);
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

// Verify Provider
final ownershipVerificationVerifyProvider = AsyncNotifierProvider.autoDispose<OwnershipVerificationVerifyNotifier, PropertyOwnershipVerification>(() {
  return OwnershipVerificationVerifyNotifier();
});

class OwnershipVerificationVerifyNotifier extends AutoDisposeAsyncNotifier<PropertyOwnershipVerification> {
  late OwnershipVerificationRepository _repository;

  @override
  Future<PropertyOwnershipVerification> build() async {
    _repository = ref.read(ownershipVerificationRepositoryProvider);
    return throw UnimplementedError('Use verify() method to verify ownership');
  }

  Future<PropertyOwnershipVerification> verify(String id, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.verify(id, data);
      state = AsyncValue.data(result);
      return result;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

// Reject Provider
final ownershipVerificationRejectProvider = AsyncNotifierProvider.autoDispose<OwnershipVerificationRejectNotifier, PropertyOwnershipVerification>(() {
  return OwnershipVerificationRejectNotifier();
});

class OwnershipVerificationRejectNotifier extends AutoDisposeAsyncNotifier<PropertyOwnershipVerification> {
  late OwnershipVerificationRepository _repository;

  @override
  Future<PropertyOwnershipVerification> build() async {
    _repository = ref.read(ownershipVerificationRepositoryProvider);
    return throw UnimplementedError('Use reject() method to reject verification');
  }

  Future<PropertyOwnershipVerification> reject(String id, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.reject(id, data);
      state = AsyncValue.data(result);
      return result;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

// State Providers
final ownershipVerificationLoadingProvider = StateProvider<bool>((ref) => false);
final ownershipVerificationErrorProvider = StateProvider<String?>((ref) => null);
final ownershipVerificationSelectedProvider = StateProvider<PropertyOwnershipVerification?>((ref) => null);
