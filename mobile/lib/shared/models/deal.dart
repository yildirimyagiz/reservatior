import 'package:reservatior/shared/enums/deal_status_usa.dart';
import 'attorney_management.dart';
import 'contact.dart';
import 'document.dart';
import 'listing.dart';
import 'location.dart';
import 'mortgage_pre_approval.dart';
import 'organization.dart';
import 'payout.dart';
import 'property.dart';
import 'solicitor_management.dart';

class Deal {
  final String id;
  final String orgId;
  final String? listingId;
  final String? propertyId;
  final String? clientId;
  final String? agentId;
  final String? locationId;
  final DealStatusUSA dealStatus;
  final String? dealType;
  final double? offerPrice;
  final double? listPrice;
  final double? salePrice;
  final double? commissionRate;
  final double? commissionAmount;
  final DateTime? closingDate;
  final String? financingType;
  final double? loanAmount;
  final double? downPayment;
  final double? earnestMoney;
  final double? escrowAmount;
  final double? closingCosts;
  final double? sellerConcessions;
  final double? buyerCredits;
  final int? inspectionPeriod;
  final bool financingContingency;
  final bool appraisalContingency;
  final bool titleContingency;
  final bool attorneyReview;
  final bool multipleOffers;
  final String? createdBy;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final AttorneyManagement? attorney;
  final Contact? agent;
  final Contact? client;
  final Listing? listing;
  final Location? location;
  final Organization org;
  final Property? property;
  final List<Document> documents;
  final List<MortgagePreApproval> mortgagePreApprovals;
  final List<Payout> payouts;
  final List<SolicitorManagement> solicitorManagements;

  const Deal({
    required this.id,
    required this.orgId,
    this.listingId,
    this.propertyId,
    this.clientId,
    this.agentId,
    this.locationId,
    required this.dealStatus,
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
    required this.financingContingency,
    required this.appraisalContingency,
    required this.titleContingency,
    required this.attorneyReview,
    required this.multipleOffers,
    this.createdBy,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.attorney,
    this.agent,
    this.client,
    this.listing,
    this.location,
    required this.org,
    this.property,
    this.documents = const [],
    this.mortgagePreApprovals = const [],
    this.payouts = const [],
    this.solicitorManagements = const [],
  });

  factory Deal.fromJson(Map<String, dynamic> json) {
    return Deal(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      listingId: json['listingId'] as String?,
      propertyId: json['propertyId'] as String?,
      clientId: json['clientId'] as String?,
      agentId: json['agentId'] as String?,
      locationId: json['locationId'] as String?,
      dealStatus: (() {
        final valUpper = json['dealStatus']?.toString().toUpperCase() ?? '';
        return DealStatusUSA.values.firstWhere(
          (v) => v.name.toUpperCase() == valUpper,
          orElse: () => DealStatusUSA.LEAD,
        );
      })(),
      dealType: json['dealType'] as String?,
      offerPrice: (json['offerPrice'] as num?)?.toDouble(),
      listPrice: (json['listPrice'] as num?)?.toDouble(),
      salePrice: (json['salePrice'] as num?)?.toDouble(),
      commissionRate: (json['commissionRate'] as num?)?.toDouble(),
      commissionAmount: (json['commissionAmount'] as num?)?.toDouble(),
      closingDate: json['closingDate'] != null ? DateTime.parse(json['closingDate'] as String) : null,
      financingType: json['financingType'] as String?,
      loanAmount: (json['loanAmount'] as num?)?.toDouble(),
      downPayment: (json['downPayment'] as num?)?.toDouble(),
      earnestMoney: (json['earnestMoney'] as num?)?.toDouble(),
      escrowAmount: (json['escrowAmount'] as num?)?.toDouble(),
      closingCosts: (json['closingCosts'] as num?)?.toDouble(),
      sellerConcessions: (json['sellerConcessions'] as num?)?.toDouble(),
      buyerCredits: (json['buyerCredits'] as num?)?.toDouble(),
      inspectionPeriod: json['inspectionPeriod'] as int?,
      financingContingency: json['financingContingency'] as bool,
      appraisalContingency: json['appraisalContingency'] as bool,
      titleContingency: json['titleContingency'] as bool,
      attorneyReview: json['attorneyReview'] as bool,
      multipleOffers: json['multipleOffers'] as bool,
      createdBy: json['createdBy'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      attorney: json['attorney'] != null ? AttorneyManagement.fromJson(json['attorney'] as Map<String, dynamic>) : null,
      agent: json['agent'] != null ? Contact.fromJson(json['agent'] as Map<String, dynamic>) : null,
      client: json['client'] != null ? Contact.fromJson(json['client'] as Map<String, dynamic>) : null,
      listing: json['listing'] != null ? Listing.fromJson(json['listing'] as Map<String, dynamic>) : null,
      location: json['location'] != null ? Location.fromJson(json['location'] as Map<String, dynamic>) : null,
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      property: json['property'] != null ? Property.fromJson(json['property'] as Map<String, dynamic>) : null,
      documents: (json['documents'] as List<dynamic>?)?.map((e) => Document.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mortgagePreApprovals: (json['mortgagePreApprovals'] as List<dynamic>?)?.map((e) => MortgagePreApproval.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      payouts: (json['payouts'] as List<dynamic>?)?.map((e) => Payout.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      solicitorManagements: (json['solicitorManagements'] as List<dynamic>?)?.map((e) => SolicitorManagement.fromJson(e as Map<String, dynamic>)).toList() ?? [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'listingId': listingId,
      'propertyId': propertyId,
      'clientId': clientId,
      'agentId': agentId,
      'locationId': locationId,
      'dealStatus': dealStatus.name,
      'dealType': dealType,
      'offerPrice': offerPrice,
      'listPrice': listPrice,
      'salePrice': salePrice,
      'commissionRate': commissionRate,
      'commissionAmount': commissionAmount,
      'closingDate': closingDate?.toIso8601String(),
      'financingType': financingType,
      'loanAmount': loanAmount,
      'downPayment': downPayment,
      'earnestMoney': earnestMoney,
      'escrowAmount': escrowAmount,
      'closingCosts': closingCosts,
      'sellerConcessions': sellerConcessions,
      'buyerCredits': buyerCredits,
      'inspectionPeriod': inspectionPeriod,
      'financingContingency': financingContingency,
      'appraisalContingency': appraisalContingency,
      'titleContingency': titleContingency,
      'attorneyReview': attorneyReview,
      'multipleOffers': multipleOffers,
      'createdBy': createdBy,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'attorney': attorney?.toJson(),
      'agent': agent?.toJson(),
      'client': client?.toJson(),
      'listing': listing?.toJson(),
      'location': location?.toJson(),
      'org': org.toJson(),
      'property': property?.toJson(),
      'documents': documents.map((e) => e.toJson()).toList(),
      'mortgagePreApprovals': mortgagePreApprovals.map((e) => e.toJson()).toList(),
      'payouts': payouts.map((e) => e.toJson()).toList(),
      'solicitorManagements': solicitorManagements.map((e) => e.toJson()).toList(),
    };
  }

  Deal copyWith({
    String? id,
    String? orgId,
    String? listingId,
    String? propertyId,
    String? clientId,
    String? agentId,
    String? locationId,
    DealStatusUSA? dealStatus,
    String? dealType,
    double? offerPrice,
    double? listPrice,
    double? salePrice,
    double? commissionRate,
    double? commissionAmount,
    DateTime? closingDate,
    String? financingType,
    double? loanAmount,
    double? downPayment,
    double? earnestMoney,
    double? escrowAmount,
    double? closingCosts,
    double? sellerConcessions,
    double? buyerCredits,
    int? inspectionPeriod,
    bool? financingContingency,
    bool? appraisalContingency,
    bool? titleContingency,
    bool? attorneyReview,
    bool? multipleOffers,
    String? createdBy,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    AttorneyManagement? attorney,
    Contact? agent,
    Contact? client,
    Listing? listing,
    Location? location,
    Organization? org,
    Property? property,
    List<Document>? documents,
    List<MortgagePreApproval>? mortgagePreApprovals,
    List<Payout>? payouts,
    List<SolicitorManagement>? solicitorManagements,
  }) {
    return Deal(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      listingId: listingId ?? this.listingId,
      propertyId: propertyId ?? this.propertyId,
      clientId: clientId ?? this.clientId,
      agentId: agentId ?? this.agentId,
      locationId: locationId ?? this.locationId,
      dealStatus: dealStatus ?? this.dealStatus,
      dealType: dealType ?? this.dealType,
      offerPrice: offerPrice ?? this.offerPrice,
      listPrice: listPrice ?? this.listPrice,
      salePrice: salePrice ?? this.salePrice,
      commissionRate: commissionRate ?? this.commissionRate,
      commissionAmount: commissionAmount ?? this.commissionAmount,
      closingDate: closingDate ?? this.closingDate,
      financingType: financingType ?? this.financingType,
      loanAmount: loanAmount ?? this.loanAmount,
      downPayment: downPayment ?? this.downPayment,
      earnestMoney: earnestMoney ?? this.earnestMoney,
      escrowAmount: escrowAmount ?? this.escrowAmount,
      closingCosts: closingCosts ?? this.closingCosts,
      sellerConcessions: sellerConcessions ?? this.sellerConcessions,
      buyerCredits: buyerCredits ?? this.buyerCredits,
      inspectionPeriod: inspectionPeriod ?? this.inspectionPeriod,
      financingContingency: financingContingency ?? this.financingContingency,
      appraisalContingency: appraisalContingency ?? this.appraisalContingency,
      titleContingency: titleContingency ?? this.titleContingency,
      attorneyReview: attorneyReview ?? this.attorneyReview,
      multipleOffers: multipleOffers ?? this.multipleOffers,
      createdBy: createdBy ?? this.createdBy,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      attorney: attorney ?? this.attorney,
      agent: agent ?? this.agent,
      client: client ?? this.client,
      listing: listing ?? this.listing,
      location: location ?? this.location,
      org: org ?? this.org,
      property: property ?? this.property,
      documents: documents ?? this.documents,
      mortgagePreApprovals: mortgagePreApprovals ?? this.mortgagePreApprovals,
      payouts: payouts ?? this.payouts,
      solicitorManagements: solicitorManagements ?? this.solicitorManagements,
    );
  }
}
