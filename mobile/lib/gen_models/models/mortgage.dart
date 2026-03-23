
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'mortgage_status.dart';
import 'property.dart';


class Mortgage implements PrismaModel<String, Mortgage> , Id<String> {
    @override
String? id;
	String? propertyId;
	String? lender;
	double? principal;
	double? interestRate;
	DateTime? startDate;
	DateTime? endDate;
	MortgageStatus? status;
	String? notes;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Property? Property;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Mortgage({ this.id,
	 this.propertyId,
	 this.lender,
	 this.principal,
	 this.interestRate,
	 this.startDate,
	 this.endDate,
	 this.status = MortgageStatus.ACTIVE,
	 this.notes,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.Property,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Mortgage, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"propertyId": (m) => m.propertyId,

	"lender": (m) => m.lender,

	"principal": (m) => m.principal,

	"interestRate": (m) => m.interestRate,

	"startDate": (m) => m.startDate,

	"endDate": (m) => m.endDate,

	"status": (m) => m.status,

	"notes": (m) => m.notes,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"Property": (m) => m.Property,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Mortgage) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Mortgage');
    }
    return propFunction as V? Function(Mortgage);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Mortgage.fromJson(JsonMap json) =>
      Mortgage(
        id: json['id'] as String?,
	propertyId: json['propertyId'] as String?,
	lender: json['lender'] as String?,
	principal: json['principal']?.toDouble(),
	interestRate: json['interestRate']?.toDouble(),
	startDate: json['startDate'] != null ? DateTime.parse(json['startDate']) : null,
	endDate: json['endDate'] != null ? DateTime.parse(json['endDate']) : null,
	status: json['status'] != null ? MortgageStatus.fromJson(json['status']) : null,
	notes: json['notes'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	Property: json['Property'] != null ? Property.fromJson(json['Property'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Mortgage copyWith({
        Value<String?>? id,
		Value<String?>? propertyId,
		Value<String?>? lender,
		Value<double?>? principal,
		Value<double?>? interestRate,
		Value<DateTime?>? startDate,
		Value<DateTime?>? endDate,
		Value<MortgageStatus?>? status,
		Value<String?>? notes,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Property?>? Property,
        }) {
        return Mortgage(
            id: id != null ? id.value : this.id,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		lender: lender != null ? lender.value : this.lender,
		principal: principal != null ? principal.value : this.principal,
		interestRate: interestRate != null ? interestRate.value : this.interestRate,
		startDate: startDate != null ? startDate.value : this.startDate,
		endDate: endDate != null ? endDate.value : this.endDate,
		status: status != null ? status.value : this.status,
		notes: notes != null ? notes.value : this.notes,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		Property: Property != null ? Property.value : this.Property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Mortgage copyWithInstanceValues(Mortgage mortgage) {
        return Mortgage(
            id: mortgage.id ?? id,
		propertyId: mortgage.propertyId ?? propertyId,
		lender: mortgage.lender ?? lender,
		principal: mortgage.principal ?? principal,
		interestRate: mortgage.interestRate ?? interestRate,
		startDate: mortgage.startDate ?? startDate,
		endDate: mortgage.endDate ?? endDate,
		status: mortgage.status ?? status,
		notes: mortgage.notes ?? notes,
		createdAt: mortgage.createdAt ?? createdAt,
		updatedAt: mortgage.updatedAt ?? updatedAt,
		deletedAt: mortgage.deletedAt ?? deletedAt,
		Property: mortgage.Property ?? Property
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Mortgage mergeWithInstanceValues(Mortgage mortgage) {
        return Mortgage(
            id: mortgage.$assignedFields.contains('id') ? mortgage.id : id,
		propertyId: mortgage.$assignedFields.contains('propertyId') ? mortgage.propertyId : propertyId,
		lender: mortgage.$assignedFields.contains('lender') ? mortgage.lender : lender,
		principal: mortgage.$assignedFields.contains('principal') ? mortgage.principal : principal,
		interestRate: mortgage.$assignedFields.contains('interestRate') ? mortgage.interestRate : interestRate,
		startDate: mortgage.$assignedFields.contains('startDate') ? mortgage.startDate : startDate,
		endDate: mortgage.$assignedFields.contains('endDate') ? mortgage.endDate : endDate,
		status: mortgage.$assignedFields.contains('status') ? mortgage.status : status,
		notes: mortgage.$assignedFields.contains('notes') ? mortgage.notes : notes,
		createdAt: mortgage.$assignedFields.contains('createdAt') ? mortgage.createdAt : createdAt,
		updatedAt: mortgage.$assignedFields.contains('updatedAt') ? mortgage.updatedAt : updatedAt,
		deletedAt: mortgage.$assignedFields.contains('deletedAt') ? mortgage.deletedAt : deletedAt,
		Property: mortgage.$assignedFields.contains('Property') ? mortgage.Property : Property
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Mortgage updateWithInstanceValues(Mortgage mortgage) {
        if (mortgage.$assignedFields.contains('id')) { id = mortgage.id; }
		if (mortgage.$assignedFields.contains('propertyId')) { propertyId = mortgage.propertyId; }
		if (mortgage.$assignedFields.contains('lender')) { lender = mortgage.lender; }
		if (mortgage.$assignedFields.contains('principal')) { principal = mortgage.principal; }
		if (mortgage.$assignedFields.contains('interestRate')) { interestRate = mortgage.interestRate; }
		if (mortgage.$assignedFields.contains('startDate')) { startDate = mortgage.startDate; }
		if (mortgage.$assignedFields.contains('endDate')) { endDate = mortgage.endDate; }
		if (mortgage.$assignedFields.contains('status')) { status = mortgage.status; }
		if (mortgage.$assignedFields.contains('notes')) { notes = mortgage.notes; }
		if (mortgage.$assignedFields.contains('createdAt')) { createdAt = mortgage.createdAt; }
		if (mortgage.$assignedFields.contains('updatedAt')) { updatedAt = mortgage.updatedAt; }
		if (mortgage.$assignedFields.contains('deletedAt')) { deletedAt = mortgage.deletedAt; }
		if (mortgage.$assignedFields.contains('Property')) { Property = mortgage.Property; }
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
          ? {...?serializedTypes, 'Mortgage'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(propertyId != null) 'propertyId': propertyId,
	if(lender != null) 'lender': lender,
	if(principal != null) 'principal': principal,
	if(interestRate != null) 'interestRate': interestRate,
	if(startDate != null) 'startDate': startDate?.toIso8601String(),
	if(endDate != null) 'endDate': endDate?.toIso8601String(),
	if(status != null) 'status': status?.toJson(),
	if(notes != null) 'notes': notes,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(Property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'Property': Property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Mortgage &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    