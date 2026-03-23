
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'social_impact_type.dart';
import 'organization.dart';
import 'social_impact_record.dart';


class SocialImpactCounter implements PrismaModel<String, SocialImpactCounter> , Id<String> {
    @override
String? id;
	String? orgId;
	SocialImpactType? impactType;
	String? currency;
	String? partnerName;
	String? partnerUrl;
	String? partnerOrgId;
	String? campaignTag;
	bool? isPublic;
	int? displayGoal;
	DateTime? createdAt;
	DateTime? updatedAt;
	Organization? org;
	List<SocialImpactRecord>? records;
	int? $recordsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    SocialImpactCounter({ this.id,
	 this.orgId,
	 this.impactType,
	 this.currency = "USD",
	 this.partnerName,
	 this.partnerUrl,
	 this.partnerOrgId,
	 this.campaignTag,
	 this.isPublic = true,
	 this.displayGoal,
	 this.createdAt,
	 this.updatedAt,
	 this.org,
	 this.records,
	this.$recordsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<SocialImpactCounter, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"impactType": (m) => m.impactType,

	"currency": (m) => m.currency,

	"partnerName": (m) => m.partnerName,

	"partnerUrl": (m) => m.partnerUrl,

	"partnerOrgId": (m) => m.partnerOrgId,

	"campaignTag": (m) => m.campaignTag,

	"isPublic": (m) => m.isPublic,

	"displayGoal": (m) => m.displayGoal,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"org": (m) => m.org,

	"records": (m) => m.records,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(SocialImpactCounter) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in SocialImpactCounter');
    }
    return propFunction as V? Function(SocialImpactCounter);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory SocialImpactCounter.fromJson(JsonMap json) =>
      SocialImpactCounter(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	impactType: json['impactType'] != null ? SocialImpactType.fromJson(json['impactType']) : null,
	currency: json['currency'] as String?,
	partnerName: json['partnerName'] as String?,
	partnerUrl: json['partnerUrl'] as String?,
	partnerOrgId: json['partnerOrgId'] as String?,
	campaignTag: json['campaignTag'] as String?,
	isPublic: json['isPublic'] as bool?,
	displayGoal: int.tryParse(json['displayGoal'].toString()),
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	records: json['records'] != null ? createModels<SocialImpactRecord>((json['records'] as List).cast<JsonMap>(), SocialImpactRecord.fromJson) : null,
	$recordsCount: json['_count']?['records'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    SocialImpactCounter copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<SocialImpactType?>? impactType,
		Value<String?>? currency,
		Value<String?>? partnerName,
		Value<String?>? partnerUrl,
		Value<String?>? partnerOrgId,
		Value<String?>? campaignTag,
		Value<bool?>? isPublic,
		Value<int?>? displayGoal,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<Organization?>? org,
		Value<List<SocialImpactRecord>?>? records,
		int? $recordsCount,
        }) {
        return SocialImpactCounter(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		impactType: impactType != null ? impactType.value : this.impactType,
		currency: currency != null ? currency.value : this.currency,
		partnerName: partnerName != null ? partnerName.value : this.partnerName,
		partnerUrl: partnerUrl != null ? partnerUrl.value : this.partnerUrl,
		partnerOrgId: partnerOrgId != null ? partnerOrgId.value : this.partnerOrgId,
		campaignTag: campaignTag != null ? campaignTag.value : this.campaignTag,
		isPublic: isPublic != null ? isPublic.value : this.isPublic,
		displayGoal: displayGoal != null ? displayGoal.value : this.displayGoal,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		org: org != null ? org.value : this.org,
		records: records != null ? records.value : this.records,
		$recordsCount: $recordsCount ?? this.$recordsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    SocialImpactCounter copyWithInstanceValues(SocialImpactCounter socialImpactCounter) {
        return SocialImpactCounter(
            id: socialImpactCounter.id ?? id,
		orgId: socialImpactCounter.orgId ?? orgId,
		impactType: socialImpactCounter.impactType ?? impactType,
		currency: socialImpactCounter.currency ?? currency,
		partnerName: socialImpactCounter.partnerName ?? partnerName,
		partnerUrl: socialImpactCounter.partnerUrl ?? partnerUrl,
		partnerOrgId: socialImpactCounter.partnerOrgId ?? partnerOrgId,
		campaignTag: socialImpactCounter.campaignTag ?? campaignTag,
		isPublic: socialImpactCounter.isPublic ?? isPublic,
		displayGoal: socialImpactCounter.displayGoal ?? displayGoal,
		createdAt: socialImpactCounter.createdAt ?? createdAt,
		updatedAt: socialImpactCounter.updatedAt ?? updatedAt,
		org: socialImpactCounter.org ?? org,
		records: socialImpactCounter.records ?? records,
		$recordsCount: socialImpactCounter.$recordsCount ?? $recordsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    SocialImpactCounter mergeWithInstanceValues(SocialImpactCounter socialImpactCounter) {
        return SocialImpactCounter(
            id: socialImpactCounter.$assignedFields.contains('id') ? socialImpactCounter.id : id,
		orgId: socialImpactCounter.$assignedFields.contains('orgId') ? socialImpactCounter.orgId : orgId,
		impactType: socialImpactCounter.$assignedFields.contains('impactType') ? socialImpactCounter.impactType : impactType,
		currency: socialImpactCounter.$assignedFields.contains('currency') ? socialImpactCounter.currency : currency,
		partnerName: socialImpactCounter.$assignedFields.contains('partnerName') ? socialImpactCounter.partnerName : partnerName,
		partnerUrl: socialImpactCounter.$assignedFields.contains('partnerUrl') ? socialImpactCounter.partnerUrl : partnerUrl,
		partnerOrgId: socialImpactCounter.$assignedFields.contains('partnerOrgId') ? socialImpactCounter.partnerOrgId : partnerOrgId,
		campaignTag: socialImpactCounter.$assignedFields.contains('campaignTag') ? socialImpactCounter.campaignTag : campaignTag,
		isPublic: socialImpactCounter.$assignedFields.contains('isPublic') ? socialImpactCounter.isPublic : isPublic,
		displayGoal: socialImpactCounter.$assignedFields.contains('displayGoal') ? socialImpactCounter.displayGoal : displayGoal,
		createdAt: socialImpactCounter.$assignedFields.contains('createdAt') ? socialImpactCounter.createdAt : createdAt,
		updatedAt: socialImpactCounter.$assignedFields.contains('updatedAt') ? socialImpactCounter.updatedAt : updatedAt,
		org: socialImpactCounter.$assignedFields.contains('org') ? socialImpactCounter.org : org,
		records: (socialImpactCounter.$assignedFields.contains('records') && socialImpactCounter.records != null) ? mergeModelLists(records, socialImpactCounter.records) : records,
		$recordsCount: socialImpactCounter.$recordsCount ?? $recordsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    SocialImpactCounter updateWithInstanceValues(SocialImpactCounter socialImpactCounter) {
        if (socialImpactCounter.$assignedFields.contains('id')) { id = socialImpactCounter.id; }
		if (socialImpactCounter.$assignedFields.contains('orgId')) { orgId = socialImpactCounter.orgId; }
		if (socialImpactCounter.$assignedFields.contains('impactType')) { impactType = socialImpactCounter.impactType; }
		if (socialImpactCounter.$assignedFields.contains('currency')) { currency = socialImpactCounter.currency; }
		if (socialImpactCounter.$assignedFields.contains('partnerName')) { partnerName = socialImpactCounter.partnerName; }
		if (socialImpactCounter.$assignedFields.contains('partnerUrl')) { partnerUrl = socialImpactCounter.partnerUrl; }
		if (socialImpactCounter.$assignedFields.contains('partnerOrgId')) { partnerOrgId = socialImpactCounter.partnerOrgId; }
		if (socialImpactCounter.$assignedFields.contains('campaignTag')) { campaignTag = socialImpactCounter.campaignTag; }
		if (socialImpactCounter.$assignedFields.contains('isPublic')) { isPublic = socialImpactCounter.isPublic; }
		if (socialImpactCounter.$assignedFields.contains('displayGoal')) { displayGoal = socialImpactCounter.displayGoal; }
		if (socialImpactCounter.$assignedFields.contains('createdAt')) { createdAt = socialImpactCounter.createdAt; }
		if (socialImpactCounter.$assignedFields.contains('updatedAt')) { updatedAt = socialImpactCounter.updatedAt; }
		if (socialImpactCounter.$assignedFields.contains('org')) { org = socialImpactCounter.org; }
		if (socialImpactCounter.$assignedFields.contains('records') && socialImpactCounter.records != null) { records = mergeModelLists(records, socialImpactCounter.records); }
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
          ? {...?serializedTypes, 'SocialImpactCounter'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(impactType != null) 'impactType': impactType?.toJson(),
	if(currency != null) 'currency': currency,
	if(partnerName != null) 'partnerName': partnerName,
	if(partnerUrl != null) 'partnerUrl': partnerUrl,
	if(partnerOrgId != null) 'partnerOrgId': partnerOrgId,
	if(campaignTag != null) 'campaignTag': campaignTag,
	if(isPublic != null) 'isPublic': isPublic,
	if(displayGoal != null) 'displayGoal': displayGoal,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(records != null && (!preventCircularSerialization || !serializedModels.contains('SocialImpactRecord'))) 'records': records?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($recordsCount != null) '_count': { 
		if ($recordsCount != null) 'records': $recordsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is SocialImpactCounter &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    