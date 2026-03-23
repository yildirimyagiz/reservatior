
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'organization.dart';
import 'currency.dart';
import 'analytics.dart';


class TaxRecord implements PrismaModel<String, TaxRecord> , Id<String> {
    @override
String? id;
	String? orgId;
	String? profileId;
	String? transactionId;
	String? propertyId;
	String? contactId;
	String? recordType;
	dynamic profileData;
	dynamic categoryData;
	dynamic lineItemData;
	dynamic auditData;
	dynamic ruleData;
	dynamic depreciationData;
	dynamic form1099Data;
	bool? isActive;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Organization? org;
	TaxRecord? profile;
	List<TaxRecord>? profiles;
	List<Currency>? currencies;
	List<Analytics>? analytics;
	int? $profilesCount;
	int? $currenciesCount;
	int? $analyticsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    TaxRecord({ this.id,
	 this.orgId,
	 this.profileId,
	 this.transactionId,
	 this.propertyId,
	 this.contactId,
	 this.recordType,
	required this.profileData,
	required this.categoryData,
	required this.lineItemData,
	required this.auditData,
	required this.ruleData,
	required this.depreciationData,
	required this.form1099Data,
	 this.isActive = true,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.org,
	 this.profile,
	 this.profiles,
	 this.currencies,
	 this.analytics,
	this.$profilesCount,
	this.$currenciesCount,
	this.$analyticsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<TaxRecord, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"profileId": (m) => m.profileId,

	"transactionId": (m) => m.transactionId,

	"propertyId": (m) => m.propertyId,

	"contactId": (m) => m.contactId,

	"recordType": (m) => m.recordType,

	"profileData": (m) => m.profileData,

	"categoryData": (m) => m.categoryData,

	"lineItemData": (m) => m.lineItemData,

	"auditData": (m) => m.auditData,

	"ruleData": (m) => m.ruleData,

	"depreciationData": (m) => m.depreciationData,

	"form1099Data": (m) => m.form1099Data,

	"isActive": (m) => m.isActive,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"org": (m) => m.org,

	"profile": (m) => m.profile,

	"profiles": (m) => m.profiles,

	"currencies": (m) => m.currencies,

	"analytics": (m) => m.analytics,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(TaxRecord) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in TaxRecord');
    }
    return propFunction as V? Function(TaxRecord);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory TaxRecord.fromJson(JsonMap json) =>
      TaxRecord(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	profileId: json['profileId'] as String?,
	transactionId: json['transactionId'] as String?,
	propertyId: json['propertyId'] as String?,
	contactId: json['contactId'] as String?,
	recordType: json['recordType'] as String?,
	profileData: json['profileData'] as dynamic,
	categoryData: json['categoryData'] as dynamic,
	lineItemData: json['lineItemData'] as dynamic,
	auditData: json['auditData'] as dynamic,
	ruleData: json['ruleData'] as dynamic,
	depreciationData: json['depreciationData'] as dynamic,
	form1099Data: json['form1099Data'] as dynamic,
	isActive: json['isActive'] as bool?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	profile: json['profile'] != null ? TaxRecord.fromJson(json['profile'] as JsonMap) : null,
	profiles: json['profiles'] != null ? createModels<TaxRecord>((json['profiles'] as List).cast<JsonMap>(), TaxRecord.fromJson) : null,
	currencies: json['currencies'] != null ? createModels<Currency>((json['currencies'] as List).cast<JsonMap>(), Currency.fromJson) : null,
	analytics: json['analytics'] != null ? createModels<Analytics>((json['analytics'] as List).cast<JsonMap>(), Analytics.fromJson) : null,
	$profilesCount: json['_count']?['profiles'] as int?,
	$currenciesCount: json['_count']?['currencies'] as int?,
	$analyticsCount: json['_count']?['analytics'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    TaxRecord copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? profileId,
		Value<String?>? transactionId,
		Value<String?>? propertyId,
		Value<String?>? contactId,
		Value<String?>? recordType,
		Value<dynamic>? profileData,
		Value<dynamic>? categoryData,
		Value<dynamic>? lineItemData,
		Value<dynamic>? auditData,
		Value<dynamic>? ruleData,
		Value<dynamic>? depreciationData,
		Value<dynamic>? form1099Data,
		Value<bool?>? isActive,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Organization?>? org,
		Value<TaxRecord?>? profile,
		Value<List<TaxRecord>?>? profiles,
		Value<List<Currency>?>? currencies,
		Value<List<Analytics>?>? analytics,
		int? $profilesCount,
		int? $currenciesCount,
		int? $analyticsCount,
        }) {
        return TaxRecord(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		profileId: profileId != null ? profileId.value : this.profileId,
		transactionId: transactionId != null ? transactionId.value : this.transactionId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		contactId: contactId != null ? contactId.value : this.contactId,
		recordType: recordType != null ? recordType.value : this.recordType,
		profileData: profileData != null ? profileData.value : this.profileData,
		categoryData: categoryData != null ? categoryData.value : this.categoryData,
		lineItemData: lineItemData != null ? lineItemData.value : this.lineItemData,
		auditData: auditData != null ? auditData.value : this.auditData,
		ruleData: ruleData != null ? ruleData.value : this.ruleData,
		depreciationData: depreciationData != null ? depreciationData.value : this.depreciationData,
		form1099Data: form1099Data != null ? form1099Data.value : this.form1099Data,
		isActive: isActive != null ? isActive.value : this.isActive,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		org: org != null ? org.value : this.org,
		profile: profile != null ? profile.value : this.profile,
		profiles: profiles != null ? profiles.value : this.profiles,
		currencies: currencies != null ? currencies.value : this.currencies,
		analytics: analytics != null ? analytics.value : this.analytics,
		$profilesCount: $profilesCount ?? this.$profilesCount,
		$currenciesCount: $currenciesCount ?? this.$currenciesCount,
		$analyticsCount: $analyticsCount ?? this.$analyticsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    TaxRecord copyWithInstanceValues(TaxRecord taxRecord) {
        return TaxRecord(
            id: taxRecord.id ?? id,
		orgId: taxRecord.orgId ?? orgId,
		profileId: taxRecord.profileId ?? profileId,
		transactionId: taxRecord.transactionId ?? transactionId,
		propertyId: taxRecord.propertyId ?? propertyId,
		contactId: taxRecord.contactId ?? contactId,
		recordType: taxRecord.recordType ?? recordType,
		profileData: taxRecord.profileData ?? profileData,
		categoryData: taxRecord.categoryData ?? categoryData,
		lineItemData: taxRecord.lineItemData ?? lineItemData,
		auditData: taxRecord.auditData ?? auditData,
		ruleData: taxRecord.ruleData ?? ruleData,
		depreciationData: taxRecord.depreciationData ?? depreciationData,
		form1099Data: taxRecord.form1099Data ?? form1099Data,
		isActive: taxRecord.isActive ?? isActive,
		createdBy: taxRecord.createdBy ?? createdBy,
		createdAt: taxRecord.createdAt ?? createdAt,
		updatedAt: taxRecord.updatedAt ?? updatedAt,
		deletedAt: taxRecord.deletedAt ?? deletedAt,
		org: taxRecord.org ?? org,
		profile: taxRecord.profile ?? profile,
		profiles: taxRecord.profiles ?? profiles,
		currencies: taxRecord.currencies ?? currencies,
		analytics: taxRecord.analytics ?? analytics,
		$profilesCount: taxRecord.$profilesCount ?? $profilesCount,
		$currenciesCount: taxRecord.$currenciesCount ?? $currenciesCount,
		$analyticsCount: taxRecord.$analyticsCount ?? $analyticsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    TaxRecord mergeWithInstanceValues(TaxRecord taxRecord) {
        return TaxRecord(
            id: taxRecord.$assignedFields.contains('id') ? taxRecord.id : id,
		orgId: taxRecord.$assignedFields.contains('orgId') ? taxRecord.orgId : orgId,
		profileId: taxRecord.$assignedFields.contains('profileId') ? taxRecord.profileId : profileId,
		transactionId: taxRecord.$assignedFields.contains('transactionId') ? taxRecord.transactionId : transactionId,
		propertyId: taxRecord.$assignedFields.contains('propertyId') ? taxRecord.propertyId : propertyId,
		contactId: taxRecord.$assignedFields.contains('contactId') ? taxRecord.contactId : contactId,
		recordType: taxRecord.$assignedFields.contains('recordType') ? taxRecord.recordType : recordType,
		profileData: taxRecord.$assignedFields.contains('profileData') ? taxRecord.profileData : profileData,
		categoryData: taxRecord.$assignedFields.contains('categoryData') ? taxRecord.categoryData : categoryData,
		lineItemData: taxRecord.$assignedFields.contains('lineItemData') ? taxRecord.lineItemData : lineItemData,
		auditData: taxRecord.$assignedFields.contains('auditData') ? taxRecord.auditData : auditData,
		ruleData: taxRecord.$assignedFields.contains('ruleData') ? taxRecord.ruleData : ruleData,
		depreciationData: taxRecord.$assignedFields.contains('depreciationData') ? taxRecord.depreciationData : depreciationData,
		form1099Data: taxRecord.$assignedFields.contains('form1099Data') ? taxRecord.form1099Data : form1099Data,
		isActive: taxRecord.$assignedFields.contains('isActive') ? taxRecord.isActive : isActive,
		createdBy: taxRecord.$assignedFields.contains('createdBy') ? taxRecord.createdBy : createdBy,
		createdAt: taxRecord.$assignedFields.contains('createdAt') ? taxRecord.createdAt : createdAt,
		updatedAt: taxRecord.$assignedFields.contains('updatedAt') ? taxRecord.updatedAt : updatedAt,
		deletedAt: taxRecord.$assignedFields.contains('deletedAt') ? taxRecord.deletedAt : deletedAt,
		org: taxRecord.$assignedFields.contains('org') ? taxRecord.org : org,
		profile: taxRecord.$assignedFields.contains('profile') ? taxRecord.profile : profile,
		profiles: (taxRecord.$assignedFields.contains('profiles') && taxRecord.profiles != null) ? mergeModelLists(profiles, taxRecord.profiles) : profiles,
		currencies: (taxRecord.$assignedFields.contains('currencies') && taxRecord.currencies != null) ? mergeModelLists(currencies, taxRecord.currencies) : currencies,
		analytics: (taxRecord.$assignedFields.contains('analytics') && taxRecord.analytics != null) ? mergeModelLists(analytics, taxRecord.analytics) : analytics,
		$profilesCount: taxRecord.$profilesCount ?? $profilesCount,
		$currenciesCount: taxRecord.$currenciesCount ?? $currenciesCount,
		$analyticsCount: taxRecord.$analyticsCount ?? $analyticsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    TaxRecord updateWithInstanceValues(TaxRecord taxRecord) {
        if (taxRecord.$assignedFields.contains('id')) { id = taxRecord.id; }
		if (taxRecord.$assignedFields.contains('orgId')) { orgId = taxRecord.orgId; }
		if (taxRecord.$assignedFields.contains('profileId')) { profileId = taxRecord.profileId; }
		if (taxRecord.$assignedFields.contains('transactionId')) { transactionId = taxRecord.transactionId; }
		if (taxRecord.$assignedFields.contains('propertyId')) { propertyId = taxRecord.propertyId; }
		if (taxRecord.$assignedFields.contains('contactId')) { contactId = taxRecord.contactId; }
		if (taxRecord.$assignedFields.contains('recordType')) { recordType = taxRecord.recordType; }
		if (taxRecord.$assignedFields.contains('profileData')) { profileData = taxRecord.profileData; }
		if (taxRecord.$assignedFields.contains('categoryData')) { categoryData = taxRecord.categoryData; }
		if (taxRecord.$assignedFields.contains('lineItemData')) { lineItemData = taxRecord.lineItemData; }
		if (taxRecord.$assignedFields.contains('auditData')) { auditData = taxRecord.auditData; }
		if (taxRecord.$assignedFields.contains('ruleData')) { ruleData = taxRecord.ruleData; }
		if (taxRecord.$assignedFields.contains('depreciationData')) { depreciationData = taxRecord.depreciationData; }
		if (taxRecord.$assignedFields.contains('form1099Data')) { form1099Data = taxRecord.form1099Data; }
		if (taxRecord.$assignedFields.contains('isActive')) { isActive = taxRecord.isActive; }
		if (taxRecord.$assignedFields.contains('createdBy')) { createdBy = taxRecord.createdBy; }
		if (taxRecord.$assignedFields.contains('createdAt')) { createdAt = taxRecord.createdAt; }
		if (taxRecord.$assignedFields.contains('updatedAt')) { updatedAt = taxRecord.updatedAt; }
		if (taxRecord.$assignedFields.contains('deletedAt')) { deletedAt = taxRecord.deletedAt; }
		if (taxRecord.$assignedFields.contains('org')) { org = taxRecord.org; }
		if (taxRecord.$assignedFields.contains('profile')) { profile = taxRecord.profile; }
		if (taxRecord.$assignedFields.contains('profiles') && taxRecord.profiles != null) { profiles = mergeModelLists(profiles, taxRecord.profiles); }
		if (taxRecord.$assignedFields.contains('currencies') && taxRecord.currencies != null) { currencies = mergeModelLists(currencies, taxRecord.currencies); }
		if (taxRecord.$assignedFields.contains('analytics') && taxRecord.analytics != null) { analytics = mergeModelLists(analytics, taxRecord.analytics); }
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
          ? {...?serializedTypes, 'TaxRecord'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(profileId != null) 'profileId': profileId,
	if(transactionId != null) 'transactionId': transactionId,
	if(propertyId != null) 'propertyId': propertyId,
	if(contactId != null) 'contactId': contactId,
	if(recordType != null) 'recordType': recordType,
	if(profileData != null) 'profileData': profileData,
	if(categoryData != null) 'categoryData': categoryData,
	if(lineItemData != null) 'lineItemData': lineItemData,
	if(auditData != null) 'auditData': auditData,
	if(ruleData != null) 'ruleData': ruleData,
	if(depreciationData != null) 'depreciationData': depreciationData,
	if(form1099Data != null) 'form1099Data': form1099Data,
	if(isActive != null) 'isActive': isActive,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(profile != null && (!preventCircularSerialization || !serializedModels.contains('TaxRecord'))) 'profile': profile?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(profiles != null && (!preventCircularSerialization || !serializedModels.contains('TaxRecord'))) 'profiles': profiles?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(currencies != null && (!preventCircularSerialization || !serializedModels.contains('Currency'))) 'currencies': currencies?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(analytics != null && (!preventCircularSerialization || !serializedModels.contains('Analytics'))) 'analytics': analytics?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($profilesCount != null || $currenciesCount != null || $analyticsCount != null) '_count': { 
		if ($profilesCount != null) 'profiles': $profilesCount, 
		if ($currenciesCount != null) 'currencies': $currenciesCount, 
		if ($analyticsCount != null) 'analytics': $analyticsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is TaxRecord &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    