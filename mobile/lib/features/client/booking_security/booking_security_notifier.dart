import 'package:flutter_riverpod/flutter_riverpod.dart'; 
import 'package:easy_localization/easy_localization.dart';
import 'package:reservatior/shared/providers/booking_security_provider.dart';
import 'package:reservatior/shared/models/booking_security.dart';

// State class for Booking Security
class BookingSecurityState {
  final List<Map<String, dynamic>> bookings;
  final Map<String, dynamic>? selectedBooking;
  final List<BookingSecurityScreening> securityScreenings;
  final PropertyOwnershipVerification? ownershipVerification;
  final Map<String, dynamic> securityStatus;
  final Map<String, dynamic> analytics;
  final List<Map<String, dynamic>> highRiskBookings;
  final bool isLoading;
  final bool isCreating;
  final bool isUpdating;
  final bool isDeleting;
  final bool isVerifying;
  final bool isScreening;
  final String? error;
  final String? successMessage;

  const BookingSecurityState({
    this.bookings = const [],
    this.selectedBooking,
    this.securityScreenings = const [],
    this.ownershipVerification,
    this.securityStatus = const {},
    this.analytics = const {},
    this.highRiskBookings = const [],
    this.isLoading = false,
    this.isCreating = false,
    this.isUpdating = false,
    this.isDeleting = false,
    this.isVerifying = false,
    this.isScreening = false,
    this.error,
    this.successMessage,
  });

  BookingSecurityState copyWith({
    List<Map<String, dynamic>>? bookings,
    Map<String, dynamic>? selectedBooking,
    List<BookingSecurityScreening>? securityScreenings,
    PropertyOwnershipVerification? ownershipVerification,
    Map<String, dynamic>? securityStatus,
    Map<String, dynamic>? analytics,
    List<Map<String, dynamic>>? highRiskBookings,
    bool? isLoading,
    bool? isCreating,
    bool? isUpdating,
    bool? isDeleting,
    bool? isVerifying,
    bool? isScreening,
    String? error,
    String? successMessage,
  }) {
    return BookingSecurityState(
      bookings: bookings ?? this.bookings,
      selectedBooking: selectedBooking ?? this.selectedBooking,
      securityScreenings: securityScreenings ?? this.securityScreenings,
      ownershipVerification:
          ownershipVerification ?? this.ownershipVerification,
      securityStatus: securityStatus ?? this.securityStatus,
      analytics: analytics ?? this.analytics,
      highRiskBookings: highRiskBookings ?? this.highRiskBookings,
      isLoading: isLoading ?? this.isLoading,
      isCreating: isCreating ?? this.isCreating,
      isUpdating: isUpdating ?? this.isUpdating,
      isDeleting: isDeleting ?? this.isDeleting,
      isVerifying: isVerifying ?? this.isVerifying,
      isScreening: isScreening ?? this.isScreening,
      error: error,
      successMessage: successMessage,
    );
  }
}

// Notifier for Booking Security
class BookingSecurityNotifier extends StateNotifier<BookingSecurityState> {
  final Ref ref;

  BookingSecurityNotifier(this.ref) : super(const BookingSecurityState());

  Future<void> loadBookings({
    String? orgId,
    String? listingId,
    String? contactId,
    String? status,
    bool? ownershipVerified,
    String? verificationStatus,
    String? startDate,
    String? endDate,
    int page = 1,
    int limit = 20,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final response = await ref.read(
        bookingSecurityListProvider({
          'orgId': orgId,
          'listingId': listingId,
          'contactId': contactId,
          'status': status,
          'ownershipVerified': ownershipVerified,
          'verificationStatus': verificationStatus,
          'startDate': startDate,
          'endDate': endDate,
          'page': page,
          'limit': limit,
        }).future,
      );

      state = state.copyWith(
        bookings: response['data'] as List<Map<String, dynamic>>,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<void> loadBookingById(String id) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final booking = await ref.read(bookingSecurityByIdProvider(id).future);
      state = state.copyWith(selectedBooking: booking, isLoading: false);
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  Future<Map<String, dynamic>> createBooking({
    required String orgId,
    required String listingId,
    required String startDate,
    required String endDate,
    String? contactId,
    int? adults,
    int? children,
    String? notes,
  }) async {
    state = state.copyWith(isCreating: true, error: null);

    try {
      final createNotifier = ref.read(bookingSecurityCreateProvider.notifier);
      final booking = await createNotifier.create(
        orgId: orgId,
        listingId: listingId,
        startDate: startDate,
        endDate: endDate,
        contactId: contactId,
        adults: adults,
        children: children,
        notes: notes,
      );

      // Refresh the list
      await loadBookings();

      state = state.copyWith(
        isCreating: false,
        successMessage: 'mobile.leftovers.booking_created_successfully'.tr(),
      );

      return booking;
    } catch (e) {
      state = state.copyWith(isCreating: false, error: e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> updateBooking(
    String id,
    Map<String, dynamic> data,
  ) async {
    state = state.copyWith(isUpdating: true, error: null);

    try {
      final updateNotifier = ref.read(bookingSecurityUpdateProvider.notifier);
      final booking = await updateNotifier.updateBooking(id, data);

      // Update the selected booking if it's the same
      if (state.selectedBooking?['id'] == id) {
        state = state.copyWith(selectedBooking: booking);
      }

      // Refresh the list
      await loadBookings();

      state = state.copyWith(
        isUpdating: false,
        successMessage: 'mobile.leftovers.booking_updated_successfully'.tr(),
      );

      return booking;
    } catch (e) {
      state = state.copyWith(isUpdating: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> deleteBooking(String id) async {
    state = state.copyWith(isDeleting: true, error: null);

    try {
      final deleteNotifier = ref.read(bookingSecurityDeleteProvider.notifier);
      await deleteNotifier.delete(id);

      // Clear selected booking if it's the same
      if (state.selectedBooking?['id'] == id) {
        state = state.copyWith(selectedBooking: null);
      }

      // Refresh the list
      await loadBookings();

      state = state.copyWith(
        isDeleting: false,
        successMessage: 'mobile.leftovers.booking_deleted_successfully'.tr(),
      );
    } catch (e) {
      state = state.copyWith(isDeleting: false, error: e.toString());
    }
  }

  Future<Map<String, dynamic>> updateBookingStatus(
    String id,
    String status, {
    String? notes,
  }) async {
    try {
      final statusNotifier = ref.read(bookingSecurityStatusProvider.notifier);
      final result = await statusNotifier.updateStatus(
        id,
        status,
        notes: notes,
      );

      // Update the selected booking if it's the same
      if (state.selectedBooking?['id'] == id) {
        state = state.copyWith(selectedBooking: result);
      }

      // Refresh the list
      await loadBookings();

      state = state.copyWith(
        successMessage: 'mobile.leftovers.booking_status_updated_successfully'.tr(),
      );

      return result;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  Future<PropertyOwnershipVerification> verifyOwnership(
    String id, {
    required String propertyId,
    String? verificationMethod,
    List<dynamic>? documents,
    String? notes,
  }) async {
    state = state.copyWith(isVerifying: true, error: null);

    try {
      final verifyNotifier = ref.read(
        bookingSecurityVerifyOwnershipProvider.notifier,
      );
      final verification = await verifyNotifier.verify(
        id,
        propertyId: propertyId,
        verificationMethod: verificationMethod,
        documents: documents,
        notes: notes,
      );

      state = state.copyWith(
        ownershipVerification: verification,
        isVerifying: false,
        successMessage: 'mobile.leftovers.ownership_verification_completed'.tr(),
      );

      return verification;
    } catch (e) {
      state = state.copyWith(isVerifying: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> loadOwnershipVerification(String id) async {
    try {
      final verification = await ref.read(
        bookingSecurityOwnershipVerificationProvider(id).future,
      );
      state = state.copyWith(ownershipVerification: verification);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<BookingSecurityScreening> createSecurityScreening(
    String id, {
    String? riskLevel,
    double? riskScore,
    bool? manualReviewRequired,
    Map<String, dynamic>? screeningMetadata,
    String? notes,
  }) async {
    state = state.copyWith(isScreening: true, error: null);

    try {
      final createScreeningNotifier = ref.read(
        bookingSecurityCreateScreeningProvider.notifier,
      );
      final screening = await createScreeningNotifier.createScreening(
        id,
        riskLevel: riskLevel,
        riskScore: riskScore,
        manualReviewRequired: manualReviewRequired,
        screeningMetadata: screeningMetadata,
        notes: notes,
      );

      // Refresh the screenings list
      await loadSecurityScreenings(id);

      state = state.copyWith(
        isScreening: false,
        successMessage: 'mobile.leftovers.security_screening_created'.tr(),
      );

      return screening;
    } catch (e) {
      state = state.copyWith(isScreening: false, error: e.toString());
      rethrow;
    }
  }

  Future<void> loadSecurityScreenings(String id) async {
    try {
      final screenings = await ref.read(
        bookingSecurityScreeningsProvider(id).future,
      );
      state = state.copyWith(securityScreenings: screenings);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> loadSecurityStatus(String id) async {
    try {
      final status = await ref.read(
        bookingSecurityStatusByIdProvider(id).future,
      );
      state = state.copyWith(securityStatus: status);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> loadAnalytics({
    String? orgId,
    String? propertyId,
    String? dateFrom,
    String? dateTo,
  }) async {
    try {
      final analytics = await ref.read(
        bookingSecurityAnalyticsProvider({
          'orgId': orgId,
          'propertyId': propertyId,
          'dateFrom': dateFrom,
          'dateTo': dateTo,
        }).future,
      );
      state = state.copyWith(analytics: analytics);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<void> loadHighRiskBookings({
    String? orgId,
    double? riskThreshold,
    int? limit,
  }) async {
    try {
      final highRiskBookings = await ref.read(
        bookingSecurityHighRiskProvider({
          'orgId': orgId,
          'riskThreshold': riskThreshold,
          'limit': limit,
        }).future,
      );
      state = state.copyWith(highRiskBookings: highRiskBookings);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  Future<Map<String, dynamic>> searchBookings(
    String query, {
    String? orgId,
    String? status,
    String? propertyId,
    String? contactId,
    String? dateFrom,
    String? dateTo,
    String? riskLevel,
    String? verificationStatus,
  }) async {
    try {
      final response = await ref.read(
        bookingSecuritySearchProvider({
          'query': query,
          'orgId': orgId,
          'status': status,
          'propertyId': propertyId,
          'contactId': contactId,
          'dateFrom': dateFrom,
          'dateTo': dateTo,
          'riskLevel': riskLevel,
          'verificationStatus': verificationStatus,
        }).future,
      );

      state = state.copyWith(
        bookings: response['data'] as List<Map<String, dynamic>>,
      );
      return response;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> checkPropertyAvailability(
    String propertyId,
    String startDate,
    String endDate,
  ) async {
    try {
      final availability = await ref.read(
        bookingSecurityAvailabilityProvider({
          'propertyId': propertyId,
          'startDate': startDate,
          'endDate': endDate,
        }).future,
      );
      return availability;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  Future<Map<String, dynamic>> getBookingPrice(
    String propertyId,
    String startDate,
    String endDate,
    int adults,
    int children,
  ) async {
    try {
      final pricing = await ref.read(
        bookingSecurityPricingProvider({
          'propertyId': propertyId,
          'startDate': startDate,
          'endDate': endDate,
          'adults': adults,
          'children': children,
        }).future,
      );
      return pricing;
    } catch (e) {
      state = state.copyWith(error: e.toString());
      rethrow;
    }
  }

  void selectBooking(Map<String, dynamic>? booking) {
    state = state.copyWith(selectedBooking: booking);
  }

  void selectOwnershipVerification(
    PropertyOwnershipVerification? verification,
  ) {
    state = state.copyWith(ownershipVerification: verification);
  }

  void clearError() {
    state = state.copyWith(error: null);
  }

  void clearSuccessMessage() {
    state = state.copyWith(successMessage: null);
  }

  void resetState() {
    state = const BookingSecurityState();
  }
}

// Provider
final bookingSecurityNotifierProvider =
    StateNotifierProvider<BookingSecurityNotifier, BookingSecurityState>((ref) {
      return BookingSecurityNotifier(ref);
    });

// Filter state
class BookingSecurityFilterState {
  final String? orgId;
  final String? listingId;
  final String? contactId;
  final String? status;
  final bool? ownershipVerified;
  final String? verificationStatus;
  final String? startDate;
  final String? endDate;
  final String? riskLevel;

  const BookingSecurityFilterState({
    this.orgId,
    this.listingId,
    this.contactId,
    this.status,
    this.ownershipVerified,
    this.verificationStatus,
    this.startDate,
    this.endDate,
    this.riskLevel,
  });

  BookingSecurityFilterState copyWith({
    String? orgId,
    String? listingId,
    String? contactId,
    String? status,
    bool? ownershipVerified,
    String? verificationStatus,
    String? startDate,
    String? endDate,
    String? riskLevel,
  }) {
    return BookingSecurityFilterState(
      orgId: orgId ?? this.orgId,
      listingId: listingId ?? this.listingId,
      contactId: contactId ?? this.contactId,
      status: status ?? this.status,
      ownershipVerified: ownershipVerified ?? this.ownershipVerified,
      verificationStatus: verificationStatus ?? this.verificationStatus,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      riskLevel: riskLevel ?? this.riskLevel,
    );
  }
}

final bookingSecurityFilterProvider = StateProvider<BookingSecurityFilterState>(
  (ref) {
    return const BookingSecurityFilterState();
  },
);
