
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'deal_status_u_s_a.dart';
import 'attorney_management.dart';
import 'contact.dart';
import 'listing.dart';
import 'location.dart';
import 'organization.dart';
import 'property.dart';
import 'document.dart';
import 'mortgage_pre_approval.dart';
import 'payout.dart';
import 'solicitor_management.dart';


class Deal implements PrismaModel<String, Deal> , Id<String> {
    @override
String? id;
	String? orgId;
	String? listingId;
	String? propertyId;
	String? clientId;
	String? agentId;
	String? locationId;
	DealStatusUSA? dealStatus;
	String? dealType;
	double? offerPrice;
	double? listPrice;
	double? salePrice;
	double? commissionRate;
	double? commissionAmount;
	DateTime? closingDate;
	String? financingType;
	double? loanAmount;
	double? downPayment;
	double? earnestMoney;
	double? escrowAmount;
	double? closingCosts;
	double? sellerConcessions;
	double? buyerCredits;
	int? inspectionPeriod;
	bool? financingContingency;
	bool? appraisalContingency;
	bool? titleContingency;
	bool? attorneyReview;
	bool? multipleOffers;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	AttorneyManagement? attorney;
	Contact? agent;
	Contact? client;
	Listing? listing;
	Location? location;
	Organization? org;
	Property? property;
	List<Document>? documents;
	List<MortgagePreApproval>? mortgagePreApprovals;
	List<Payout>? payouts;
	List<SolicitorManagement>? solicitorManagements;
	int? $documentsCount;
	int? $mortgagePreApprovalsCount;
	int? $payoutsCount;
	int? $solicitorManagementsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Deal({ this.id,
	 this.orgId,
	 this.listingId,
	 this.propertyId,
	 this.clientId,
	 this.agentId,
	 this.locationId,
	 this.dealStatus = DealStatusUSA.LEAD,
	 this.dealType,
	 this.offerPrice,
	 this.listPrice,
	 this.salePrice,
	 this.commissionRate,
	 this.commissionAmount,
	 this.closingDate,
	 this.financingType,
	 this.loanAmount,
	 this.downPayment,
	 this.earnestMoney,
	 this.escrowAmount,
	 this.closingCosts,
	 this.sellerConcessions,
	 this.buyerCredits,
	 this.inspectionPeriod,
	 this.financingContingency = true,
	 this.appraisalContingency = true,
	 this.titleContingency = true,
	 this.attorneyReview = false,
	 this.multipleOffers = false,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.attorney,
	 this.agent,
	 this.client,
	 this.listing,
	 this.location,
	 this.org,
	 this.property,
	 this.documents,
	 this.mortgagePreApprovals,
	 this.payouts,
	 this.solicitorManagements,
	this.$documentsCount,
	this.$mortgagePreApprovalsCount,
	this.$payoutsCount,
	this.$solicitorManagementsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Deal, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"listingId": (m) => m.listingId,

	"propertyId": (m) => m.propertyId,

	"clientId": (m) => m.clientId,

	"agentId": (m) => m.agentId,

	"locationId": (m) => m.locationId,

	"dealStatus": (m) => m.dealStatus,

	"dealType": (m) => m.dealType,

	"offerPrice": (m) => m.offerPrice,

	"listPrice": (m) => m.listPrice,

	"salePrice": (m) => m.salePrice,

	"commissionRate": (m) => m.commissionRate,

	"commissionAmount": (m) => m.commissionAmount,

	"closingDate": (m) => m.closingDate,

	"financingType": (m) => m.financingType,

	"loanAmount": (m) => m.loanAmount,

	"downPayment": (m) => m.downPayment,

	"earnestMoney": (m) => m.earnestMoney,

	"escrowAmount": (m) => m.escrowAmount,

	"closingCosts": (m) => m.closingCosts,

	"sellerConcessions": (m) => m.sellerConcessions,

	"buyerCredits": (m) => m.buyerCredits,

	"inspectionPeriod": (m) => m.inspectionPeriod,

	"financingContingency": (m) => m.financingContingency,

	"appraisalContingency": (m) => m.appraisalContingency,

	"titleContingency": (m) => m.titleContingency,

	"attorneyReview": (m) => m.attorneyReview,

	"multipleOffers": (m) => m.multipleOffers,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"attorney": (m) => m.attorney,

	"agent": (m) => m.agent,

	"client": (m) => m.client,

	"listing": (m) => m.listing,

	"location": (m) => m.location,

	"org": (m) => m.org,

	"property": (m) => m.property,

	"documents": (m) => m.documents,

	"mortgagePreApprovals": (m) => m.mortgagePreApprovals,

	"payouts": (m) => m.payouts,

	"solicitorManagements": (m) => m.solicitorManagements,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Deal) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Deal');
    }
    return propFunction as V? Function(Deal);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Deal.fromJson(JsonMap json) =>
      Deal(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	listingId: json['listingId'] as String?,
	propertyId: json['propertyId'] as String?,
	clientId: json['clientId'] as String?,
	agentId: json['agentId'] as String?,
	locationId: json['locationId'] as String?,
	dealStatus: json['dealStatus'] != null ? DealStatusUSA.fromJson(json['dealStatus']) : null,
	dealType: json['dealType'] as String?,
	offerPrice: json['offerPrice'] as double?,
	listPrice: json['listPrice'] as double?,
	salePrice: json['salePrice'] as double?,
	commissionRate: json['commissionRate']?.toDouble(),
	commissionAmount: json['commissionAmount'] as double?,
	closingDate: json['closingDate'] != null ? DateTime.parse(json['closingDate']) : null,
	financingType: json['financingType'] as String?,
	loanAmount: json['loanAmount'] as double?,
	downPayment: json['downPayment'] as double?,
	earnestMoney: json['earnestMoney'] as double?,
	escrowAmount: json['escrowAmount'] as double?,
	closingCosts: json['closingCosts'] as double?,
	sellerConcessions: json['sellerConcessions'] as double?,
	buyerCredits: json['buyerCredits'] as double?,
	inspectionPeriod: int.tryParse(json['inspectionPeriod'].toString()),
	financingContingency: json['financingContingency'] as bool?,
	appraisalContingency: json['appraisalContingency'] as bool?,
	titleContingency: json['titleContingency'] as bool?,
	attorneyReview: json['attorneyReview'] as bool?,
	multipleOffers: json['multipleOffers'] as bool?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	attorney: json['attorney'] != null ? AttorneyManagement.fromJson(json['attorney'] as JsonMap) : null,
	agent: json['agent'] != null ? Contact.fromJson(json['agent'] as JsonMap) : null,
	client: json['client'] != null ? Contact.fromJson(json['client'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	location: json['location'] != null ? Location.fromJson(json['location'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	documents: json['documents'] != null ? createModels<Document>((json['documents'] as List).cast<JsonMap>(), Document.fromJson) : null,
	mortgagePreApprovals: json['mortgagePreApprovals'] != null ? createModels<MortgagePreApproval>((json['mortgagePreApprovals'] as List).cast<JsonMap>(), MortgagePreApproval.fromJson) : null,
	payouts: json['payouts'] != null ? createModels<Payout>((json['payouts'] as List).cast<JsonMap>(), Payout.fromJson) : null,
	solicitorManagements: json['solicitorManagements'] != null ? createModels<SolicitorManagement>((json['solicitorManagements'] as List).cast<JsonMap>(), SolicitorManagement.fromJson) : null,
	$documentsCount: json['_count']?['documents'] as int?,
	$mortgagePreApprovalsCount: json['_count']?['mortgagePreApprovals'] as int?,
	$payoutsCount: json['_count']?['payouts'] as int?,
	$solicitorManagementsCount: json['_count']?['solicitorManagements'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Deal copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? listingId,
		Value<String?>? propertyId,
		Value<String?>? clientId,
		Value<String?>? agentId,
		Value<String?>? locationId,
		Value<DealStatusUSA?>? dealStatus,
		Value<String?>? dealType,
		Value<double?>? offerPrice,
		Value<double?>? listPrice,
		Value<double?>? salePrice,
		Value<double?>? commissionRate,
		Value<double?>? commissionAmount,
		Value<DateTime?>? closingDate,
		Value<String?>? financingType,
		Value<double?>? loanAmount,
		Value<double?>? downPayment,
		Value<double?>? earnestMoney,
		Value<double?>? escrowAmount,
		Value<double?>? closingCosts,
		Value<double?>? sellerConcessions,
		Value<double?>? buyerCredits,
		Value<int?>? inspectionPeriod,
		Value<bool?>? financingContingency,
		Value<bool?>? appraisalContingency,
		Value<bool?>? titleContingency,
		Value<bool?>? attorneyReview,
		Value<bool?>? multipleOffers,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<AttorneyManagement?>? attorney,
		Value<Contact?>? agent,
		Value<Contact?>? client,
		Value<Listing?>? listing,
		Value<Location?>? location,
		Value<Organization?>? org,
		Value<Property?>? property,
		Value<List<Document>?>? documents,
		Value<List<MortgagePreApproval>?>? mortgagePreApprovals,
		Value<List<Payout>?>? payouts,
		Value<List<SolicitorManagement>?>? solicitorManagements,
		int? $documentsCount,
		int? $mortgagePreApprovalsCount,
		int? $payoutsCount,
		int? $solicitorManagementsCount,
        }) {
        return Deal(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		listingId: listingId != null ? listingId.value : this.listingId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		clientId: clientId != null ? clientId.value : this.clientId,
		agentId: agentId != null ? agentId.value : this.agentId,
		locationId: locationId != null ? locationId.value : this.locationId,
		dealStatus: dealStatus != null ? dealStatus.value : this.dealStatus,
		dealType: dealType != null ? dealType.value : this.dealType,
		offerPrice: offerPrice != null ? offerPrice.value : this.offerPrice,
		listPrice: listPrice != null ? listPrice.value : this.listPrice,
		salePrice: salePrice != null ? salePrice.value : this.salePrice,
		commissionRate: commissionRate != null ? commissionRate.value : this.commissionRate,
		commissionAmount: commissionAmount != null ? commissionAmount.value : this.commissionAmount,
		closingDate: closingDate != null ? closingDate.value : this.closingDate,
		financingType: financingType != null ? financingType.value : this.financingType,
		loanAmount: loanAmount != null ? loanAmount.value : this.loanAmount,
		downPayment: downPayment != null ? downPayment.value : this.downPayment,
		earnestMoney: earnestMoney != null ? earnestMoney.value : this.earnestMoney,
		escrowAmount: escrowAmount != null ? escrowAmount.value : this.escrowAmount,
		closingCosts: closingCosts != null ? closingCosts.value : this.closingCosts,
		sellerConcessions: sellerConcessions != null ? sellerConcessions.value : this.sellerConcessions,
		buyerCredits: buyerCredits != null ? buyerCredits.value : this.buyerCredits,
		inspectionPeriod: inspectionPeriod != null ? inspectionPeriod.value : this.inspectionPeriod,
		financingContingency: financingContingency != null ? financingContingency.value : this.financingContingency,
		appraisalContingency: appraisalContingency != null ? appraisalContingency.value : this.appraisalContingency,
		titleContingency: titleContingency != null ? titleContingency.value : this.titleContingency,
		attorneyReview: attorneyReview != null ? attorneyReview.value : this.attorneyReview,
		multipleOffers: multipleOffers != null ? multipleOffers.value : this.multipleOffers,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		attorney: attorney != null ? attorney.value : this.attorney,
		agent: agent != null ? agent.value : this.agent,
		client: client != null ? client.value : this.client,
		listing: listing != null ? listing.value : this.listing,
		location: location != null ? location.value : this.location,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property,
		documents: documents != null ? documents.value : this.documents,
		mortgagePreApprovals: mortgagePreApprovals != null ? mortgagePreApprovals.value : this.mortgagePreApprovals,
		payouts: payouts != null ? payouts.value : this.payouts,
		solicitorManagements: solicitorManagements != null ? solicitorManagements.value : this.solicitorManagements,
		$documentsCount: $documentsCount ?? this.$documentsCount,
		$mortgagePreApprovalsCount: $mortgagePreApprovalsCount ?? this.$mortgagePreApprovalsCount,
		$payoutsCount: $payoutsCount ?? this.$payoutsCount,
		$solicitorManagementsCount: $solicitorManagementsCount ?? this.$solicitorManagementsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Deal copyWithInstanceValues(Deal deal) {
        return Deal(
            id: deal.id ?? id,
		orgId: deal.orgId ?? orgId,
		listingId: deal.listingId ?? listingId,
		propertyId: deal.propertyId ?? propertyId,
		clientId: deal.clientId ?? clientId,
		agentId: deal.agentId ?? agentId,
		locationId: deal.locationId ?? locationId,
		dealStatus: deal.dealStatus ?? dealStatus,
		dealType: deal.dealType ?? dealType,
		offerPrice: deal.offerPrice ?? offerPrice,
		listPrice: deal.listPrice ?? listPrice,
		salePrice: deal.salePrice ?? salePrice,
		commissionRate: deal.commissionRate ?? commissionRate,
		commissionAmount: deal.commissionAmount ?? commissionAmount,
		closingDate: deal.closingDate ?? closingDate,
		financingType: deal.financingType ?? financingType,
		loanAmount: deal.loanAmount ?? loanAmount,
		downPayment: deal.downPayment ?? downPayment,
		earnestMoney: deal.earnestMoney ?? earnestMoney,
		escrowAmount: deal.escrowAmount ?? escrowAmount,
		closingCosts: deal.closingCosts ?? closingCosts,
		sellerConcessions: deal.sellerConcessions ?? sellerConcessions,
		buyerCredits: deal.buyerCredits ?? buyerCredits,
		inspectionPeriod: deal.inspectionPeriod ?? inspectionPeriod,
		financingContingency: deal.financingContingency ?? financingContingency,
		appraisalContingency: deal.appraisalContingency ?? appraisalContingency,
		titleContingency: deal.titleContingency ?? titleContingency,
		attorneyReview: deal.attorneyReview ?? attorneyReview,
		multipleOffers: deal.multipleOffers ?? multipleOffers,
		createdBy: deal.createdBy ?? createdBy,
		createdAt: deal.createdAt ?? createdAt,
		updatedAt: deal.updatedAt ?? updatedAt,
		deletedAt: deal.deletedAt ?? deletedAt,
		attorney: deal.attorney ?? attorney,
		agent: deal.agent ?? agent,
		client: deal.client ?? client,
		listing: deal.listing ?? listing,
		location: deal.location ?? location,
		org: deal.org ?? org,
		property: deal.property ?? property,
		documents: deal.documents ?? documents,
		mortgagePreApprovals: deal.mortgagePreApprovals ?? mortgagePreApprovals,
		payouts: deal.payouts ?? payouts,
		solicitorManagements: deal.solicitorManagements ?? solicitorManagements,
		$documentsCount: deal.$documentsCount ?? $documentsCount,
		$mortgagePreApprovalsCount: deal.$mortgagePreApprovalsCount ?? $mortgagePreApprovalsCount,
		$payoutsCount: deal.$payoutsCount ?? $payoutsCount,
		$solicitorManagementsCount: deal.$solicitorManagementsCount ?? $solicitorManagementsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Deal mergeWithInstanceValues(Deal deal) {
        return Deal(
            id: deal.$assignedFields.contains('id') ? deal.id : id,
		orgId: deal.$assignedFields.contains('orgId') ? deal.orgId : orgId,
		listingId: deal.$assignedFields.contains('listingId') ? deal.listingId : listingId,
		propertyId: deal.$assignedFields.contains('propertyId') ? deal.propertyId : propertyId,
		clientId: deal.$assignedFields.contains('clientId') ? deal.clientId : clientId,
		agentId: deal.$assignedFields.contains('agentId') ? deal.agentId : agentId,
		locationId: deal.$assignedFields.contains('locationId') ? deal.locationId : locationId,
		dealStatus: deal.$assignedFields.contains('dealStatus') ? deal.dealStatus : dealStatus,
		dealType: deal.$assignedFields.contains('dealType') ? deal.dealType : dealType,
		offerPrice: deal.$assignedFields.contains('offerPrice') ? deal.offerPrice : offerPrice,
		listPrice: deal.$assignedFields.contains('listPrice') ? deal.listPrice : listPrice,
		salePrice: deal.$assignedFields.contains('salePrice') ? deal.salePrice : salePrice,
		commissionRate: deal.$assignedFields.contains('commissionRate') ? deal.commissionRate : commissionRate,
		commissionAmount: deal.$assignedFields.contains('commissionAmount') ? deal.commissionAmount : commissionAmount,
		closingDate: deal.$assignedFields.contains('closingDate') ? deal.closingDate : closingDate,
		financingType: deal.$assignedFields.contains('financingType') ? deal.financingType : financingType,
		loanAmount: deal.$assignedFields.contains('loanAmount') ? deal.loanAmount : loanAmount,
		downPayment: deal.$assignedFields.contains('downPayment') ? deal.downPayment : downPayment,
		earnestMoney: deal.$assignedFields.contains('earnestMoney') ? deal.earnestMoney : earnestMoney,
		escrowAmount: deal.$assignedFields.contains('escrowAmount') ? deal.escrowAmount : escrowAmount,
		closingCosts: deal.$assignedFields.contains('closingCosts') ? deal.closingCosts : closingCosts,
		sellerConcessions: deal.$assignedFields.contains('sellerConcessions') ? deal.sellerConcessions : sellerConcessions,
		buyerCredits: deal.$assignedFields.contains('buyerCredits') ? deal.buyerCredits : buyerCredits,
		inspectionPeriod: deal.$assignedFields.contains('inspectionPeriod') ? deal.inspectionPeriod : inspectionPeriod,
		financingContingency: deal.$assignedFields.contains('financingContingency') ? deal.financingContingency : financingContingency,
		appraisalContingency: deal.$assignedFields.contains('appraisalContingency') ? deal.appraisalContingency : appraisalContingency,
		titleContingency: deal.$assignedFields.contains('titleContingency') ? deal.titleContingency : titleContingency,
		attorneyReview: deal.$assignedFields.contains('attorneyReview') ? deal.attorneyReview : attorneyReview,
		multipleOffers: deal.$assignedFields.contains('multipleOffers') ? deal.multipleOffers : multipleOffers,
		createdBy: deal.$assignedFields.contains('createdBy') ? deal.createdBy : createdBy,
		createdAt: deal.$assignedFields.contains('createdAt') ? deal.createdAt : createdAt,
		updatedAt: deal.$assignedFields.contains('updatedAt') ? deal.updatedAt : updatedAt,
		deletedAt: deal.$assignedFields.contains('deletedAt') ? deal.deletedAt : deletedAt,
		attorney: deal.$assignedFields.contains('attorney') ? deal.attorney : attorney,
		agent: deal.$assignedFields.contains('agent') ? deal.agent : agent,
		client: deal.$assignedFields.contains('client') ? deal.client : client,
		listing: deal.$assignedFields.contains('listing') ? deal.listing : listing,
		location: deal.$assignedFields.contains('location') ? deal.location : location,
		org: deal.$assignedFields.contains('org') ? deal.org : org,
		property: deal.$assignedFields.contains('property') ? deal.property : property,
		documents: (deal.$assignedFields.contains('documents') && deal.documents != null) ? mergeModelLists(documents, deal.documents) : documents,
		mortgagePreApprovals: (deal.$assignedFields.contains('mortgagePreApprovals') && deal.mortgagePreApprovals != null) ? mergeModelLists(mortgagePreApprovals, deal.mortgagePreApprovals) : mortgagePreApprovals,
		payouts: (deal.$assignedFields.contains('payouts') && deal.payouts != null) ? mergeModelLists(payouts, deal.payouts) : payouts,
		solicitorManagements: (deal.$assignedFields.contains('solicitorManagements') && deal.solicitorManagements != null) ? mergeModelLists(solicitorManagements, deal.solicitorManagements) : solicitorManagements,
		$documentsCount: deal.$documentsCount ?? $documentsCount,
		$mortgagePreApprovalsCount: deal.$mortgagePreApprovalsCount ?? $mortgagePreApprovalsCount,
		$payoutsCount: deal.$payoutsCount ?? $payoutsCount,
		$solicitorManagementsCount: deal.$solicitorManagementsCount ?? $solicitorManagementsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Deal updateWithInstanceValues(Deal deal) {
        if (deal.$assignedFields.contains('id')) { id = deal.id; }
		if (deal.$assignedFields.contains('orgId')) { orgId = deal.orgId; }
		if (deal.$assignedFields.contains('listingId')) { listingId = deal.listingId; }
		if (deal.$assignedFields.contains('propertyId')) { propertyId = deal.propertyId; }
		if (deal.$assignedFields.contains('clientId')) { clientId = deal.clientId; }
		if (deal.$assignedFields.contains('agentId')) { agentId = deal.agentId; }
		if (deal.$assignedFields.contains('locationId')) { locationId = deal.locationId; }
		if (deal.$assignedFields.contains('dealStatus')) { dealStatus = deal.dealStatus; }
		if (deal.$assignedFields.contains('dealType')) { dealType = deal.dealType; }
		if (deal.$assignedFields.contains('offerPrice')) { offerPrice = deal.offerPrice; }
		if (deal.$assignedFields.contains('listPrice')) { listPrice = deal.listPrice; }
		if (deal.$assignedFields.contains('salePrice')) { salePrice = deal.salePrice; }
		if (deal.$assignedFields.contains('commissionRate')) { commissionRate = deal.commissionRate; }
		if (deal.$assignedFields.contains('commissionAmount')) { commissionAmount = deal.commissionAmount; }
		if (deal.$assignedFields.contains('closingDate')) { closingDate = deal.closingDate; }
		if (deal.$assignedFields.contains('financingType')) { financingType = deal.financingType; }
		if (deal.$assignedFields.contains('loanAmount')) { loanAmount = deal.loanAmount; }
		if (deal.$assignedFields.contains('downPayment')) { downPayment = deal.downPayment; }
		if (deal.$assignedFields.contains('earnestMoney')) { earnestMoney = deal.earnestMoney; }
		if (deal.$assignedFields.contains('escrowAmount')) { escrowAmount = deal.escrowAmount; }
		if (deal.$assignedFields.contains('closingCosts')) { closingCosts = deal.closingCosts; }
		if (deal.$assignedFields.contains('sellerConcessions')) { sellerConcessions = deal.sellerConcessions; }
		if (deal.$assignedFields.contains('buyerCredits')) { buyerCredits = deal.buyerCredits; }
		if (deal.$assignedFields.contains('inspectionPeriod')) { inspectionPeriod = deal.inspectionPeriod; }
		if (deal.$assignedFields.contains('financingContingency')) { financingContingency = deal.financingContingency; }
		if (deal.$assignedFields.contains('appraisalContingency')) { appraisalContingency = deal.appraisalContingency; }
		if (deal.$assignedFields.contains('titleContingency')) { titleContingency = deal.titleContingency; }
		if (deal.$assignedFields.contains('attorneyReview')) { attorneyReview = deal.attorneyReview; }
		if (deal.$assignedFields.contains('multipleOffers')) { multipleOffers = deal.multipleOffers; }
		if (deal.$assignedFields.contains('createdBy')) { createdBy = deal.createdBy; }
		if (deal.$assignedFields.contains('createdAt')) { createdAt = deal.createdAt; }
		if (deal.$assignedFields.contains('updatedAt')) { updatedAt = deal.updatedAt; }
		if (deal.$assignedFields.contains('deletedAt')) { deletedAt = deal.deletedAt; }
		if (deal.$assignedFields.contains('attorney')) { attorney = deal.attorney; }
		if (deal.$assignedFields.contains('agent')) { agent = deal.agent; }
		if (deal.$assignedFields.contains('client')) { client = deal.client; }
		if (deal.$assignedFields.contains('listing')) { listing = deal.listing; }
		if (deal.$assignedFields.contains('location')) { location = deal.location; }
		if (deal.$assignedFields.contains('org')) { org = deal.org; }
		if (deal.$assignedFields.contains('property')) { property = deal.property; }
		if (deal.$assignedFields.contains('documents') && deal.documents != null) { documents = mergeModelLists(documents, deal.documents); }
		if (deal.$assignedFields.contains('mortgagePreApprovals') && deal.mortgagePreApprovals != null) { mortgagePreApprovals = mergeModelLists(mortgagePreApprovals, deal.mortgagePreApprovals); }
		if (deal.$assignedFields.contains('payouts') && deal.payouts != null) { payouts = mergeModelLists(payouts, deal.payouts); }
		if (deal.$assignedFields.contains('solicitorManagements') && deal.solicitorManagements != null) { solicitorManagements = mergeModelLists(solicitorManagements, deal.solicitorManagements); }
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
          ? {...?serializedTypes, 'Deal'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(listingId != null) 'listingId': listingId,
	if(propertyId != null) 'propertyId': propertyId,
	if(clientId != null) 'clientId': clientId,
	if(agentId != null) 'agentId': agentId,
	if(locationId != null) 'locationId': locationId,
	if(dealStatus != null) 'dealStatus': dealStatus?.toJson(),
	if(dealType != null) 'dealType': dealType,
	if(offerPrice != null) 'offerPrice': offerPrice,
	if(listPrice != null) 'listPrice': listPrice,
	if(salePrice != null) 'salePrice': salePrice,
	if(commissionRate != null) 'commissionRate': commissionRate,
	if(commissionAmount != null) 'commissionAmount': commissionAmount,
	if(closingDate != null) 'closingDate': closingDate?.toIso8601String(),
	if(financingType != null) 'financingType': financingType,
	if(loanAmount != null) 'loanAmount': loanAmount,
	if(downPayment != null) 'downPayment': downPayment,
	if(earnestMoney != null) 'earnestMoney': earnestMoney,
	if(escrowAmount != null) 'escrowAmount': escrowAmount,
	if(closingCosts != null) 'closingCosts': closingCosts,
	if(sellerConcessions != null) 'sellerConcessions': sellerConcessions,
	if(buyerCredits != null) 'buyerCredits': buyerCredits,
	if(inspectionPeriod != null) 'inspectionPeriod': inspectionPeriod,
	if(financingContingency != null) 'financingContingency': financingContingency,
	if(appraisalContingency != null) 'appraisalContingency': appraisalContingency,
	if(titleContingency != null) 'titleContingency': titleContingency,
	if(attorneyReview != null) 'attorneyReview': attorneyReview,
	if(multipleOffers != null) 'multipleOffers': multipleOffers,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(attorney != null && (!preventCircularSerialization || !serializedModels.contains('AttorneyManagement'))) 'attorney': attorney?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(agent != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'agent': agent?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(client != null && (!preventCircularSerialization || !serializedModels.contains('Contact'))) 'client': client?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(location != null && (!preventCircularSerialization || !serializedModels.contains('Location'))) 'location': location?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(documents != null && (!preventCircularSerialization || !serializedModels.contains('Document'))) 'documents': documents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mortgagePreApprovals != null && (!preventCircularSerialization || !serializedModels.contains('MortgagePreApproval'))) 'mortgagePreApprovals': mortgagePreApprovals?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(payouts != null && (!preventCircularSerialization || !serializedModels.contains('Payout'))) 'payouts': payouts?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(solicitorManagements != null && (!preventCircularSerialization || !serializedModels.contains('SolicitorManagement'))) 'solicitorManagements': solicitorManagements?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($documentsCount != null || $mortgagePreApprovalsCount != null || $payoutsCount != null || $solicitorManagementsCount != null) '_count': { 
		if ($documentsCount != null) 'documents': $documentsCount, 
		if ($mortgagePreApprovalsCount != null) 'mortgagePreApprovals': $mortgagePreApprovalsCount, 
		if ($payoutsCount != null) 'payouts': $payoutsCount, 
		if ($solicitorManagementsCount != null) 'solicitorManagements': $solicitorManagementsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Deal &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    