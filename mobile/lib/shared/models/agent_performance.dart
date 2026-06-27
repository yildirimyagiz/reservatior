import 'user.dart';

class AgentPerformance {
  final String id;
  final String userId;
  final String period;
  final DateTime startDate;
  final DateTime endDate;
  final int leadsGenerated;
  final int showingsCompleted;
  final int offersSubmitted;
  final int dealsClosed;
  final double commissionEarned;
  final User user;

  const AgentPerformance({
    required this.id,
    required this.userId,
    required this.period,
    required this.startDate,
    required this.endDate,
    required this.leadsGenerated,
    required this.showingsCompleted,
    required this.offersSubmitted,
    required this.dealsClosed,
    required this.commissionEarned,
    required this.user,
  });

  factory AgentPerformance.fromJson(Map<String, dynamic> json) {
    return AgentPerformance(
      id: json['id'] as String,
      userId: json['userId'] as String,
      period: json['period'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      leadsGenerated: json['leadsGenerated'] as int,
      showingsCompleted: json['showingsCompleted'] as int,
      offersSubmitted: json['offersSubmitted'] as int,
      dealsClosed: json['dealsClosed'] as int,
      commissionEarned: (json['commissionEarned'] as num).toDouble(),
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'period': period,
      'startDate': startDate.toIso8601String(),
      'endDate': endDate.toIso8601String(),
      'leadsGenerated': leadsGenerated,
      'showingsCompleted': showingsCompleted,
      'offersSubmitted': offersSubmitted,
      'dealsClosed': dealsClosed,
      'commissionEarned': commissionEarned,
      'user': user.toJson(),
    };
  }

  AgentPerformance copyWith({
    String? id,
    String? userId,
    String? period,
    DateTime? startDate,
    DateTime? endDate,
    int? leadsGenerated,
    int? showingsCompleted,
    int? offersSubmitted,
    int? dealsClosed,
    double? commissionEarned,
    User? user,
  }) {
    return AgentPerformance(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      period: period ?? this.period,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      leadsGenerated: leadsGenerated ?? this.leadsGenerated,
      showingsCompleted: showingsCompleted ?? this.showingsCompleted,
      offersSubmitted: offersSubmitted ?? this.offersSubmitted,
      dealsClosed: dealsClosed ?? this.dealsClosed,
      commissionEarned: commissionEarned ?? this.commissionEarned,
      user: user ?? this.user,
    );
  }
}
