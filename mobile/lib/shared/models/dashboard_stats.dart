import 'analytics.dart';

class DashboardStats {
  final int totalUsers;
  final int totalProperties;
  final int totalListings;
  final int totalDeals;
  final int totalReservations;
  final int totalContacts;
  final List<Analytics> recentActivity;

  const DashboardStats({
    required this.totalUsers,
    required this.totalProperties,
    required this.totalListings,
    required this.totalDeals,
    required this.totalReservations,
    required this.totalContacts,
    required this.recentActivity,
  });

  factory DashboardStats.fromJson(Map<String, dynamic> json) {
    return DashboardStats(
      totalUsers: json['totalUsers'] as int? ?? 0,
      totalProperties: json['totalProperties'] as int? ?? 0,
      totalListings: json['totalListings'] as int? ?? 0,
      totalDeals: json['totalDeals'] as int? ?? 0,
      totalReservations: json['totalReservations'] as int? ?? 0,
      totalContacts: json['totalContacts'] as int? ?? 0,
      recentActivity: (json['recentActivity'] as List<dynamic>?)
              ?.map((e) => Analytics.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }
}
