
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'document_type_u_s_a.dart';
import 'compliance_type.dart';
import 'contract.dart';
import 'deal.dart';
import 'listing.dart';
import 'organization.dart';
import 'property.dart';
import 'user.dart';
import 'document_analysis.dart';
import 'analysis_job.dart';


class Document implements PrismaModel<String, Document> , Id<String> {
    @override
String? id;
	String? orgId;
	String? dealId;
	String? propertyId;
	String? contractId;
	String? userId;
	String? listingId;
	DocumentTypeUSA? documentType;
	String? title;
	String? description;
	String? fileUrl;
	String? fileName;
	int? fileSize;
	String? mimeType;
	String? checksum;
	int? version;
	bool? isRequired;
	bool? isSigned;
	bool? signatureRequired;
	bool? notarizationRequired;
	bool? recordingRequired;
	DateTime? expiryDate;
	ComplianceType? complianceType;
	String? jurisdiction;
	String? templateId;
	List<String>? tags;
	String? analysisStatus;
	DateTime? lastAnalyzedAt;
	String? analysisJobId;
	dynamic duplicates;
	String? searchVector;
	String? createdBy;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	Contract? contract;
	Deal? deal;
	Listing? listing;
	Organization? org;
	Property? property;
	User? user;
	List<DocumentAnalysis>? analyses;
	List<AnalysisJob>? analysisJobs;
	int? $tagsCount;
	int? $analysesCount;
	int? $analysisJobsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Document({ this.id,
	 this.orgId,
	 this.dealId,
	 this.propertyId,
	 this.contractId,
	 this.userId,
	 this.listingId,
	 this.documentType,
	 this.title,
	 this.description,
	 this.fileUrl,
	 this.fileName,
	 this.fileSize,
	 this.mimeType,
	 this.checksum,
	 this.version = 1,
	 this.isRequired = false,
	 this.isSigned = false,
	 this.signatureRequired = false,
	 this.notarizationRequired = false,
	 this.recordingRequired = false,
	 this.expiryDate,
	 this.complianceType,
	 this.jurisdiction,
	 this.templateId,
	 this.tags,
	 this.analysisStatus = "PENDING",
	 this.lastAnalyzedAt,
	 this.analysisJobId,
	required this.duplicates,
	 this.searchVector,
	 this.createdBy,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.contract,
	 this.deal,
	 this.listing,
	 this.org,
	 this.property,
	 this.user,
	 this.analyses,
	 this.analysisJobs,
	this.$tagsCount,
	this.$analysesCount,
	this.$analysisJobsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Document, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"dealId": (m) => m.dealId,

	"propertyId": (m) => m.propertyId,

	"contractId": (m) => m.contractId,

	"userId": (m) => m.userId,

	"listingId": (m) => m.listingId,

	"documentType": (m) => m.documentType,

	"title": (m) => m.title,

	"description": (m) => m.description,

	"fileUrl": (m) => m.fileUrl,

	"fileName": (m) => m.fileName,

	"fileSize": (m) => m.fileSize,

	"mimeType": (m) => m.mimeType,

	"checksum": (m) => m.checksum,

	"version": (m) => m.version,

	"isRequired": (m) => m.isRequired,

	"isSigned": (m) => m.isSigned,

	"signatureRequired": (m) => m.signatureRequired,

	"notarizationRequired": (m) => m.notarizationRequired,

	"recordingRequired": (m) => m.recordingRequired,

	"expiryDate": (m) => m.expiryDate,

	"complianceType": (m) => m.complianceType,

	"jurisdiction": (m) => m.jurisdiction,

	"templateId": (m) => m.templateId,

	"tags": (m) => m.tags,

	"analysisStatus": (m) => m.analysisStatus,

	"lastAnalyzedAt": (m) => m.lastAnalyzedAt,

	"analysisJobId": (m) => m.analysisJobId,

	"duplicates": (m) => m.duplicates,

	"searchVector": (m) => m.searchVector,

	"createdBy": (m) => m.createdBy,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"contract": (m) => m.contract,

	"deal": (m) => m.deal,

	"listing": (m) => m.listing,

	"org": (m) => m.org,

	"property": (m) => m.property,

	"user": (m) => m.user,

	"analyses": (m) => m.analyses,

	"analysisJobs": (m) => m.analysisJobs,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Document) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Document');
    }
    return propFunction as V? Function(Document);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Document.fromJson(JsonMap json) =>
      Document(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	dealId: json['dealId'] as String?,
	propertyId: json['propertyId'] as String?,
	contractId: json['contractId'] as String?,
	userId: json['userId'] as String?,
	listingId: json['listingId'] as String?,
	documentType: json['documentType'] != null ? DocumentTypeUSA.fromJson(json['documentType']) : null,
	title: json['title'] as String?,
	description: json['description'] as String?,
	fileUrl: json['fileUrl'] as String?,
	fileName: json['fileName'] as String?,
	fileSize: int.tryParse(json['fileSize'].toString()),
	mimeType: json['mimeType'] as String?,
	checksum: json['checksum'] as String?,
	version: int.tryParse(json['version'].toString()),
	isRequired: json['isRequired'] as bool?,
	isSigned: json['isSigned'] as bool?,
	signatureRequired: json['signatureRequired'] as bool?,
	notarizationRequired: json['notarizationRequired'] as bool?,
	recordingRequired: json['recordingRequired'] as bool?,
	expiryDate: json['expiryDate'] != null ? DateTime.parse(json['expiryDate']) : null,
	complianceType: json['complianceType'] != null ? ComplianceType.fromJson(json['complianceType']) : null,
	jurisdiction: json['jurisdiction'] as String?,
	templateId: json['templateId'] as String?,
	tags: json['tags'] != null ? (json['tags'] as List<dynamic>).map((e) => e.toString()).toList() : null,
	analysisStatus: json['analysisStatus'] as String?,
	lastAnalyzedAt: json['lastAnalyzedAt'] != null ? DateTime.parse(json['lastAnalyzedAt']) : null,
	analysisJobId: json['analysisJobId'] as String?,
	duplicates: json['duplicates'] as dynamic,
	searchVector: json['searchVector'] as String?,
	createdBy: json['createdBy'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	contract: json['contract'] != null ? Contract.fromJson(json['contract'] as JsonMap) : null,
	deal: json['deal'] != null ? Deal.fromJson(json['deal'] as JsonMap) : null,
	listing: json['listing'] != null ? Listing.fromJson(json['listing'] as JsonMap) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	property: json['property'] != null ? Property.fromJson(json['property'] as JsonMap) : null,
	user: json['user'] != null ? User.fromJson(json['user'] as JsonMap) : null,
	analyses: json['analyses'] != null ? createModels<DocumentAnalysis>((json['analyses'] as List).cast<JsonMap>(), DocumentAnalysis.fromJson) : null,
	analysisJobs: json['analysisJobs'] != null ? createModels<AnalysisJob>((json['analysisJobs'] as List).cast<JsonMap>(), AnalysisJob.fromJson) : null,
	$tagsCount: json['_count']?['tags'] as int?,
	$analysesCount: json['_count']?['analyses'] as int?,
	$analysisJobsCount: json['_count']?['analysisJobs'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Document copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<String?>? dealId,
		Value<String?>? propertyId,
		Value<String?>? contractId,
		Value<String?>? userId,
		Value<String?>? listingId,
		Value<DocumentTypeUSA?>? documentType,
		Value<String?>? title,
		Value<String?>? description,
		Value<String?>? fileUrl,
		Value<String?>? fileName,
		Value<int?>? fileSize,
		Value<String?>? mimeType,
		Value<String?>? checksum,
		Value<int?>? version,
		Value<bool?>? isRequired,
		Value<bool?>? isSigned,
		Value<bool?>? signatureRequired,
		Value<bool?>? notarizationRequired,
		Value<bool?>? recordingRequired,
		Value<DateTime?>? expiryDate,
		Value<ComplianceType?>? complianceType,
		Value<String?>? jurisdiction,
		Value<String?>? templateId,
		Value<List<String>?>? tags,
		Value<String?>? analysisStatus,
		Value<DateTime?>? lastAnalyzedAt,
		Value<String?>? analysisJobId,
		Value<dynamic>? duplicates,
		Value<String?>? searchVector,
		Value<String?>? createdBy,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<Contract?>? contract,
		Value<Deal?>? deal,
		Value<Listing?>? listing,
		Value<Organization?>? org,
		Value<Property?>? property,
		Value<User?>? user,
		Value<List<DocumentAnalysis>?>? analyses,
		Value<List<AnalysisJob>?>? analysisJobs,
		int? $tagsCount,
		int? $analysesCount,
		int? $analysisJobsCount,
        }) {
        return Document(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		dealId: dealId != null ? dealId.value : this.dealId,
		propertyId: propertyId != null ? propertyId.value : this.propertyId,
		contractId: contractId != null ? contractId.value : this.contractId,
		userId: userId != null ? userId.value : this.userId,
		listingId: listingId != null ? listingId.value : this.listingId,
		documentType: documentType != null ? documentType.value : this.documentType,
		title: title != null ? title.value : this.title,
		description: description != null ? description.value : this.description,
		fileUrl: fileUrl != null ? fileUrl.value : this.fileUrl,
		fileName: fileName != null ? fileName.value : this.fileName,
		fileSize: fileSize != null ? fileSize.value : this.fileSize,
		mimeType: mimeType != null ? mimeType.value : this.mimeType,
		checksum: checksum != null ? checksum.value : this.checksum,
		version: version != null ? version.value : this.version,
		isRequired: isRequired != null ? isRequired.value : this.isRequired,
		isSigned: isSigned != null ? isSigned.value : this.isSigned,
		signatureRequired: signatureRequired != null ? signatureRequired.value : this.signatureRequired,
		notarizationRequired: notarizationRequired != null ? notarizationRequired.value : this.notarizationRequired,
		recordingRequired: recordingRequired != null ? recordingRequired.value : this.recordingRequired,
		expiryDate: expiryDate != null ? expiryDate.value : this.expiryDate,
		complianceType: complianceType != null ? complianceType.value : this.complianceType,
		jurisdiction: jurisdiction != null ? jurisdiction.value : this.jurisdiction,
		templateId: templateId != null ? templateId.value : this.templateId,
		tags: tags != null ? tags.value : this.tags,
		analysisStatus: analysisStatus != null ? analysisStatus.value : this.analysisStatus,
		lastAnalyzedAt: lastAnalyzedAt != null ? lastAnalyzedAt.value : this.lastAnalyzedAt,
		analysisJobId: analysisJobId != null ? analysisJobId.value : this.analysisJobId,
		duplicates: duplicates != null ? duplicates.value : this.duplicates,
		searchVector: searchVector != null ? searchVector.value : this.searchVector,
		createdBy: createdBy != null ? createdBy.value : this.createdBy,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		contract: contract != null ? contract.value : this.contract,
		deal: deal != null ? deal.value : this.deal,
		listing: listing != null ? listing.value : this.listing,
		org: org != null ? org.value : this.org,
		property: property != null ? property.value : this.property,
		user: user != null ? user.value : this.user,
		analyses: analyses != null ? analyses.value : this.analyses,
		analysisJobs: analysisJobs != null ? analysisJobs.value : this.analysisJobs,
		$tagsCount: $tagsCount ?? this.$tagsCount,
		$analysesCount: $analysesCount ?? this.$analysesCount,
		$analysisJobsCount: $analysisJobsCount ?? this.$analysisJobsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Document copyWithInstanceValues(Document document) {
        return Document(
            id: document.id ?? id,
		orgId: document.orgId ?? orgId,
		dealId: document.dealId ?? dealId,
		propertyId: document.propertyId ?? propertyId,
		contractId: document.contractId ?? contractId,
		userId: document.userId ?? userId,
		listingId: document.listingId ?? listingId,
		documentType: document.documentType ?? documentType,
		title: document.title ?? title,
		description: document.description ?? description,
		fileUrl: document.fileUrl ?? fileUrl,
		fileName: document.fileName ?? fileName,
		fileSize: document.fileSize ?? fileSize,
		mimeType: document.mimeType ?? mimeType,
		checksum: document.checksum ?? checksum,
		version: document.version ?? version,
		isRequired: document.isRequired ?? isRequired,
		isSigned: document.isSigned ?? isSigned,
		signatureRequired: document.signatureRequired ?? signatureRequired,
		notarizationRequired: document.notarizationRequired ?? notarizationRequired,
		recordingRequired: document.recordingRequired ?? recordingRequired,
		expiryDate: document.expiryDate ?? expiryDate,
		complianceType: document.complianceType ?? complianceType,
		jurisdiction: document.jurisdiction ?? jurisdiction,
		templateId: document.templateId ?? templateId,
		tags: document.tags ?? tags,
		analysisStatus: document.analysisStatus ?? analysisStatus,
		lastAnalyzedAt: document.lastAnalyzedAt ?? lastAnalyzedAt,
		analysisJobId: document.analysisJobId ?? analysisJobId,
		duplicates: document.duplicates ?? duplicates,
		searchVector: document.searchVector ?? searchVector,
		createdBy: document.createdBy ?? createdBy,
		createdAt: document.createdAt ?? createdAt,
		updatedAt: document.updatedAt ?? updatedAt,
		deletedAt: document.deletedAt ?? deletedAt,
		contract: document.contract ?? contract,
		deal: document.deal ?? deal,
		listing: document.listing ?? listing,
		org: document.org ?? org,
		property: document.property ?? property,
		user: document.user ?? user,
		analyses: document.analyses ?? analyses,
		analysisJobs: document.analysisJobs ?? analysisJobs,
		$tagsCount: document.$tagsCount ?? $tagsCount,
		$analysesCount: document.$analysesCount ?? $analysesCount,
		$analysisJobsCount: document.$analysisJobsCount ?? $analysisJobsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Document mergeWithInstanceValues(Document document) {
        return Document(
            id: document.$assignedFields.contains('id') ? document.id : id,
		orgId: document.$assignedFields.contains('orgId') ? document.orgId : orgId,
		dealId: document.$assignedFields.contains('dealId') ? document.dealId : dealId,
		propertyId: document.$assignedFields.contains('propertyId') ? document.propertyId : propertyId,
		contractId: document.$assignedFields.contains('contractId') ? document.contractId : contractId,
		userId: document.$assignedFields.contains('userId') ? document.userId : userId,
		listingId: document.$assignedFields.contains('listingId') ? document.listingId : listingId,
		documentType: document.$assignedFields.contains('documentType') ? document.documentType : documentType,
		title: document.$assignedFields.contains('title') ? document.title : title,
		description: document.$assignedFields.contains('description') ? document.description : description,
		fileUrl: document.$assignedFields.contains('fileUrl') ? document.fileUrl : fileUrl,
		fileName: document.$assignedFields.contains('fileName') ? document.fileName : fileName,
		fileSize: document.$assignedFields.contains('fileSize') ? document.fileSize : fileSize,
		mimeType: document.$assignedFields.contains('mimeType') ? document.mimeType : mimeType,
		checksum: document.$assignedFields.contains('checksum') ? document.checksum : checksum,
		version: document.$assignedFields.contains('version') ? document.version : version,
		isRequired: document.$assignedFields.contains('isRequired') ? document.isRequired : isRequired,
		isSigned: document.$assignedFields.contains('isSigned') ? document.isSigned : isSigned,
		signatureRequired: document.$assignedFields.contains('signatureRequired') ? document.signatureRequired : signatureRequired,
		notarizationRequired: document.$assignedFields.contains('notarizationRequired') ? document.notarizationRequired : notarizationRequired,
		recordingRequired: document.$assignedFields.contains('recordingRequired') ? document.recordingRequired : recordingRequired,
		expiryDate: document.$assignedFields.contains('expiryDate') ? document.expiryDate : expiryDate,
		complianceType: document.$assignedFields.contains('complianceType') ? document.complianceType : complianceType,
		jurisdiction: document.$assignedFields.contains('jurisdiction') ? document.jurisdiction : jurisdiction,
		templateId: document.$assignedFields.contains('templateId') ? document.templateId : templateId,
		tags: document.$assignedFields.contains('tags') ? document.tags : tags,
		analysisStatus: document.$assignedFields.contains('analysisStatus') ? document.analysisStatus : analysisStatus,
		lastAnalyzedAt: document.$assignedFields.contains('lastAnalyzedAt') ? document.lastAnalyzedAt : lastAnalyzedAt,
		analysisJobId: document.$assignedFields.contains('analysisJobId') ? document.analysisJobId : analysisJobId,
		duplicates: document.$assignedFields.contains('duplicates') ? document.duplicates : duplicates,
		searchVector: document.$assignedFields.contains('searchVector') ? document.searchVector : searchVector,
		createdBy: document.$assignedFields.contains('createdBy') ? document.createdBy : createdBy,
		createdAt: document.$assignedFields.contains('createdAt') ? document.createdAt : createdAt,
		updatedAt: document.$assignedFields.contains('updatedAt') ? document.updatedAt : updatedAt,
		deletedAt: document.$assignedFields.contains('deletedAt') ? document.deletedAt : deletedAt,
		contract: document.$assignedFields.contains('contract') ? document.contract : contract,
		deal: document.$assignedFields.contains('deal') ? document.deal : deal,
		listing: document.$assignedFields.contains('listing') ? document.listing : listing,
		org: document.$assignedFields.contains('org') ? document.org : org,
		property: document.$assignedFields.contains('property') ? document.property : property,
		user: document.$assignedFields.contains('user') ? document.user : user,
		analyses: (document.$assignedFields.contains('analyses') && document.analyses != null) ? mergeModelLists(analyses, document.analyses) : analyses,
		analysisJobs: (document.$assignedFields.contains('analysisJobs') && document.analysisJobs != null) ? mergeModelLists(analysisJobs, document.analysisJobs) : analysisJobs,
		$tagsCount: document.$tagsCount ?? $tagsCount,
		$analysesCount: document.$analysesCount ?? $analysesCount,
		$analysisJobsCount: document.$analysisJobsCount ?? $analysisJobsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Document updateWithInstanceValues(Document document) {
        if (document.$assignedFields.contains('id')) { id = document.id; }
		if (document.$assignedFields.contains('orgId')) { orgId = document.orgId; }
		if (document.$assignedFields.contains('dealId')) { dealId = document.dealId; }
		if (document.$assignedFields.contains('propertyId')) { propertyId = document.propertyId; }
		if (document.$assignedFields.contains('contractId')) { contractId = document.contractId; }
		if (document.$assignedFields.contains('userId')) { userId = document.userId; }
		if (document.$assignedFields.contains('listingId')) { listingId = document.listingId; }
		if (document.$assignedFields.contains('documentType')) { documentType = document.documentType; }
		if (document.$assignedFields.contains('title')) { title = document.title; }
		if (document.$assignedFields.contains('description')) { description = document.description; }
		if (document.$assignedFields.contains('fileUrl')) { fileUrl = document.fileUrl; }
		if (document.$assignedFields.contains('fileName')) { fileName = document.fileName; }
		if (document.$assignedFields.contains('fileSize')) { fileSize = document.fileSize; }
		if (document.$assignedFields.contains('mimeType')) { mimeType = document.mimeType; }
		if (document.$assignedFields.contains('checksum')) { checksum = document.checksum; }
		if (document.$assignedFields.contains('version')) { version = document.version; }
		if (document.$assignedFields.contains('isRequired')) { isRequired = document.isRequired; }
		if (document.$assignedFields.contains('isSigned')) { isSigned = document.isSigned; }
		if (document.$assignedFields.contains('signatureRequired')) { signatureRequired = document.signatureRequired; }
		if (document.$assignedFields.contains('notarizationRequired')) { notarizationRequired = document.notarizationRequired; }
		if (document.$assignedFields.contains('recordingRequired')) { recordingRequired = document.recordingRequired; }
		if (document.$assignedFields.contains('expiryDate')) { expiryDate = document.expiryDate; }
		if (document.$assignedFields.contains('complianceType')) { complianceType = document.complianceType; }
		if (document.$assignedFields.contains('jurisdiction')) { jurisdiction = document.jurisdiction; }
		if (document.$assignedFields.contains('templateId')) { templateId = document.templateId; }
		if (document.$assignedFields.contains('tags')) { tags = document.tags; }
		if (document.$assignedFields.contains('analysisStatus')) { analysisStatus = document.analysisStatus; }
		if (document.$assignedFields.contains('lastAnalyzedAt')) { lastAnalyzedAt = document.lastAnalyzedAt; }
		if (document.$assignedFields.contains('analysisJobId')) { analysisJobId = document.analysisJobId; }
		if (document.$assignedFields.contains('duplicates')) { duplicates = document.duplicates; }
		if (document.$assignedFields.contains('searchVector')) { searchVector = document.searchVector; }
		if (document.$assignedFields.contains('createdBy')) { createdBy = document.createdBy; }
		if (document.$assignedFields.contains('createdAt')) { createdAt = document.createdAt; }
		if (document.$assignedFields.contains('updatedAt')) { updatedAt = document.updatedAt; }
		if (document.$assignedFields.contains('deletedAt')) { deletedAt = document.deletedAt; }
		if (document.$assignedFields.contains('contract')) { contract = document.contract; }
		if (document.$assignedFields.contains('deal')) { deal = document.deal; }
		if (document.$assignedFields.contains('listing')) { listing = document.listing; }
		if (document.$assignedFields.contains('org')) { org = document.org; }
		if (document.$assignedFields.contains('property')) { property = document.property; }
		if (document.$assignedFields.contains('user')) { user = document.user; }
		if (document.$assignedFields.contains('analyses') && document.analyses != null) { analyses = mergeModelLists(analyses, document.analyses); }
		if (document.$assignedFields.contains('analysisJobs') && document.analysisJobs != null) { analysisJobs = mergeModelLists(analysisJobs, document.analysisJobs); }
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
          ? {...?serializedTypes, 'Document'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(dealId != null) 'dealId': dealId,
	if(propertyId != null) 'propertyId': propertyId,
	if(contractId != null) 'contractId': contractId,
	if(userId != null) 'userId': userId,
	if(listingId != null) 'listingId': listingId,
	if(documentType != null) 'documentType': documentType?.toJson(),
	if(title != null) 'title': title,
	if(description != null) 'description': description,
	if(fileUrl != null) 'fileUrl': fileUrl,
	if(fileName != null) 'fileName': fileName,
	if(fileSize != null) 'fileSize': fileSize,
	if(mimeType != null) 'mimeType': mimeType,
	if(checksum != null) 'checksum': checksum,
	if(version != null) 'version': version,
	if(isRequired != null) 'isRequired': isRequired,
	if(isSigned != null) 'isSigned': isSigned,
	if(signatureRequired != null) 'signatureRequired': signatureRequired,
	if(notarizationRequired != null) 'notarizationRequired': notarizationRequired,
	if(recordingRequired != null) 'recordingRequired': recordingRequired,
	if(expiryDate != null) 'expiryDate': expiryDate?.toIso8601String(),
	if(complianceType != null) 'complianceType': complianceType?.toJson(),
	if(jurisdiction != null) 'jurisdiction': jurisdiction,
	if(templateId != null) 'templateId': templateId,
	if(tags != null) 'tags': tags,
	if(analysisStatus != null) 'analysisStatus': analysisStatus,
	if(lastAnalyzedAt != null) 'lastAnalyzedAt': lastAnalyzedAt?.toIso8601String(),
	if(analysisJobId != null) 'analysisJobId': analysisJobId,
	if(duplicates != null) 'duplicates': duplicates,
	if(searchVector != null) 'searchVector': searchVector,
	if(createdBy != null) 'createdBy': createdBy,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(contract != null && (!preventCircularSerialization || !serializedModels.contains('Contract'))) 'contract': contract?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(deal != null && (!preventCircularSerialization || !serializedModels.contains('Deal'))) 'deal': deal?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(listing != null && (!preventCircularSerialization || !serializedModels.contains('Listing'))) 'listing': listing?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(property != null && (!preventCircularSerialization || !serializedModels.contains('Property'))) 'property': property?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(user != null && (!preventCircularSerialization || !serializedModels.contains('User'))) 'user': user?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(analyses != null && (!preventCircularSerialization || !serializedModels.contains('DocumentAnalysis'))) 'analyses': analyses?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(analysisJobs != null && (!preventCircularSerialization || !serializedModels.contains('AnalysisJob'))) 'analysisJobs': analysisJobs?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
		if ($tagsCount != null || $analysesCount != null || $analysisJobsCount != null) '_count': { 
		if ($tagsCount != null) 'tags': $tagsCount, 
		if ($analysesCount != null) 'analyses': $analysesCount, 
		if ($analysisJobsCount != null) 'analysisJobs': $analysisJobsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Document &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    