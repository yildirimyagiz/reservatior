import 'package:reservatior/shared/enums/widget_type.dart';
import 'organization.dart';
import 'user.dart';

class DashboardWidget {
  final String id;
  final String userId;
  final String? orgId;
  final WidgetType widgetType;
  final String title;
  final Organization? org;
  final User user;

  const DashboardWidget({
    required this.id,
    required this.userId,
    this.orgId,
    required this.widgetType,
    required this.title,
    this.org,
    required this.user,
  });

  factory DashboardWidget.fromJson(Map<String, dynamic> json) {
    return DashboardWidget(
      id: json['id'] as String,
      userId: json['userId'] as String,
      orgId: json['orgId'] as String?,
      widgetType: WidgetType.values.firstWhere((v) => v.name == json['widgetType']),
      title: json['title'] as String,
      org: json['org'] != null ? Organization.fromJson(json['org'] as Map<String, dynamic>) : null,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'orgId': orgId,
      'widgetType': widgetType.name,
      'title': title,
      'org': org?.toJson(),
      'user': user.toJson(),
    };
  }

  DashboardWidget copyWith({
    String? id,
    String? userId,
    String? orgId,
    WidgetType? widgetType,
    String? title,
    Organization? org,
    User? user,
  }) {
    return DashboardWidget(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      orgId: orgId ?? this.orgId,
      widgetType: widgetType ?? this.widgetType,
      title: title ?? this.title,
      org: org ?? this.org,
      user: user ?? this.user,
    );
  }
}
