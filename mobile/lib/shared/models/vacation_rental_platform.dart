import 'package:reservatior/shared/enums/rental_platform.dart';
import 'package:reservatior/shared/enums/rental_status.dart';
import 'vacation_rental.dart';

class VacationRentalPlatform {
  final String id;
  final String rentalId;
  final RentalPlatform platform;
  final String? externalId;
  final String? externalUrl;
  final RentalStatus status;
  final DateTime? lastSyncedAt;
  final bool syncEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;
  final VacationRental rental;

  const VacationRentalPlatform({
    required this.id,
    required this.rentalId,
    required this.platform,
    this.externalId,
    this.externalUrl,
    required this.status,
    this.lastSyncedAt,
    required this.syncEnabled,
    required this.createdAt,
    required this.updatedAt,
    required this.rental,
  });

  factory VacationRentalPlatform.fromJson(Map<String, dynamic> json) {
    return VacationRentalPlatform(
      id: json['id'] as String,
      rentalId: json['rentalId'] as String,
      platform: RentalPlatform.values.firstWhere((v) => v.name == json['platform']),
      externalId: json['externalId'] as String?,
      externalUrl: json['externalUrl'] as String?,
      status: RentalStatus.values.firstWhere((v) => v.name == json['status']),
      lastSyncedAt: json['lastSyncedAt'] != null ? DateTime.parse(json['lastSyncedAt'] as String) : null,
      syncEnabled: json['syncEnabled'] as bool,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      rental: VacationRental.fromJson(json['rental'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'rentalId': rentalId,
      'platform': platform.name,
      'externalId': externalId,
      'externalUrl': externalUrl,
      'status': status.name,
      'lastSyncedAt': lastSyncedAt?.toIso8601String(),
      'syncEnabled': syncEnabled,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'rental': rental.toJson(),
    };
  }

  VacationRentalPlatform copyWith({
    String? id,
    String? rentalId,
    RentalPlatform? platform,
    String? externalId,
    String? externalUrl,
    RentalStatus? status,
    DateTime? lastSyncedAt,
    bool? syncEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
    VacationRental? rental,
  }) {
    return VacationRentalPlatform(
      id: id ?? this.id,
      rentalId: rentalId ?? this.rentalId,
      platform: platform ?? this.platform,
      externalId: externalId ?? this.externalId,
      externalUrl: externalUrl ?? this.externalUrl,
      status: status ?? this.status,
      lastSyncedAt: lastSyncedAt ?? this.lastSyncedAt,
      syncEnabled: syncEnabled ?? this.syncEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rental: rental ?? this.rental,
    );
  }
}
