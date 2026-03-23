
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'booking_source.dart';
import 'commission_rule.dart';
import 'report.dart';
import 'reservation.dart';


class ReferenceSource implements PrismaModel<String, ReferenceSource> , Id<String> {
    @override
String? id;
	String? name;
	String? logo;
	String? apiKey;
	String? apiSecret;
	String? baseUrl;
	bool? isActive;
	double? commission;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	BookingSource? source;
	List<CommissionRule>? commissionRule;
	List<Report>? report;
	List<Reservation>? reservations;
	int? $commissionRuleCount;
	int? $reportCount;
	int? $reservationsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    ReferenceSource({ this.id,
	 this.name,
	 this.logo,
	 this.apiKey,
	 this.apiSecret,
	 this.baseUrl,
	 this.isActive = true,
	 this.commission,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.source,
	 this.commissionRule,
	 this.report,
	 this.reservations,
	this.$commissionRuleCount,
	this.$reportCount,
	this.$reservationsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<ReferenceSource, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"name": (m) => m.name,

	"logo": (m) => m.logo,

	"apiKey": (m) => m.apiKey,

	"apiSecret": (m) => m.apiSecret,

	"baseUrl": (m) => m.baseUrl,

	"isActive": (m) => m.isActive,

	"commission": (m) => m.commission,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"source": (m) => m.source,

	"commissionRule": (m) => m.commissionRule,

	"report": (m) => m.report,

	"reservations": (m) => m.reservations,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(ReferenceSource) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in ReferenceSource');
    }
    return propFunction as V? Function(ReferenceSource);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory ReferenceSource.fromJson(JsonMap json) =>
      ReferenceSource(
        id: json['id'] as String?,
	name: json['name'] as String?,
	logo: json['logo'] as String?,
	apiKey: json['apiKey'] as String?,
	apiSecret: json['apiSecret'] as String?,
	baseUrl: json['baseUrl'] as String?,
	isActive: json['isActive'] as bool?,
	commission: json['commission']?.toDouble(),
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	source: json['source'] != null ? BookingSource.fromJson(json['source']) : null,
	commissionRule: json['commissionRule'] != null ? createModels<CommissionRule>((json['commissionRule'] as List).cast<JsonMap>(), CommissionRule.fromJson) : null,
	report: json['report'] != null ? createModels<Report>((json['report'] as List).cast<JsonMap>(), Report.fromJson) : null,
	reservations: json['reservations'] != null ? createModels<Reservation>((json['reservations'] as List).cast<JsonMap>(), Reservation.fromJson) : null,
	$commissionRuleCount: json['_count']?['commissionRule'] as int?,
	$reportCount: json['_count']?['report'] as int?,
	$reservationsCount: json['_count']?['reservations'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    ReferenceSource copyWith({
        Value<String?>? id,
		Value<String?>? name,
		Value<String?>? logo,
		Value<String?>? apiKey,
		Value<String?>? apiSecret,
		Value<String?>? baseUrl,
		Value<bool?>? isActive,
		Value<double?>? commission,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<BookingSource?>? source,
		Value<List<CommissionRule>?>? commissionRule,
		Value<List<Report>?>? report,
		Value<List<Reservation>?>? reservations,
		int? $commissionRuleCount,
		int? $reportCount,
		int? $reservationsCount,
        }) {
        return ReferenceSource(
            id: id != null ? id.value : this.id,
		name: name != null ? name.value : this.name,
		logo: logo != null ? logo.value : this.logo,
		apiKey: apiKey != null ? apiKey.value : this.apiKey,
		apiSecret: apiSecret != null ? apiSecret.value : this.apiSecret,
		baseUrl: baseUrl != null ? baseUrl.value : this.baseUrl,
		isActive: isActive != null ? isActive.value : this.isActive,
		commission: commission != null ? commission.value : this.commission,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		source: source != null ? source.value : this.source,
		commissionRule: commissionRule != null ? commissionRule.value : this.commissionRule,
		report: report != null ? report.value : this.report,
		reservations: reservations != null ? reservations.value : this.reservations,
		$commissionRuleCount: $commissionRuleCount ?? this.$commissionRuleCount,
		$reportCount: $reportCount ?? this.$reportCount,
		$reservationsCount: $reservationsCount ?? this.$reservationsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    ReferenceSource copyWithInstanceValues(ReferenceSource referenceSource) {
        return ReferenceSource(
            id: referenceSource.id ?? id,
		name: referenceSource.name ?? name,
		logo: referenceSource.logo ?? logo,
		apiKey: referenceSource.apiKey ?? apiKey,
		apiSecret: referenceSource.apiSecret ?? apiSecret,
		baseUrl: referenceSource.baseUrl ?? baseUrl,
		isActive: referenceSource.isActive ?? isActive,
		commission: referenceSource.commission ?? commission,
		createdAt: referenceSource.createdAt ?? createdAt,
		updatedAt: referenceSource.updatedAt ?? updatedAt,
		deletedAt: referenceSource.deletedAt ?? deletedAt,
		source: referenceSource.source ?? source,
		commissionRule: referenceSource.commissionRule ?? commissionRule,
		report: referenceSource.report ?? report,
		reservations: referenceSource.reservations ?? reservations,
		$commissionRuleCount: referenceSource.$commissionRuleCount ?? $commissionRuleCount,
		$reportCount: referenceSource.$reportCount ?? $reportCount,
		$reservationsCount: referenceSource.$reservationsCount ?? $reservationsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    ReferenceSource mergeWithInstanceValues(ReferenceSource referenceSource) {
        return ReferenceSource(
            id: referenceSource.$assignedFields.contains('id') ? referenceSource.id : id,
		name: referenceSource.$assignedFields.contains('name') ? referenceSource.name : name,
		logo: referenceSource.$assignedFields.contains('logo') ? referenceSource.logo : logo,
		apiKey: referenceSource.$assignedFields.contains('apiKey') ? referenceSource.apiKey : apiKey,
		apiSecret: referenceSource.$assignedFields.contains('apiSecret') ? referenceSource.apiSecret : apiSecret,
		baseUrl: referenceSource.$assignedFields.contains('baseUrl') ? referenceSource.baseUrl : baseUrl,
		isActive: referenceSource.$assignedFields.contains('isActive') ? referenceSource.isActive : isActive,
		commission: referenceSource.$assignedFields.contains('commission') ? referenceSource.commission : commission,
		createdAt: referenceSource.$assignedFields.contains('createdAt') ? referenceSource.createdAt : createdAt,
		updatedAt: referenceSource.$assignedFields.contains('updatedAt') ? referenceSource.updatedAt : updatedAt,
		deletedAt: referenceSource.$assignedFields.contains('deletedAt') ? referenceSource.deletedAt : deletedAt,
		source: referenceSource.$assignedFields.contains('source') ? referenceSource.source : source,
		commissionRule: (referenceSource.$assignedFields.contains('commissionRule') && referenceSource.commissionRule != null) ? mergeModelLists(commissionRule, referenceSource.commissionRule) : commissionRule,
		report: (referenceSource.$assignedFields.contains('report') && referenceSource.report != null) ? mergeModelLists(report, referenceSource.report) : report,
		reservations: (referenceSource.$assignedFields.contains('reservations') && referenceSource.reservations != null) ? mergeModelLists(reservations, referenceSource.reservations) : reservations,
		$commissionRuleCount: referenceSource.$commissionRuleCount ?? $commissionRuleCount,
		$reportCount: referenceSource.$reportCount ?? $reportCount,
		$reservationsCount: referenceSource.$reservationsCount ?? $reservationsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    ReferenceSource updateWithInstanceValues(ReferenceSource referenceSource) {
        if (referenceSource.$assignedFields.contains('id')) { id = referenceSource.id; }
		if (referenceSource.$assignedFields.contains('name')) { name = referenceSource.name; }
		if (referenceSource.$assignedFields.contains('logo')) { logo = referenceSource.logo; }
		if (referenceSource.$assignedFields.contains('apiKey')) { apiKey = referenceSource.apiKey; }
		if (referenceSource.$assignedFields.contains('apiSecret')) { apiSecret = referenceSource.apiSecret; }
		if (referenceSource.$assignedFields.contains('baseUrl')) { baseUrl = referenceSource.baseUrl; }
		if (referenceSource.$assignedFields.contains('isActive')) { isActive = referenceSource.isActive; }
		if (referenceSource.$assignedFields.contains('commission')) { commission = referenceSource.commission; }
		if (referenceSource.$assignedFields.contains('createdAt')) { createdAt = referenceSource.createdAt; }
		if (referenceSource.$assignedFields.contains('updatedAt')) { updatedAt = referenceSource.updatedAt; }
		if (referenceSource.$assignedFields.contains('deletedAt')) { deletedAt = referenceSource.deletedAt; }
		if (referenceSource.$assignedFields.contains('source')) { source = referenceSource.source; }
		if (referenceSource.$assignedFields.contains('commissionRule') && referenceSource.commissionRule != null) { commissionRule = mergeModelLists(commissionRule, referenceSource.commissionRule); }
		if (referenceSource.$assignedFields.contains('report') && referenceSource.report != null) { report = mergeModelLists(report, referenceSource.report); }
		if (referenceSource.$assignedFields.contains('reservations') && referenceSource.reservations != null) { reservations = mergeModelLists(reservations, referenceSource.reservations); }
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
          ? {...?serializedTypes, 'ReferenceSource'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(name != null) 'name': name,
	if(logo != null) 'logo': logo,
	if(apiKey != null) 'apiKey': apiKey,
	if(apiSecret != null) 'apiSecret': apiSecret,
	if(baseUrl != null) 'baseUrl': baseUrl,
	if(isActive != null) 'isActive': isActive,
	if(commission != null) 'commission': commission,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(source != null) 'source': source?.toJson(),
	if(commissionRule != null && (!preventCircularSerialization || !serializedModels.contains('CommissionRule'))) 'commissionRule': commissionRule?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(report != null && (!preventCircularSerialization || !serializedModels.contains('Report'))) 'report': report?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(reservations != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'reservations': reservations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($commissionRuleCount != null || $reportCount != null || $reservationsCount != null) '_count': { 
		if ($commissionRuleCount != null) 'commissionRule': $commissionRuleCount, 
		if ($reportCount != null) 'report': $reportCount, 
		if ($reservationsCount != null) 'reservations': $reservationsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is ReferenceSource &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    