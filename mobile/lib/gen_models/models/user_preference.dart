
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'user.dart';


class UserPreference implements PrismaModel<String, UserPreference> , Id<String> {
    @override
String? id;
	String? userId;
	String? orgId;
	String? theme;
	String? language;
	String? timezone;
	String? dateFormat;
	String? currency;
	bool? emailNotifications;
	bool? pushNotifications;
	bool? marketingEmails;
	dynamic dashboardLayout;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	User? user;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    UserPreference({ this.id,
	 this.userId,
	 this.orgId,
	 this.theme = "light",
	 this.language = "en-GB",
	 this.timezone = "Europe/London",
	 this.dateFormat = "DD/MM/YYYY",
	 this.currency = "USD",
	 this.emailNotifications = true,
	 this.pushNotifications = true,
	 this.marketingEmails = false,
	required this.dashboardLayout,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.user,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<UserPreference, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"userId": (m) => m.userId,

	"orgId": (m) => m.orgId,

	"theme": (m) => m.theme,

	"language": (m) => m.language,

	"timezone": (m) => m.timezone,

	"dateFormat": (m) => m.dateFormat,

	"currency": (m) => m.currency,

	"emailNotifications": (m) => m.emailNotifications,

	"pushNotifications": (m) => m.pushNotifications,

	"marketingEmails": (m) => m.marketingEmails,

	"dashboardLayout": (m) => m.dashboardLayout,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"user": (m) => m.user,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(UserPreference) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in UserPreference');
    }
    return propFunction as V? Function(UserPreference);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory UserPreference.fromJson(JsonMap json) =>
      UserPreference(
        id: json['id'] as String?,
	userId: json['userId'] as String?,
	orgId: json['orgId'] as String?,
	theme: json['theme'] as String?,
	language: json['language'] as String?,
	timezone: json['timezone'] as String?,
	dateFormat: json['dateFormat'] as String?,
	currency: json['currency'] as String?,
	emailNotifications: json['emailNotifications'] as bool?,
	pushNotifications: json['pushNotifications'] as bool?,
	marketingEmails: json['marketingEmails'] as bool?,
	dashboardLayout: json['dashboardLayout'] as dynamic,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    UserPreference copyWith({
        Value<String?>? id,
		Value<String?>? userId,
		Value<String?>? orgId,
		Value<String?>? theme,
		Value<String?>? language,
		Value<String?>? timezone,
		Value<String?>? dateFormat,
		Value<String?>? currency,
		Value<bool?>? emailNotifications,
		Value<bool?>? pushNotifications,
		Value<bool?>? marketingEmails,
		Value<dynamic>? dashboardLayout,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<User?>? user,
        }) {
        return UserPreference(
            id: id != null ? id.value : this.id,
		userId: userId != null ? userId.value : this.userId,
		orgId: orgId != null ? orgId.value : this.orgId,
		theme: theme != null ? theme.value : this.theme,
		language: language != null ? language.value : this.language,
		timezone: timezone != null ? timezone.value : this.timezone,
		dateFormat: dateFormat != null ? dateFormat.value : this.dateFormat,
		currency: currency != null ? currency.value : this.currency,
		emailNotifications: emailNotifications != null ? emailNotifications.value : this.emailNotifications,
		pushNotifications: pushNotifications != null ? pushNotifications.value : this.pushNotifications,
		marketingEmails: marketingEmails != null ? marketingEmails.value : this.marketingEmails,
		dashboardLayout: dashboardLayout != null ? dashboardLayout.value : this.dashboardLayout,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		user: user != null ? user.value : this.user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    UserPreference copyWithInstanceValues(UserPreference userPreference) {
        return UserPreference(
            id: userPreference.id ?? id,
		userId: userPreference.userId ?? userId,
		orgId: userPreference.orgId ?? orgId,
		theme: userPreference.theme ?? theme,
		language: userPreference.language ?? language,
		timezone: userPreference.timezone ?? timezone,
		dateFormat: userPreference.dateFormat ?? dateFormat,
		currency: userPreference.currency ?? currency,
		emailNotifications: userPreference.emailNotifications ?? emailNotifications,
		pushNotifications: userPreference.pushNotifications ?? pushNotifications,
		marketingEmails: userPreference.marketingEmails ?? marketingEmails,
		dashboardLayout: userPreference.dashboardLayout ?? dashboardLayout,
		createdAt: userPreference.createdAt ?? createdAt,
		updatedAt: userPreference.updatedAt ?? updatedAt,
		deletedAt: userPreference.deletedAt ?? deletedAt,
		org: userPreference.org ?? org,
		user: userPreference.user ?? user
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    UserPreference mergeWithInstanceValues(UserPreference userPreference) {
        return UserPreference(
            id: userPreference.$assignedFields.contains('id') ? userPreference.id : id,
		userId: userPreference.$assignedFields.contains('userId') ? userPreference.userId : userId,
		orgId: userPreference.$assignedFields.contains('orgId') ? userPreference.orgId : orgId,
		theme: userPreference.$assignedFields.contains('theme') ? userPreference.theme : theme,
		language: userPreference.$assignedFields.contains('language') ? userPreference.language : language,
		timezone: userPreference.$assignedFields.contains('timezone') ? userPreference.timezone : timezone,
		dateFormat: userPreference.$assignedFields.contains('dateFormat') ? userPreference.dateFormat : dateFormat,
		currency: userPreference.$assignedFields.contains('currency') ? userPreference.currency : currency,
		emailNotifications: userPreference.$assignedFields.contains('emailNotifications') ? userPreference.emailNotifications : emailNotifications,
		pushNotifications: userPreference.$assignedFields.contains('pushNotifications') ? userPreference.pushNotifications : pushNotifications,
		marketingEmails: userPreference.$assignedFields.contains('marketingEmails') ? userPreference.marketingEmails : marketingEmails,
		dashboardLayout: userPreference.$assignedFields.contains('dashboardLayout') ? userPreference.dashboardLayout : dashboardLayout,
		createdAt: userPreference.$assignedFields.contains('createdAt') ? userPreference.createdAt : createdAt,
		updatedAt: userPreference.$assignedFields.contains('updatedAt') ? userPreference.updatedAt : updatedAt,
		deletedAt: userPreference.$assignedFields.contains('deletedAt') ? userPreference.deletedAt : deletedAt,
		org: userPreference.$assignedFields.contains('org') ? userPreference.org : org,
		user: userPreference.$assignedFields.contains('user') ? userPreference.user : user
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    UserPreference updateWithInstanceValues(UserPreference userPreference) {
        if (userPreference.$assignedFields.contains('id')) { id = userPreference.id; }
		if (userPreference.$assignedFields.contains('userId')) { userId = userPreference.userId; }
		if (userPreference.$assignedFields.contains('orgId')) { orgId = userPreference.orgId; }
		if (userPreference.$assignedFields.contains('theme')) { theme = userPreference.theme; }
		if (userPreference.$assignedFields.contains('language')) { language = userPreference.language; }
		if (userPreference.$assignedFields.contains('timezone')) { timezone = userPreference.timezone; }
		if (userPreference.$assignedFields.contains('dateFormat')) { dateFormat = userPreference.dateFormat; }
		if (userPreference.$assignedFields.contains('currency')) { currency = userPreference.currency; }
		if (userPreference.$assignedFields.contains('emailNotifications')) { emailNotifications = userPreference.emailNotifications; }
		if (userPreference.$assignedFields.contains('pushNotifications')) { pushNotifications = userPreference.pushNotifications; }
		if (userPreference.$assignedFields.contains('marketingEmails')) { marketingEmails = userPreference.marketingEmails; }
		if (userPreference.$assignedFields.contains('dashboardLayout')) { dashboardLayout = userPreference.dashboardLayout; }
		if (userPreference.$assignedFields.contains('createdAt')) { createdAt = userPreference.createdAt; }
		if (userPreference.$assignedFields.contains('updatedAt')) { updatedAt = userPreference.updatedAt; }
		if (userPreference.$assignedFields.contains('deletedAt')) { deletedAt = userPreference.deletedAt; }
		if (userPreference.$assignedFields.contains('org')) { org = userPreference.org; }
		if (userPreference.$assignedFields.contains('user')) { user = userPreference.user; }
        return this;
    }

    /// Converts this instance to a JSON object.
    /// 
    /// [serializedTypes] - Internal parameter tracking which model types have been serialized
    /// in the current chain to prevent circular references.
    /// [preventCircularSerialization] - When true (default), prevents infinite recursion by
    /// skipping relations whose types have already been serialized in the current chain.
    /// Set to false to serialize all relations (use with caution - may cause infinite loops).
    @override
    JsonMap toJson({
      Set<String>? serializedTypes,
      bool preventCircularSerialization = true,
    }) {
      final Set<String> serializedModels = preventCircularSerialization 
          ? {...?serializedTypes, 'UserPreference'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(userId != null) 'userId': userId,
	if(orgId != null) 'orgId': orgId,
	if(theme != null) 'theme': theme,
	if(language != null) 'language': language,
	if(timezone != null) 'timezone': timezone,
	if(dateFormat != null) 'dateFormat': dateFormat,
	if(currency != null) 'currency': currency,
	if(emailNotifications != null) 'emailNotifications': emailNotifications,
	if(pushNotifications != null) 'pushNotifications': pushNotifications,
	if(marketingEmails != null) 'marketingEmails': marketingEmails,
	if(dashboardLayout != null) 'dashboardLayout': dashboardLayout,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is UserPreference &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    