import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/booking_security_service.dart';
import 'package:reservatior/shared/repositories/booking_security_repository.dart';
import 'package:reservatior/shared/models/booking_security.dart';
import 'dio_client_provider.dart';

// Service Provider
final bookingSecurityServiceProvider = Provider<BookingSecurityService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return BookingSecurityService(dioClient);
});

// Repository Provider
final bookingSecurityRepositoryProvider = Provider<BookingSecurityRepository>((ref) {
  final service = ref.watch(bookingSecurityServiceProvider);
  return BookingSecurityRepositoryImpl(service);
});

// Basic Data Providers
final bookingSecurityListProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, Map<String, dynamic>>((ref, params) async {
  final repository = ref.watch(bookingSecurityRepositoryProvider);
  return repository.getBookings(
    page: params['page'] ?? 1,
    limit: params['limit'] ?? 20,
    orgId: params['orgId'],
    listingId: params['listingId'],
    contactId: params['contactId'],
    status: params['status'],
    ownershipVerified: params['ownershipVerified'],
    verificationStatus: params['verificationStatus'],
    startDate: params['startDate'],
    endDate: params['endDate'],
  );
});

final bookingSecurityByIdProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, String>((ref, id) async {
  final repository = ref.watch(bookingSecurityRepositoryProvider);
  return repository.getBookingById(id);
});

// Create Provider
final bookingSecurityCreateProvider = AsyncNotifierProvider.autoDispose<BookingSecurityCreateNotifier, Map<String, dynamic>>(() {
  return BookingSecurityCreateNotifier();
});

class BookingSecurityCreateNotifier extends AutoDisposeAsyncNotifier<Map<String, dynamic>> {
  late BookingSecurityRepository _repository;

  @override
  Future<Map<String, dynamic>> build() async {
    _repository = ref.read(bookingSecurityRepositoryProvider);
    return throw UnimplementedError('Use create() method to create a booking');
  }

  Future<Map<String, dynamic>> create({
    required String orgId,
    required String listingId,
    required String startDate,
    required String endDate,
    String? contactId,
    int? adults,
    int? children,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createBooking(
        orgId: orgId,
        listingId: listingId,
        startDate: startDate,
        endDate: endDate,
        contactId: contactId,
        adults: adults,
        children: children,
        notes: notes,
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
final bookingSecurityUpdateProvider = AsyncNotifierProvider.autoDispose<BookingSecurityUpdateNotifier, Map<String, dynamic>>(() {
  return BookingSecurityUpdateNotifier();
});

class BookingSecurityUpdateNotifier extends AutoDisposeAsyncNotifier<Map<String, dynamic>> {
  late BookingSecurityRepository _repository;

  @override
  Future<Map<String, dynamic>> build() async {
    _repository = ref.read(bookingSecurityRepositoryProvider);
    return throw UnimplementedError('Use update() method to update a booking');
  }

  Future<Map<String, dynamic>> updateBooking(String id, Map<String, dynamic> data) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateBooking(id, data);
      state = AsyncValue.data(result);
      return result;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

// Delete Provider
final bookingSecurityDeleteProvider = AsyncNotifierProvider.autoDispose<BookingSecurityDeleteNotifier, void>(() {
  return BookingSecurityDeleteNotifier();
});

class BookingSecurityDeleteNotifier extends AutoDisposeAsyncNotifier<void> {
  late BookingSecurityRepository _repository;

  @override
  Future<void> build() async {
    _repository = ref.read(bookingSecurityRepositoryProvider);
  }

  Future<void> delete(String id) async {
    state = const AsyncValue.loading();
    try {
      await _repository.deleteBooking(id);
      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

// Status Management Provider
final bookingSecurityStatusProvider = AsyncNotifierProvider.autoDispose<BookingSecurityStatusNotifier, Map<String, dynamic>>(() {
  return BookingSecurityStatusNotifier();
});

class BookingSecurityStatusNotifier extends AutoDisposeAsyncNotifier<Map<String, dynamic>> {
  late BookingSecurityRepository _repository;

  @override
  Future<Map<String, dynamic>> build() async {
    _repository = ref.read(bookingSecurityRepositoryProvider);
    return throw UnimplementedError('Use updateStatus() method to update booking status');
  }

  Future<Map<String, dynamic>> updateStatus(String id, String status, {String? notes}) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.updateBookingStatus(id, status, notes: notes);
      state = AsyncValue.data(result);
      return result;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

// Ownership Verification Providers
final bookingSecurityOwnershipVerificationProvider = FutureProvider.autoDispose.family<PropertyOwnershipVerification, String>((ref, id) async {
  final repository = ref.watch(bookingSecurityRepositoryProvider);
  return repository.getOwnershipVerification(id);
});

final bookingSecurityVerifyOwnershipProvider = AsyncNotifierProvider.autoDispose<BookingSecurityVerifyOwnershipNotifier, PropertyOwnershipVerification>(() {
  return BookingSecurityVerifyOwnershipNotifier();
});

class BookingSecurityVerifyOwnershipNotifier extends AutoDisposeAsyncNotifier<PropertyOwnershipVerification> {
  late BookingSecurityRepository _repository;

  @override
  Future<PropertyOwnershipVerification> build() async {
    _repository = ref.read(bookingSecurityRepositoryProvider);
    return throw UnimplementedError('Use verify() method to verify ownership');
  }

  Future<PropertyOwnershipVerification> verify(String id, {
    required String propertyId,
    String? verificationMethod,
    List<dynamic>? documents,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.verifyOwnership(
        id,
        propertyId: propertyId,
        verificationMethod: verificationMethod,
        documents: documents,
        notes: notes,
      );
      state = AsyncValue.data(result);
      return result;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

// Security Screening Providers
final bookingSecurityScreeningsProvider = FutureProvider.autoDispose.family<List<BookingSecurityScreening>, String>((ref, id) async {
  final repository = ref.watch(bookingSecurityRepositoryProvider);
  return repository.getSecurityScreenings(id);
});

final bookingSecurityCreateScreeningProvider = AsyncNotifierProvider.autoDispose<BookingSecurityCreateScreeningNotifier, BookingSecurityScreening>(() {
  return BookingSecurityCreateScreeningNotifier();
});

class BookingSecurityCreateScreeningNotifier extends AutoDisposeAsyncNotifier<BookingSecurityScreening> {
  late BookingSecurityRepository _repository;

  @override
  Future<BookingSecurityScreening> build() async {
    _repository = ref.read(bookingSecurityRepositoryProvider);
    return throw UnimplementedError('Use createScreening() method to create security screening');
  }

  Future<BookingSecurityScreening> createScreening(String id, {
    String? riskLevel,
    double? riskScore,
    bool? manualReviewRequired,
    Map<String, dynamic>? screeningMetadata,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    try {
      final result = await _repository.createSecurityScreening(
        id,
        riskLevel: riskLevel,
        riskScore: riskScore,
        manualReviewRequired: manualReviewRequired,
        screeningMetadata: screeningMetadata,
        notes: notes,
      );
      state = AsyncValue.data(result);
      return result;
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
      rethrow;
    }
  }
}

// Security Status Provider
final bookingSecurityStatusByIdProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, String>((ref, id) async {
  final repository = ref.watch(bookingSecurityRepositoryProvider);
  return repository.getSecurityStatus(id);
});

// Analytics Provider
final bookingSecurityAnalyticsProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, Map<String, dynamic>>((ref, params) async {
  final repository = ref.watch(bookingSecurityRepositoryProvider);
  return repository.getBookingAnalytics(
    orgId: params['orgId'],
    propertyId: params['propertyId'],
    dateFrom: params['dateFrom'],
    dateTo: params['dateTo'],
  );
});

// High Risk Bookings Provider
final bookingSecurityHighRiskProvider = FutureProvider.autoDispose.family<List<Map<String, dynamic>>, Map<String, dynamic>>((ref, params) async {
  final repository = ref.watch(bookingSecurityRepositoryProvider);
  return repository.getHighRiskBookings(
    orgId: params['orgId'],
    riskThreshold: params['riskThreshold'],
    limit: params['limit'],
  );
});

// Search Provider
final bookingSecuritySearchProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, Map<String, dynamic>>((ref, params) async {
  final repository = ref.watch(bookingSecurityRepositoryProvider);
  return repository.searchBookings(
    params['query'],
    orgId: params['orgId'],
    status: params['status'],
    propertyId: params['propertyId'],
    contactId: params['contactId'],
    dateFrom: params['dateFrom'],
    dateTo: params['dateTo'],
    riskLevel: params['riskLevel'],
    verificationStatus: params['verificationStatus'],
  );
});

// Calendar Provider
final bookingSecurityCalendarProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, Map<String, dynamic>>((ref, params) async {
  final repository = ref.watch(bookingSecurityRepositoryProvider);
  return repository.getBookingCalendar(
    propertyId: params['propertyId'],
    month: params['month'],
    year: params['year'],
    includeSecurityStatus: params['includeSecurityStatus'],
  );
});

// Availability & Pricing Providers
final bookingSecurityAvailabilityProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, Map<String, dynamic>>((ref, params) async {
  final repository = ref.watch(bookingSecurityRepositoryProvider);
  return repository.checkPropertyAvailability(
    params['propertyId'],
    params['startDate'],
    params['endDate'],
  );
});

final bookingSecurityPricingProvider = FutureProvider.autoDispose.family<Map<String, dynamic>, Map<String, dynamic>>((ref, params) async {
  final repository = ref.watch(bookingSecurityRepositoryProvider);
  return repository.getBookingPrice(
    params['propertyId'],
    params['startDate'],
    params['endDate'],
    params['adults'],
    params['children'],
  );
});

// State Providers
final bookingSecurityLoadingProvider = StateProvider<bool>((ref) => false);
final bookingSecurityErrorProvider = StateProvider<String?>((ref) => null);
final bookingSecuritySelectedProvider = StateProvider<Map<String, dynamic>?>((ref) => null);
