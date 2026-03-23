
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class DocumentStore extends ModelStreamStore<String, Document> {

  static DocumentStore? _instance;

  static DocumentStore get instance {
    _instance ??= DocumentStore();
    return _instance!;
  }

  DocumentStore() : super(Document.fromJson) {
    if (_instance != null) {
        throw Exception(
            'DocumentStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending DocumentStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use DocumentStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getDocumentId(Document document) => document.id;

	String? getDocumentOrgId(Document document) => document.orgId;

	String? getDocumentDealId(Document document) => document.dealId;

	String? getDocumentPropertyId(Document document) => document.propertyId;

	String? getDocumentContractId(Document document) => document.contractId;

	String? getDocumentUserId(Document document) => document.userId;

	String? getDocumentListingId(Document document) => document.listingId;

	DocumentTypeUSA? getDocumentDocumentType(Document document) => document.documentType;

	String? getDocumentTitle(Document document) => document.title;

	String? getDocumentDescription(Document document) => document.description;

	String? getDocumentFileUrl(Document document) => document.fileUrl;

	String? getDocumentFileName(Document document) => document.fileName;

	int? getDocumentFileSize(Document document) => document.fileSize;

	String? getDocumentMimeType(Document document) => document.mimeType;

	String? getDocumentChecksum(Document document) => document.checksum;

	int? getDocumentVersion(Document document) => document.version;

	bool? getDocumentIsRequired(Document document) => document.isRequired;

	bool? getDocumentIsSigned(Document document) => document.isSigned;

	bool? getDocumentSignatureRequired(Document document) => document.signatureRequired;

	bool? getDocumentNotarizationRequired(Document document) => document.notarizationRequired;

	bool? getDocumentRecordingRequired(Document document) => document.recordingRequired;

	DateTime? getDocumentExpiryDate(Document document) => document.expiryDate;

	ComplianceType? getDocumentComplianceType(Document document) => document.complianceType;

	String? getDocumentJurisdiction(Document document) => document.jurisdiction;

	String? getDocumentTemplateId(Document document) => document.templateId;

	List<String>? getDocumentTags(Document document) => document.tags;

	String? getDocumentAnalysisStatus(Document document) => document.analysisStatus;

	DateTime? getDocumentLastAnalyzedAt(Document document) => document.lastAnalyzedAt;

	String? getDocumentAnalysisJobId(Document document) => document.analysisJobId;

	dynamic? getDocumentDuplicates(Document document) => document.duplicates;

	String? getDocumentSearchVector(Document document) => document.searchVector;

	String? getDocumentCreatedBy(Document document) => document.createdBy;

	DateTime? getDocumentCreatedAt(Document document) => document.createdAt;

	DateTime? getDocumentUpdatedAt(Document document) => document.updatedAt;

	DateTime? getDocumentDeletedAt(Document document) => document.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  
Document? getByAnalysisJobId(
    String analysisJobId,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getIncluding(getDocumentAnalysisJobId, analysisJobId, modelFilter: modelFilter, includes: includes);

  
List<Document> getByOrgId(
    String orgId,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Document> getByDealId(
    String dealId,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentDealId, dealId, modelFilter: modelFilter, includes: includes);

	
List<Document> getByPropertyId(
    String propertyId,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Document> getByContractId(
    String contractId,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentContractId, contractId, modelFilter: modelFilter, includes: includes);

	
List<Document> getByUserId(
    String userId,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentUserId, userId, modelFilter: modelFilter, includes: includes);

	
List<Document> getByListingId(
    String listingId,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<Document> getByDocumentType(
    DocumentTypeUSA documentType,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentDocumentType, documentType, modelFilter: modelFilter, includes: includes);

	
List<Document> getByTitle(
    String title,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentTitle, title, modelFilter: modelFilter, includes: includes);

	
List<Document> getByDescription(
    String description,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Document> getByFileUrl(
    String fileUrl,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentFileUrl, fileUrl, modelFilter: modelFilter, includes: includes);

	
List<Document> getByFileName(
    String fileName,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentFileName, fileName, modelFilter: modelFilter, includes: includes);

	
List<Document> getByFileSize(
    int fileSize,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentFileSize, fileSize, modelFilter: modelFilter, includes: includes);

	
List<Document> getByMimeType(
    String mimeType,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentMimeType, mimeType, modelFilter: modelFilter, includes: includes);

	
List<Document> getByChecksum(
    String checksum,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentChecksum, checksum, modelFilter: modelFilter, includes: includes);

	
List<Document> getByVersion(
    int version,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentVersion, version, modelFilter: modelFilter, includes: includes);

	
List<Document> getByIsRequired(
    bool isRequired,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentIsRequired, isRequired, modelFilter: modelFilter, includes: includes);

	
List<Document> getByIsSigned(
    bool isSigned,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentIsSigned, isSigned, modelFilter: modelFilter, includes: includes);

	
List<Document> getBySignatureRequired(
    bool signatureRequired,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentSignatureRequired, signatureRequired, modelFilter: modelFilter, includes: includes);

	
List<Document> getByNotarizationRequired(
    bool notarizationRequired,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentNotarizationRequired, notarizationRequired, modelFilter: modelFilter, includes: includes);

	
List<Document> getByRecordingRequired(
    bool recordingRequired,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentRecordingRequired, recordingRequired, modelFilter: modelFilter, includes: includes);

	
List<Document> getByExpiryDate(
    DateTime expiryDate,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentExpiryDate, expiryDate, modelFilter: modelFilter, includes: includes);

	
List<Document> getByComplianceType(
    ComplianceType complianceType,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentComplianceType, complianceType, modelFilter: modelFilter, includes: includes);

	
List<Document> getByJurisdiction(
    String jurisdiction,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentJurisdiction, jurisdiction, modelFilter: modelFilter, includes: includes);

	
List<Document> getByTemplateId(
    String templateId,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentTemplateId, templateId, modelFilter: modelFilter, includes: includes);

	
List<Document> getByTags(
    String tags,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentTags, tags, modelFilter: modelFilter, includes: includes);

	
List<Document> getByAnalysisStatus(
    String analysisStatus,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentAnalysisStatus, analysisStatus, modelFilter: modelFilter, includes: includes);

	
List<Document> getByLastAnalyzedAt(
    DateTime lastAnalyzedAt,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentLastAnalyzedAt, lastAnalyzedAt, modelFilter: modelFilter, includes: includes);

	
List<Document> getByDuplicates(
    dynamic duplicates,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentDuplicates, duplicates, modelFilter: modelFilter, includes: includes);

	
List<Document> getBySearchVector(
    String searchVector,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentSearchVector, searchVector, modelFilter: modelFilter, includes: includes);

	
List<Document> getByCreatedBy(
    String createdBy,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Document> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Document> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Document> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}
    ) =>
    getManyIncluding(getDocumentDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contract? getContract(
    Document document, {ModelFilter? modelFilter, List<ContractInclude>? includes}) {
    if (document.contractId == null) {
        return null;
    } else {
        final contract = ContractStore.instance.getById(document.contractId!, includes: includes);
        document.contract = contract;
        // setIncludedReferences(contract, includes: includes);
        return contract;
    }
}

	Deal? getDeal(
    Document document, {ModelFilter? modelFilter, List<DealInclude>? includes}) {
    if (document.dealId == null) {
        return null;
    } else {
        final deal = DealStore.instance.getById(document.dealId!, includes: includes);
        document.deal = deal;
        // setIncludedReferences(deal, includes: includes);
        return deal;
    }
}

	Listing? getListing(
    Document document, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (document.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(document.listingId!, includes: includes);
        document.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    Document document, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (document.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(document.orgId!, includes: includes);
        document.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Property? getProperty(
    Document document, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (document.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(document.propertyId!, includes: includes);
        document.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

	User? getUser(
    Document document, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (document.userId == null) {
        return null;
    } else {
        final user = UserStore.instance.getById(document.userId!, includes: includes);
        document.user = user;
        // setIncludedReferences(user, includes: includes);
        return user;
    }
}

  /// GET RELATED MODELS 

  List<DocumentAnalysis> getAnalyses(
    Document document, {ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}) {
    final analyses = DocumentAnalysisStore.instance.getByDocumentId(document.$uid!, modelFilter: modelFilter, includes: includes);
    document.analyses = analyses;
    // setIncludedReferencesForList(analyses, includes: includes);
    return analyses;
}

	List<AnalysisJob> getAnalysisJobs(
    Document document, {ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}) {
    final analysisJobs = AnalysisJobStore.instance.getByDocumentId(document.$uid!, modelFilter: modelFilter, includes: includes);
    document.analysisJobs = analysisJobs;
    // setIncludedReferencesForList(analysisJobs, includes: includes);
    return analysisJobs;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Document>> getAll$({bool useCache = true, ModelFilter<Document>? modelFilter, List<DocumentInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: DocumentEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Document?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getDocumentId,
        value: id,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


	
    Stream<Document?> getByAnalysisJobId$(
        String analysisJobId,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getDocumentAnalysisJobId,
        value: analysisJobId,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getByAnalysisJobId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Document>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByDealId$(
        String dealId,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentDealId,
        value: dealId,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByDealId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByContractId$(
        String contractId,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentContractId,
        value: contractId,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByContractId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByUserId$(
        String userId,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentUserId,
        value: userId,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByDocumentType$(
        DocumentTypeUSA documentType,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DocumentTypeUSA>(
        getPropVal: getDocumentDocumentType,
        value: documentType,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByDocumentType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByFileUrl$(
        String fileUrl,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentFileUrl,
        value: fileUrl,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByFileUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByFileName$(
        String fileName,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentFileName,
        value: fileName,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByFileName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByFileSize$(
        int fileSize,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getDocumentFileSize,
        value: fileSize,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByFileSize,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByMimeType$(
        String mimeType,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentMimeType,
        value: mimeType,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByMimeType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByChecksum$(
        String checksum,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentChecksum,
        value: checksum,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByChecksum,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByVersion$(
        int version,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getDocumentVersion,
        value: version,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByVersion,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByIsRequired$(
        bool isRequired,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getDocumentIsRequired,
        value: isRequired,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByIsRequired,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByIsSigned$(
        bool isSigned,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getDocumentIsSigned,
        value: isSigned,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByIsSigned,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getBySignatureRequired$(
        bool signatureRequired,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getDocumentSignatureRequired,
        value: signatureRequired,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyBySignatureRequired,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByNotarizationRequired$(
        bool notarizationRequired,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getDocumentNotarizationRequired,
        value: notarizationRequired,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByNotarizationRequired,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByRecordingRequired$(
        bool recordingRequired,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<bool>(
        getPropVal: getDocumentRecordingRequired,
        value: recordingRequired,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByRecordingRequired,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByExpiryDate$(
        DateTime expiryDate,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDocumentExpiryDate,
        value: expiryDate,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByExpiryDate,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByComplianceType$(
        ComplianceType complianceType,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<ComplianceType>(
        getPropVal: getDocumentComplianceType,
        value: complianceType,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByComplianceType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByJurisdiction$(
        String jurisdiction,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentJurisdiction,
        value: jurisdiction,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByJurisdiction,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByTemplateId$(
        String templateId,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentTemplateId,
        value: templateId,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByTemplateId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByTags$(
        String tags,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentTags,
        value: tags,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByTags,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByAnalysisStatus$(
        String analysisStatus,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentAnalysisStatus,
        value: analysisStatus,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByAnalysisStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByLastAnalyzedAt$(
        DateTime lastAnalyzedAt,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDocumentLastAnalyzedAt,
        value: lastAnalyzedAt,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByLastAnalyzedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByDuplicates$(
        dynamic duplicates,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<dynamic>(
        getPropVal: getDocumentDuplicates,
        value: duplicates,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByDuplicates,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getBySearchVector$(
        String searchVector,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentSearchVector,
        value: searchVector,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyBySearchVector,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getDocumentCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDocumentCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDocumentUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Document>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Document>? modelFilter,
        List<DocumentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getDocumentDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: DocumentEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contract?> getContract$(
    Document document, {bool useCache = true, ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    if (document.contractId == null) {
        return Stream.value(null);
    } else {
        return ContractStore.instance.getById$(
            document.contractId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contract) {
            document.contract = contract;
        });
    }
}

	Stream<Deal?> getDeal$(
    Document document, {bool useCache = true, ModelFilter<Deal>? modelFilter, List<DealInclude>? includes}) {
    if (document.dealId == null) {
        return Stream.value(null);
    } else {
        return DealStore.instance.getById$(
            document.dealId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((deal) {
            document.deal = deal;
        });
    }
}

	Stream<Listing?> getListing$(
    Document document, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (document.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            document.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            document.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    Document document, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (document.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            document.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            document.org = org;
        });
    }
}

	Stream<Property?> getProperty$(
    Document document, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (document.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            document.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            document.property = property;
        });
    }
}

	Stream<User?> getUser$(
    Document document, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (document.userId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            document.userId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((user) {
            document.user = user;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<DocumentAnalysis>> getAnalyses$(
    Document document, {bool useCache = true, ModelFilter<DocumentAnalysis>? modelFilter, List<DocumentAnalysisInclude>? includes}) {
    return DocumentAnalysisStore.instance.getByDocumentId$(
        document.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((analyses) {
        document.analyses = analyses;
    });

}

	Stream<List<AnalysisJob>> getAnalysisJobs$(
    Document document, {bool useCache = true, ModelFilter<AnalysisJob>? modelFilter, List<AnalysisJobInclude>? includes}) {
    return AnalysisJobStore.instance.getByDocumentId$(
        document.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((analysisJobs) {
        document.analysisJobs = analysisJobs;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Document recursiveUpsert(Document document, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Document'} 
        : const {};
    if (document.contract != null && (!preventCircularSerialization || !upsertedTypes.contains('Contract'))) {
        document.contract = ContractStore.instance.recursiveUpsert(document.contract!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (document.deal != null && (!preventCircularSerialization || !upsertedTypes.contains('Deal'))) {
        document.deal = DealStore.instance.recursiveUpsert(document.deal!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (document.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        document.listing = ListingStore.instance.recursiveUpsert(document.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (document.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        document.org = OrganizationStore.instance.recursiveUpsert(document.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (document.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        document.property = PropertyStore.instance.recursiveUpsert(document.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (document.user != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        document.user = UserStore.instance.recursiveUpsert(document.user!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (document.analyses != null && (!preventCircularSerialization || !upsertedTypes.contains('DocumentAnalysis'))) {
        document.analyses = DocumentAnalysisStore.instance.recursiveListUpsert(document.analyses!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (document.analysisJobs != null && (!preventCircularSerialization || !upsertedTypes.contains('AnalysisJob'))) {
        document.analysisJobs = AnalysisJobStore.instance.recursiveListUpsert(document.analysisJobs!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(document);
}

  List<Document> recursiveListUpsert(List<Document> documents, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedDocuments = <Document>[];
    for (var document in documents) {
        updatedDocuments.add(recursiveUpsert(document, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedDocuments;
}

//   @override
//   Document upsert(Document item) {
//     return recursiveUpsert(item);
//   }

}


class DocumentInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      DocumentInclude.contract({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contract>? modelFilter,
    List<ContractInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (document) => DocumentStore.instance
            .getContract$(document, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (document) => DocumentStore.instance
            .getContract(document, modelFilter: modelFilter, includes: includes);
      }
}

	DocumentInclude.deal({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Deal>? modelFilter,
    List<DealInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (document) => DocumentStore.instance
            .getDeal$(document, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (document) => DocumentStore.instance
            .getDeal(document, modelFilter: modelFilter, includes: includes);
      }
}

	DocumentInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (document) => DocumentStore.instance
            .getListing$(document, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (document) => DocumentStore.instance
            .getListing(document, modelFilter: modelFilter, includes: includes);
      }
}

	DocumentInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (document) => DocumentStore.instance
            .getOrg$(document, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (document) => DocumentStore.instance
            .getOrg(document, modelFilter: modelFilter, includes: includes);
      }
}

	DocumentInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (document) => DocumentStore.instance
            .getProperty$(document, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (document) => DocumentStore.instance
            .getProperty(document, modelFilter: modelFilter, includes: includes);
      }
}

	DocumentInclude.user({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (document) => DocumentStore.instance
            .getUser$(document, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (document) => DocumentStore.instance
            .getUser(document, modelFilter: modelFilter, includes: includes);
      }
}

	DocumentInclude.analyses({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<DocumentAnalysis>? modelFilter,
    List<DocumentAnalysisInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (document) => DocumentStore.instance
            .getAnalyses$(document, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (document) => DocumentStore.instance
            .getAnalyses(document, modelFilter: modelFilter, includes: includes);
      }
}

	DocumentInclude.analysisJobs({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<AnalysisJob>? modelFilter,
    List<AnalysisJobInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (document) => DocumentStore.instance
            .getAnalysisJobs$(document, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (document) => DocumentStore.instance
            .getAnalysisJobs(document, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum DocumentEndpoints implements Endpoint {

    getAll('/document', HttpMethod.post, List<Document>),
	getById('/document/byId/:id', HttpMethod.post, Document),
	getManyByOrgId('/document/byOrgId/:orgId', HttpMethod.post, List<Document>),
	getManyByDealId('/document/byDealId/:dealId', HttpMethod.post, List<Document>),
	getManyByPropertyId('/document/byPropertyId/:propertyId', HttpMethod.post, List<Document>),
	getManyByContractId('/document/byContractId/:contractId', HttpMethod.post, List<Document>),
	getManyByUserId('/document/byUserId/:userId', HttpMethod.post, List<Document>),
	getManyByListingId('/document/byListingId/:listingId', HttpMethod.post, List<Document>),
	getManyByDocumentType('/document/byDocumentType/:documentType', HttpMethod.post, List<Document>),
	getManyByTitle('/document/byTitle/:title', HttpMethod.post, List<Document>),
	getManyByDescription('/document/byDescription/:description', HttpMethod.post, List<Document>),
	getManyByFileUrl('/document/byFileUrl/:fileUrl', HttpMethod.post, List<Document>),
	getManyByFileName('/document/byFileName/:fileName', HttpMethod.post, List<Document>),
	getManyByFileSize('/document/byFileSize/:fileSize', HttpMethod.post, List<Document>),
	getManyByMimeType('/document/byMimeType/:mimeType', HttpMethod.post, List<Document>),
	getManyByChecksum('/document/byChecksum/:checksum', HttpMethod.post, List<Document>),
	getManyByVersion('/document/byVersion/:version', HttpMethod.post, List<Document>),
	getManyByIsRequired('/document/byIsRequired/:isRequired', HttpMethod.post, List<Document>),
	getManyByIsSigned('/document/byIsSigned/:isSigned', HttpMethod.post, List<Document>),
	getManyBySignatureRequired('/document/bySignatureRequired/:signatureRequired', HttpMethod.post, List<Document>),
	getManyByNotarizationRequired('/document/byNotarizationRequired/:notarizationRequired', HttpMethod.post, List<Document>),
	getManyByRecordingRequired('/document/byRecordingRequired/:recordingRequired', HttpMethod.post, List<Document>),
	getManyByExpiryDate('/document/byExpiryDate/:expiryDate', HttpMethod.post, List<Document>),
	getManyByComplianceType('/document/byComplianceType/:complianceType', HttpMethod.post, List<Document>),
	getManyByJurisdiction('/document/byJurisdiction/:jurisdiction', HttpMethod.post, List<Document>),
	getManyByTemplateId('/document/byTemplateId/:templateId', HttpMethod.post, List<Document>),
	getManyByTags('/document/byTags/:tags', HttpMethod.post, List<Document>),
	getManyByAnalysisStatus('/document/byAnalysisStatus/:analysisStatus', HttpMethod.post, List<Document>),
	getManyByLastAnalyzedAt('/document/byLastAnalyzedAt/:lastAnalyzedAt', HttpMethod.post, List<Document>),
	getByAnalysisJobId('/document/byAnalysisJobId/:analysisJobId', HttpMethod.post, Document),
	getManyByDuplicates('/document/byDuplicates/:duplicates', HttpMethod.post, List<Document>),
	getManyBySearchVector('/document/bySearchVector/:searchVector', HttpMethod.post, List<Document>),
	getManyByCreatedBy('/document/byCreatedBy/:createdBy', HttpMethod.post, List<Document>),
	getManyByCreatedAt('/document/byCreatedAt/:createdAt', HttpMethod.post, List<Document>),
	getManyByUpdatedAt('/document/byUpdatedAt/:updatedAt', HttpMethod.post, List<Document>),
	getManyByDeletedAt('/document/byDeletedAt/:deletedAt', HttpMethod.post, List<Document>);

    const DocumentEndpoints(this.path, this.method, this.responseType);

    @override
  final String path;

  @override
  final HttpMethod method;

  final Type responseType;

  static String withPathParameter(String path, dynamic param) {
    final regex = RegExp(r':([a-zA-Z]+)');
    return path.replaceFirst(regex, param.toString());
  }
}
