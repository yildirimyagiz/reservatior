
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'payout_status_u_s_a.dart';
import 'commission_type_u_s.dart';
import 'payment_method_u_s.dart';
import 'commission.dart';
import 'deal.dart';
import 'organization.dart';
import 'contact.dart';


class Payout implements PrismaModel<String, Payout> , Id<String> {
    @override
String? id;
	String? orgId;
	String? dealId;
	String? commissionId;
	String? recipientId;
	String? processorId;
	PayoutStatusUSA? payoutStatus;
	CommissionTypeUS? payoutType;
	double? amount;
	double? grossAmount;
	double? netAmount;
	double? taxWithheld;
	double? fees;
	PaymentMethodUS? paymentMethod;
	DateTime? scheduledDate;
	DateTime? processedDate;
	DateTime? completedDate;
	String? referenceNumber;
	String? trackingNumber;
	dynamic bankAccount;
	String? checkNumber;
	String? wireReference;
	String? achRouting;
	DateTime? escrowReleaseDate;
	String? holdReason;
	String? failureReason;
	int? retryCount;
	int? maxRetries;
	DateTime? nextRetryDate;
	String? priority;
	bool? approvalRequired;
	String? approvedBy;
	DateTime? approvedAt;
	String? notes;
	bool? taxFormGenerated;
	bool? taxFormSent;
	bool? yearEndReport;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Commission? commission;
	Deal? deal;
	Organization? org;
	Contact? processor;
	Contact? recipient;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Payout({ this.id,
	 this.orgId,
	 this.dealId,
	 this.commissionId,
	 this.recipientId,
	 this.processorId,
	 this.payoutStatus = PayoutStatusUSA.PENDING,
	 this.payoutType,
	 this.amount,
	 this.grossAmount,
	 this.netAmount,
	 this.taxWithheld = 0,
	 this.fees = 0,
	 this.paymentMethod,
	 this.scheduledDate,
	 this.processedDate,
	 this.completedDate,
	 this.referenceNumber,
	 this.trackingNumber,
	required this.bankAccount,
	 this.checkNumber,
	 this.wireReference,
	 this.achRouting,
	 this.escrowReleaseDate,
	 this.holdReason,
	 this.failureReason,
	 this.retryCount = 0,
	 this.maxRetries = 3,
	 this.nextRetryDate,
	 this.priority = "NORMAL",
	 this.approvalRequired = false,
	 this.approvedBy,
	 this.approvedAt,
	 this.notes,
	 this.taxFormGenerated = false,
	 this.taxFormSent = false,
	 this.yearEndReport = false,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.commission,
	 this.deal,
	 this.org,
	 this.processor,
	 this.recipient,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Payout, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"dealId": (m) => m.dealId,

	"commissionId": (m) => m.commissionId,

	"recipientId": (m) => m.recipientId,

	"processorId": (m) => m.processorId,

	"payoutStatus": (m) => m.payoutStatus,

	"payoutType": (m) => m.payoutType,

	"amount": (m) => m.amount,

	"grossAmount": (m) => m.grossAmount,

	"netAmount": (m) => m.netAmount,

	"taxWithheld": (m) => m.taxWithheld,

	"fees": (m) => m.fees,

	"paymentMethod": (m) => m.paymentMethod,

	"scheduledDate": (m) => m.scheduledDate,

	"processedDate": (m) => m.processedDate,

	"completedDate": (m) => m.completedDate,

	"referenceNumber": (m) => m.referenceNumber,

	"trackingNumber": (m) => m.trackingNumber,

	"bankAccount": (m) => m.bankAccount,

	"checkNumber": (m) => m.checkNumber,

	"wireReference": (m) => m.wireReference,

	"achRouting": (m) => m.achRouting,

	"escrowReleaseDate": (m) => m.escrowReleaseDate,

	"holdReason": (m) => m.holdReason,

	"failureReason": (m) => m.failureReason,

	"retryCount": (m) => m.retryCount,

	"maxRetries": (m) => m.maxRetries,

	"nextRetryDate": (m) => m.nextRetryDate,

	"priority": (m) => m.priority,

	"approvalRequired": (m) => m.approvalRequired,

	"approvedBy": (m) => m.approvedBy,

	"approvedAt": (m) => m.approvedAt,

	"notes": (m) => m.notes,

	"taxFormGenerated": (m) => m.taxFormGenerated,

	"taxFormSent": (m) => m.taxFormSent,

	"yearEndReport": (m) => m.yearEndReport,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"commission": (m) => m.commission,

	"deal": (m) => m.deal,

	"org": (m) => m.org,

	"processor": (m) => m.processor,

	"recipient": (m) => m.recipient,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Payout) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Payout');
    }
    return propFunction as V? Function(Payout);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Payout.fromJson(JsonMap json) =>
      Payout(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	dealId: json['dealId'] as String?,
	commissionId: json['commissionId'] as String?,
	recipientId: json['recipientId'] as String?,
	processorId: json['processorId'] as String?,
	payoutStatus: json['payoutStatus'] != null ? PayoutStatusUSA.fromJson(json['payoutStatus']) : null,
	payoutType: json['payoutType'] != null ? CommissionTypeUS.fromJson(json['payoutType']) : null,
	amount: json['amount'] as double?,
	grossAmount: json['grossAmount'] as double?,
	netAmount: json['netAmount'] as double?,
	taxWithheld: json['taxWithheld'] as double?,
	fees: json['fees'] as double?,
	paymentMethod: json['paymentMethod'] != null ? PaymentMethodUS.fromJson(json['paymentMethod']) : null,
	scheduledDate: json['scheduledDate'] != null ? DateTime.parse(json['scheduledDate']) : null,
	processedDate: json['processedDate'] != null ? DateTime.parse(json['processedDate']) : null,
	completedDate: json['completedDate'] != null ? DateTime.parse(json['completedDate']) : null,
	referenceNumber: json['referenceNumber'] as String?,
	trackingNumber: json['trackingNumber'] as String?,
	bankAccount: json['bankAccount'] as dynamic,
	checkNumber: json['checkNumber'] as String?,
	wireReference: json['wireReference'] as String?,
	achRouting: json['achRouting'] as String?,
	escrowReleaseDate: json['escrowReleaseDate'] != null ? DateTime.parse(json['escrowReleaseDate']) : null,
	holdReason: json['holdReason'] as String?,
	failureReason: json['failureReason'] as String?,
	retryCount: int.tryParse(json['retryCount'].toString()),
	maxRetries: int.tryParse(json['maxRetries'].toString()),
	nextRetryDate: json['nextRetryDate'] != null ? DateTime.parse(json['nextRetryDate']) : null,
	priority: json['priority'] as String?,
	approvalRequired: json['approvalRequired'] as bool?,
	approvedBy: json['approvedBy'] as String?,
	approvedAt: json['approvedAt'] != null ? DateTime.parse(json['approvedAt']) : null,
	notes: json['notes'] as String?,
	taxFormGenerated: json['taxFormGenerated'] as bool?,
	taxFormSent: json['taxFormSent'] as bool?,
	yearEndReport: json['yearEndReport'] as bool?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	commission: json['commission'] != null ? Commission.fromJson(json['commission'] as JsonMap) : null,
	deal: json['deal'] != null ? Deal.fromJson(json['deal'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	processor: json['processor'] != null ? Contact.fromJson(json['processor'] as JsonMap) : null,
	recipient: json['recipient'] != null ? Contact.fromJson(json['recipient'] as JsonMap) : null,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Payout copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? dealId,
		Value<String?>? commissionId,
		Value<String?>? recipientId,
		Value<String?>? processorId,
		Value<PayoutStatusUSA?>? payoutStatus,
		Value<CommissionTypeUS?>? payoutType,
		Value<double?>? amount,
		Value<double?>? grossAmount,
		Value<double?>? netAmount,
		Value<double?>? taxWithheld,
		Value<double?>? fees,
		Value<PaymentMethodUS?>? paymentMethod,
		Value<DateTime?>? scheduledDate,
		Value<DateTime?>? processedDate,
		Value<DateTime?>? completedDate,
		Value<String?>? referenceNumber,
		Value<String?>? trackingNumber,
		Value<dynamic>? bankAccount,
		Value<String?>? checkNumber,
		Value<String?>? wireReference,
		Value<String?>? achRouting,
		Value<DateTime?>? escrowReleaseDate,
		Value<String?>? holdReason,
		Value<String?>? failureReason,
		Value<int?>? retryCount,
		Value<int?>? maxRetries,
		Value<DateTime?>? nextRetryDate,
		Value<String?>? priority,
		Value<bool?>? approvalRequired,
		Value<String?>? approvedBy,
		Value<DateTime?>? approvedAt,
		Value<String?>? notes,
		Value<bool?>? taxFormGenerated,
		Value<bool?>? taxFormSent,
		Value<bool?>? yearEndReport,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Commission?>? commission,
		Value<Deal?>? deal,
		Value<Organization?>? org,
		Value<Contact?>? processor,
		Value<Contact?>? recipient,
        }) {
        return Payout(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		dealId: dealId != null ? dealId.value : this.dealId,
		commissionId: commissionId != null ? commissionId.value : this.commissionId,
		recipientId: recipientId != null ? recipientId.value : this.recipientId,
		processorId: processorId != null ? processorId.value : this.processorId,
		payoutStatus: payoutStatus != null ? payoutStatus.value : this.payoutStatus,
		payoutType: payoutType != null ? payoutType.value : this.payoutType,
		amount: amount != null ? amount.value : this.amount,
		grossAmount: grossAmount != null ? grossAmount.value : this.grossAmount,
		netAmount: netAmount != null ? netAmount.value : this.netAmount,
		taxWithheld: taxWithheld != null ? taxWithheld.value : this.taxWithheld,
		fees: fees != null ? fees.value : this.fees,
		paymentMethod: paymentMethod != null ? paymentMethod.value : this.paymentMethod,
		scheduledDate: scheduledDate != null ? scheduledDate.value : this.scheduledDate,
		processedDate: processedDate != null ? processedDate.value : this.processedDate,
		completedDate: completedDate != null ? completedDate.value : this.completedDate,
		referenceNumber: referenceNumber != null ? referenceNumber.value : this.referenceNumber,
		trackingNumber: trackingNumber != null ? trackingNumber.value : this.trackingNumber,
		bankAccount: bankAccount != null ? bankAccount.value : this.bankAccount,
		checkNumber: checkNumber != null ? checkNumber.value : this.checkNumber,
		wireReference: wireReference != null ? wireReference.value : this.wireReference,
		achRouting: achRouting != null ? achRouting.value : this.achRouting,
		escrowReleaseDate: escrowReleaseDate != null ? escrowReleaseDate.value : this.escrowReleaseDate,
		holdReason: holdReason != null ? holdReason.value : this.holdReason,
		failureReason: failureReason != null ? failureReason.value : this.failureReason,
		retryCount: retryCount != null ? retryCount.value : this.retryCount,
		maxRetries: maxRetries != null ? maxRetries.value : this.maxRetries,
		nextRetryDate: nextRetryDate != null ? nextRetryDate.value : this.nextRetryDate,
		priority: priority != null ? priority.value : this.priority,
		approvalRequired: approvalRequired != null ? approvalRequired.value : this.approvalRequired,
		approvedBy: approvedBy != null ? approvedBy.value : this.approvedBy,
		approvedAt: approvedAt != null ? approvedAt.value : this.approvedAt,
		notes: notes != null ? notes.value : this.notes,
		taxFormGenerated: taxFormGenerated != null ? taxFormGenerated.value : this.taxFormGenerated,
		taxFormSent: taxFormSent != null ? taxFormSent.value : this.taxFormSent,
		yearEndReport: yearEndReport != null ? yearEndReport.value : this.yearEndReport,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		commission: commission != null ? commission.value : this.commission,
		deal: deal != null ? deal.value : this.deal,
		org: org != null ? org.value : this.org,
		processor: processor != null ? processor.value : this.processor,
		recipient: recipient != null ? recipient.value : this.recipient
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Payout copyWithInstanceValues(Payout payout) {
        return Payout(
            id: payout.id ?? id,
		orgId: payout.orgId ?? orgId,
		dealId: payout.dealId ?? dealId,
		commissionId: payout.commissionId ?? commissionId,
		recipientId: payout.recipientId ?? recipientId,
		processorId: payout.processorId ?? processorId,
		payoutStatus: payout.payoutStatus ?? payoutStatus,
		payoutType: payout.payoutType ?? payoutType,
		amount: payout.amount ?? amount,
		grossAmount: payout.grossAmount ?? grossAmount,
		netAmount: payout.netAmount ?? netAmount,
		taxWithheld: payout.taxWithheld ?? taxWithheld,
		fees: payout.fees ?? fees,
		paymentMethod: payout.paymentMethod ?? paymentMethod,
		scheduledDate: payout.scheduledDate ?? scheduledDate,
		processedDate: payout.processedDate ?? processedDate,
		completedDate: payout.completedDate ?? completedDate,
		referenceNumber: payout.referenceNumber ?? referenceNumber,
		trackingNumber: payout.trackingNumber ?? trackingNumber,
		bankAccount: payout.bankAccount ?? bankAccount,
		checkNumber: payout.checkNumber ?? checkNumber,
		wireReference: payout.wireReference ?? wireReference,
		achRouting: payout.achRouting ?? achRouting,
		escrowReleaseDate: payout.escrowReleaseDate ?? escrowReleaseDate,
		holdReason: payout.holdReason ?? holdReason,
		failureReason: payout.failureReason ?? failureReason,
		retryCount: payout.retryCount ?? retryCount,
		maxRetries: payout.maxRetries ?? maxRetries,
		nextRetryDate: payout.nextRetryDate ?? nextRetryDate,
		priority: payout.priority ?? priority,
		approvalRequired: payout.approvalRequired ?? approvalRequired,
		approvedBy: payout.approvedBy ?? approvedBy,
		approvedAt: payout.approvedAt ?? approvedAt,
		notes: payout.notes ?? notes,
		taxFormGenerated: payout.taxFormGenerated ?? taxFormGenerated,
		taxFormSent: payout.taxFormSent ?? taxFormSent,
		yearEndReport: payout.yearEndReport ?? yearEndReport,
		createdBy: payout.createdBy ?? createdBy,
		createdAt: payout.createdAt ?? createdAt,
		updatedAt: payout.updatedAt ?? updatedAt,
		deletedAt: payout.deletedAt ?? deletedAt,
		commission: payout.commission ?? commission,
		deal: payout.deal ?? deal,
		org: payout.org ?? org,
		processor: payout.processor ?? processor,
		recipient: payout.recipient ?? recipient
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Payout mergeWithInstanceValues(Payout payout) {
        return Payout(
            id: payout.$assignedFields.contains('id') ? payout.id : id,
		orgId: payout.$assignedFields.contains('orgId') ? payout.orgId : orgId,
		dealId: payout.$assignedFields.contains('dealId') ? payout.dealId : dealId,
		commissionId: payout.$assignedFields.contains('commissionId') ? payout.commissionId : commissionId,
		recipientId: payout.$assignedFields.contains('recipientId') ? payout.recipientId : recipientId,
		processorId: payout.$assignedFields.contains('processorId') ? payout.processorId : processorId,
		payoutStatus: payout.$assignedFields.contains('payoutStatus') ? payout.payoutStatus : payoutStatus,
		payoutType: payout.$assignedFields.contains('payoutType') ? payout.payoutType : payoutType,
		amount: payout.$assignedFields.contains('amount') ? payout.amount : amount,
		grossAmount: payout.$assignedFields.contains('grossAmount') ? payout.grossAmount : grossAmount,
		netAmount: payout.$assignedFields.contains('netAmount') ? payout.netAmount : netAmount,
		taxWithheld: payout.$assignedFields.contains('taxWithheld') ? payout.taxWithheld : taxWithheld,
		fees: payout.$assignedFields.contains('fees') ? payout.fees : fees,
		paymentMethod: payout.$assignedFields.contains('paymentMethod') ? payout.paymentMethod : paymentMethod,
		scheduledDate: payout.$assignedFields.contains('scheduledDate') ? payout.scheduledDate : scheduledDate,
		processedDate: payout.$assignedFields.contains('processedDate') ? payout.processedDate : processedDate,
		completedDate: payout.$assignedFields.contains('completedDate') ? payout.completedDate : completedDate,
		referenceNumber: payout.$assignedFields.contains('referenceNumber') ? payout.referenceNumber : referenceNumber,
		trackingNumber: payout.$assignedFields.contains('trackingNumber') ? payout.trackingNumber : trackingNumber,
		bankAccount: payout.$assignedFields.contains('bankAccount') ? payout.bankAccount : bankAccount,
		checkNumber: payout.$assignedFields.contains('checkNumber') ? payout.checkNumber : checkNumber,
		wireReference: payout.$assignedFields.contains('wireReference') ? payout.wireReference : wireReference,
		achRouting: payout.$assignedFields.contains('achRouting') ? payout.achRouting : achRouting,
		escrowReleaseDate: payout.$assignedFields.contains('escrowReleaseDate') ? payout.escrowReleaseDate : escrowReleaseDate,
		holdReason: payout.$assignedFields.contains('holdReason') ? payout.holdReason : holdReason,
		failureReason: payout.$assignedFields.contains('failureReason') ? payout.failureReason : failureReason,
		retryCount: payout.$assignedFields.contains('retryCount') ? payout.retryCount : retryCount,
		maxRetries: payout.$assignedFields.contains('maxRetries') ? payout.maxRetries : maxRetries,
		nextRetryDate: payout.$assignedFields.contains('nextRetryDate') ? payout.nextRetryDate : nextRetryDate,
		priority: payout.$assignedFields.contains('priority') ? payout.priority : priority,
		approvalRequired: payout.$assignedFields.contains('approvalRequired') ? payout.approvalRequired : approvalRequired,
		approvedBy: payout.$assignedFields.contains('approvedBy') ? payout.approvedBy : approvedBy,
		approvedAt: payout.$assignedFields.contains('approvedAt') ? payout.approvedAt : approvedAt,
		notes: payout.$assignedFields.contains('notes') ? payout.notes : notes,
		taxFormGenerated: payout.$assignedFields.contains('taxFormGenerated') ? payout.taxFormGenerated : taxFormGenerated,
		taxFormSent: payout.$assignedFields.contains('taxFormSent') ? payout.taxFormSent : taxFormSent,
		yearEndReport: payout.$assignedFields.contains('yearEndReport') ? payout.yearEndReport : yearEndReport,
		createdBy: payout.$assignedFields.contains('createdBy') ? payout.createdBy : createdBy,
		createdAt: payout.$assignedFields.contains('createdAt') ? payout.createdAt : createdAt,
		updatedAt: payout.$assignedFields.contains('updatedAt') ? payout.updatedAt : updatedAt,
		deletedAt: payout.$assignedFields.contains('deletedAt') ? payout.deletedAt : deletedAt,
		commission: payout.$assignedFields.contains('commission') ? payout.commission : commission,
		deal: payout.$assignedFields.contains('deal') ? payout.deal : deal,
		org: payout.$assignedFields.contains('org') ? payout.org : org,
		processor: payout.$assignedFields.contains('processor') ? payout.processor : processor,
		recipient: payout.$assignedFields.contains('recipient') ? payout.recipient : recipient
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Payout updateWithInstanceValues(Payout payout) {
        if (payout.$assignedFields.contains('id')) { id = payout.id; }
		if (payout.$assignedFields.contains('orgId')) { orgId = payout.orgId; }
		if (payout.$assignedFields.contains('dealId')) { dealId = payout.dealId; }
		if (payout.$assignedFields.contains('commissionId')) { commissionId = payout.commissionId; }
		if (payout.$assignedFields.contains('recipientId')) { recipientId = payout.recipientId; }
		if (payout.$assignedFields.contains('processorId')) { processorId = payout.processorId; }
		if (payout.$assignedFields.contains('payoutStatus')) { payoutStatus = payout.payoutStatus; }
		if (payout.$assignedFields.contains('payoutType')) { payoutType = payout.payoutType; }
		if (payout.$assignedFields.contains('amount')) { amount = payout.amount; }
		if (payout.$assignedFields.contains('grossAmount')) { grossAmount = payout.grossAmount; }
		if (payout.$assignedFields.contains('netAmount')) { netAmount = payout.netAmount; }
		if (payout.$assignedFields.contains('taxWithheld')) { taxWithheld = payout.taxWithheld; }
		if (payout.$assignedFields.contains('fees')) { fees = payout.fees; }
		if (payout.$assignedFields.contains('paymentMethod')) { paymentMethod = payout.paymentMethod; }
		if (payout.$assignedFields.contains('scheduledDate')) { scheduledDate = payout.scheduledDate; }
		if (payout.$assignedFields.contains('processedDate')) { processedDate = payout.processedDate; }
		if (payout.$assignedFields.contains('completedDate')) { completedDate = payout.completedDate; }
		if (payout.$assignedFields.contains('referenceNumber')) { referenceNumber = payout.referenceNumber; }
		if (payout.$assignedFields.contains('trackingNumber')) { trackingNumber = payout.trackingNumber; }
		if (payout.$assignedFields.contains('bankAccount')) { bankAccount = payout.bankAccount; }
		if (payout.$assignedFields.contains('checkNumber')) { checkNumber = payout.checkNumber; }
		if (payout.$assignedFields.contains('wireReference')) { wireReference = payout.wireReference; }
		if (payout.$assignedFields.contains('achRouting')) { achRouting = payout.achRouting; }
		if (payout.$assignedFields.contains('escrowReleaseDate')) { escrowReleaseDate = payout.escrowReleaseDate; }
		if (payout.$assignedFields.contains('holdReason')) { holdReason = payout.holdReason; }
		if (payout.$assignedFields.contains('failureReason')) { failureReason = payout.failureReason; }
		if (payout.$assignedFields.contains('retryCount')) { retryCount = payout.retryCount; }
		if (payout.$assignedFields.contains('maxRetries')) { maxRetries = payout.maxRetries; }
		if (payout.$assignedFields.contains('nextRetryDate')) { nextRetryDate = payout.nextRetryDate; }
		if (payout.$assignedFields.contains('priority')) { priority = payout.priority; }
		if (payout.$assignedFields.contains('approvalRequired')) { approvalRequired = payout.approvalRequired; }
		if (payout.$assignedFields.contains('approvedBy')) { approvedBy = payout.approvedBy; }
		if (payout.$assignedFields.contains('approvedAt')) { approvedAt = payout.approvedAt; }
		if (payout.$assignedFields.contains('notes')) { notes = payout.notes; }
		if (payout.$assignedFields.contains('taxFormGenerated')) { taxFormGenerated = payout.taxFormGenerated; }
		if (payout.$assignedFields.contains('taxFormSent')) { taxFormSent = payout.taxFormSent; }
		if (payout.$assignedFields.contains('yearEndReport')) { yearEndReport = payout.yearEndReport; }
		if (payout.$assignedFields.contains('createdBy')) { createdBy = payout.createdBy; }
		if (payout.$assignedFields.contains('createdAt')) { createdAt = payout.createdAt; }
		if (payout.$assignedFields.contains('updatedAt')) { updatedAt = payout.updatedAt; }
		if (payout.$assignedFields.contains('deletedAt')) { deletedAt = payout.deletedAt; }
		if (payout.$assignedFields.contains('commission')) { commission = payout.commission; }
		if (payout.$assignedFields.contains('deal')) { deal = payout.deal; }
		if (payout.$assignedFields.contains('org')) { org = payout.org; }
		if (payout.$assignedFields.contains('processor')) { processor = payout.processor; }
		if (payout.$assignedFields.contains('recipient')) { recipient = payout.recipient; }
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
          ? {...?serializedTypes, 'Payout'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(dealId != null) 'dealId': dealId,
	if(commissionId != null) 'commissionId': commissionId,
	if(recipientId != null) 'recipientId': recipientId,
	if(processorId != null) 'processorId': processorId,
	if(payoutStatus != null) 'payoutStatus': payoutStatus?.toJson(),
	if(payoutType != null) 'payoutType': payoutType?.toJson(),
	if(amount != null) 'amount': amount,
	if(grossAmount != null) 'grossAmount': grossAmount,
	if(netAmount != null) 'netAmount': netAmount,
	if(taxWithheld != null) 'taxWithheld': taxWithheld,
	if(fees != null) 'fees': fees,
	if(paymentMethod != null) 'paymentMethod': paymentMethod?.toJson(),
	if(scheduledDate != null) 'scheduledDate': scheduledDate?.toIso8601String(),
	if(processedDate != null) 'processedDate': processedDate?.toIso8601String(),
	if(completedDate != null) 'completedDate': completedDate?.toIso8601String(),
	if(referenceNumber != null) 'referenceNumber': referenceNumber,
	if(trackingNumber != null) 'trackingNumber': trackingNumber,
	if(bankAccount != null) 'bankAccount': bankAccount,
	if(checkNumber != null) 'checkNumber': checkNumber,
	if(wireReference != null) 'wireReference': wireReference,
	if(achRouting != null) 'achRouting': achRouting,
	if(escrowReleaseDate != null) 'escrowReleaseDate': escrowReleaseDate?.toIso8601String(),
	if(holdReason != null) 'holdReason': holdReason,
	if(failureReason != null) 'failureReason': failureReason,
	if(retryCount != null) 'retryCount': retryCount,
	if(maxRetries != null) 'maxRetries': maxRetries,
	if(nextRetryDate != null) 'nextRetryDate': nextRetryDate?.toIso8601String(),
	if(priority != null) 'priority': priority,
	if(approvalRequired != null) 'approvalRequired': approvalRequired,
	if(approvedBy != null) 'approvedBy': approvedBy,
	if(approvedAt != null) 'approvedAt': approvedAt?.toIso8601String(),
	if(notes != null) 'notes': notes,
	if(taxFormGenerated != null) 'taxFormGenerated': taxFormGenerated,
	if(taxFormSent != null) 'taxFormSent': taxFormSent,
	if(yearEndReport != null) 'yearEndReport': yearEndReport,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(commission != null && (!preventCircularSerialization || !serializedModels.contains('Commission'))) 'commission': commission?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(deal != null && (!preventCircularSerialization || !serializedModels.contains('Deal'))) 'deal': deal?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(processor != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'processor': processor?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(recipient != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'recipient': recipient?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Payout &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    