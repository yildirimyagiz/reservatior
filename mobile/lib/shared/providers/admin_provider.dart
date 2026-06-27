import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/models/models.dart';
import 'package:reservatior/shared/services/property_service.dart';
import 'package:reservatior/shared/services/user_service.dart';
import 'package:reservatior/shared/services/booking_service.dart';
import 'package:reservatior/shared/repositories/property_repository.dart';
import 'dio_client_provider.dart';

// Admin Dashboard Metrics
class AdminMetrics {
  final double totalRevenue;
  final double totalExpenses;
  final double totalProfit;
  final int totalProperties;
  final int occupiedProperties;
  final int vacantProperties;
  final int totalUsers;
  final int activeUsers;
  final int totalTasks;
  final int completedTasks;
  final int pendingTasks;
  final double revenueGrowth;
  final double occupancyRate;
  final double avgTaskCompletion;

  AdminMetrics({
    required this.totalRevenue,
    required this.totalExpenses,
    required this.totalProfit,
    required this.totalProperties,
    required this.occupiedProperties,
    required this.vacantProperties,
    required this.totalUsers,
    required this.activeUsers,
    required this.totalTasks,
    required this.completedTasks,
    required this.pendingTasks,
    required this.revenueGrowth,
    required this.occupancyRate,
    required this.avgTaskCompletion,
  });
}

// Top Agent Model
class TopAgent {
  final String id;
  final String name;
  final String email;
  final int totalDeals;
  final double totalRevenue;
  final double rating;
  final double commission;

  TopAgent({
    required this.id,
    required this.name,
    required this.email,
    required this.totalDeals,
    required this.totalRevenue,
    required this.rating,
    required this.commission,
  });
}

// Recent Activity Model
class RecentActivity {
  final String id;
  final String type;
  final String title;
  final String description;
  final String timestamp;
  final String? user;

  RecentActivity({
    required this.id,
    required this.type,
    required this.title,
    required this.description,
    required this.timestamp,
    this.user,
  });
}

// Admin Dashboard Provider
final adminDashboardProvider = FutureProvider.autoDispose<AdminMetrics>((ref) async {
  // Simulate API call for admin metrics
  await Future.delayed(const Duration(seconds: 1));
  
  // In real implementation, this would call actual API endpoints
  return AdminMetrics(
    totalRevenue: 2456890.50,
    totalExpenses: 1876543.25,
    totalProfit: 580347.25,
    totalProperties: 1234,
    occupiedProperties: 1080,
    vacantProperties: 154,
    totalUsers: 45678,
    activeUsers: 12456,
    totalTasks: 892,
    completedTasks: 840,
    pendingTasks: 52,
    revenueGrowth: 12.5,
    occupancyRate: 87.5,
    avgTaskCompletion: 94.2,
  );
});

// Top Agents Provider
final topAgentsProvider = FutureProvider.autoDispose<List<TopAgent>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 800));
  
  return [
    TopAgent(
      id: '1',
      name: 'mobile.leftovers.sarah_johnson'.tr(),
      email: 'sarah.j@reservatior.com',
      totalDeals: 45,
      totalRevenue: 2300000.0,
      rating: 4.9,
      commission: 115000.0,
    ),
    TopAgent(
      id: '2',
      name: 'mobile.leftovers.michael_chen'.tr(),
      email: 'michael.c@reservatior.com',
      totalDeals: 38,
      totalRevenue: 1800000.0,
      rating: 4.8,
      commission: 90000.0,
    ),
    TopAgent(
      id: '3',
      name: 'mobile.leftovers.emily_davis'.tr(),
      email: 'emily.d@reservatior.com',
      totalDeals: 32,
      totalRevenue: 1500000.0,
      rating: 4.7,
      commission: 75000.0,
    ),
  ];
});

// Recent Activity Provider
final recentActivityProvider = FutureProvider.autoDispose<List<RecentActivity>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 500));
  
  return [
    RecentActivity(
      id: '1',
      type: 'DEAL',
      title: 'mobile.auto.new_property_deal_closed'.tr(),
      description: 'Dubai Marina Villa sold for \$2.5M',
      timestamp: 'mobile.leftovers.5_minutes_ago'.tr(),
      user: 'mobile.leftovers.sarah_johnson'.tr(),
    ),
    RecentActivity(
      id: '2',
      type: 'TASK',
      title: 'mobile.auto.property_verification_completed'.tr(),
      description: 'mobile.leftovers.downtown_apartment_1204_verified'.tr(),
      timestamp: 'mobile.leftovers.15_minutes_ago'.tr(),
      user: 'System',
    ),
    RecentActivity(
      id: '3',
      type: 'USER',
      title: 'mobile.auto.new_agent_onboarded'.tr(),
      description: 'mobile.leftovers.michael_chen_joined_the_team'.tr(),
      timestamp: 'mobile.leftovers.1_hour_ago'.tr(),
      user: 'Admin',
    ),
    RecentActivity(
      id: '4',
      type: 'PAYMENT',
      title: 'mobile.auto.commission_payment_processed'.tr(),
      description: '\$45,000 paid to Emily Davis',
      timestamp: 'mobile.leftovers.2_hours_ago'.tr(),
      user: 'Finance',
    ),
    RecentActivity(
      id: '5',
      type: 'PROPERTY',
      title: 'mobile.auto.new_property_listed'.tr(),
      description: 'mobile.leftovers.palm_jumeirah_villa_added_to_inventory'.tr(),
      timestamp: 'mobile.leftovers.3_hours_ago'.tr(),
      user: 'mobile.leftovers.sarah_johnson'.tr(),
    ),
  ];
});

// Revenue Data Provider (for charts)
final revenueDataProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 600));
  
  return [
    {'month': 'Jan', 'revenue': 400000, 'expenses': 320000, 'profit': 80000},
    {'month': 'Feb', 'revenue': 450000, 'expenses': 350000, 'profit': 100000},
    {'month': 'Mar', 'revenue': 520000, 'expenses': 380000, 'profit': 140000},
    {'month': 'Apr', 'revenue': 480000, 'expenses': 360000, 'profit': 120000},
    {'month': 'May', 'revenue': 580000, 'expenses': 420000, 'profit': 160000},
    {'month': 'Jun', 'revenue': 620000, 'expenses': 450000, 'profit': 170000},
  ];
});

// Booking Management Provider
final bookingListProvider = FutureProvider.autoDispose<List<Map<String, dynamic>>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 800));
  
  return [
    {
      'id': '1',
      'property': 'mobile.leftovers.dubai_marina_villa'.tr(),
      'client': 'mobile.leftovers.john_smith'.tr(),
      'startDate': '2024-01-15',
      'endDate': '2024-01-20',
      'status': 'CONFIRMED',
      'totalPrice': 2500.0,
      'depositAmount': 500.0,
    },
    {
      'id': '2',
      'property': 'mobile.leftovers.downtown_apartment'.tr(),
      'client': 'mobile.leftovers.emily_johnson'.tr(),
      'startDate': '2024-01-18',
      'endDate': '2024-01-25',
      'status': 'PENDING',
      'totalPrice': 1800.0,
      'depositAmount': 360.0,
    },
    {
      'id': '3',
      'property': 'mobile.leftovers.palm_jumeirah_house'.tr(),
      'client': 'mobile.leftovers.michael_chen'.tr(),
      'startDate': '2024-01-10',
      'endDate': '2024-01-15',
      'status': 'COMPLETED',
      'totalPrice': 3200.0,
      'depositAmount': 640.0,
    },
  ];
});

// Booking Stats Provider
final bookingStatsProvider = FutureProvider.autoDispose<Map<String, dynamic>>((ref) async {
  await Future.delayed(const Duration(milliseconds: 400));
  
  return {
    'totalBookings': 156,
    'confirmedBookings': 89,
    'pendingBookings': 34,
    'cancelledBookings': 12,
    'completedBookings': 21,
    'totalRevenue': 45680.0,
    'avgBookingValue': 293.0,
  };
});

// Admin Actions Notifier
class AdminActionsNotifier extends StateNotifier<bool> {
  AdminActionsNotifier() : super(false);

  Future<void> createProperty(Map<String, dynamic> propertyData) async {
    state = true;
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      // In real implementation: await propertyService.createProperty(propertyData);
      state = false;
    } catch (e) {
      state = false;
      rethrow;
    }
  }

  Future<void> createUser(Map<String, dynamic> userData) async {
    state = true;
    try {
      await Future.delayed(const Duration(seconds: 1));
      // In real implementation: await userService.createUser(userData);
      state = false;
    } catch (e) {
      state = false;
      rethrow;
    }
  }

  Future<void> createBooking(Map<String, dynamic> bookingData) async {
    state = true;
    try {
      await Future.delayed(const Duration(seconds: 1));
      // In real implementation: await bookingService.createBooking(bookingData);
      state = false;
    } catch (e) {
      state = false;
      rethrow;
    }
  }
}

final adminActionsProvider = StateNotifierProvider<AdminActionsNotifier, bool>((ref) {
  return AdminActionsNotifier();
});

// Admin Filter State
class AdminFilterState {
  final String dateRange;
  final String propertyType;
  final String status;
  final String agent;

  AdminFilterState({
    this.dateRange = 'all',
    this.propertyType = 'all',
    this.status = 'all',
    this.agent = 'all',
  });

  AdminFilterState copyWith({
    String? dateRange,
    String? propertyType,
    String? status,
    String? agent,
  }) {
    return AdminFilterState(
      dateRange: dateRange ?? this.dateRange,
      propertyType: propertyType ?? this.propertyType,
      status: status ?? this.status,
      agent: agent ?? this.agent,
    );
  }
}

// Admin Filter Notifier
class AdminFilterNotifier extends StateNotifier<AdminFilterState> {
  AdminFilterNotifier() : super(AdminFilterState());

  void setDateRange(String range) {
    state = state.copyWith(dateRange: range);
  }

  void setPropertyType(String type) {
    state = state.copyWith(propertyType: type);
  }

  void setStatus(String status) {
    state = state.copyWith(status: status);
  }

  void setAgent(String agent) {
    state = state.copyWith(agent: agent);
  }

  void resetFilters() {
    state = AdminFilterState();
  }
}

final adminFilterProvider = StateNotifierProvider<AdminFilterNotifier, AdminFilterState>((ref) {
  return AdminFilterNotifier();
});
