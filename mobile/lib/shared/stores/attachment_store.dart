
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class AttachmentStore extends ModelStreamStore<String, Attachment> {

  static AttachmentStore? _instance;

  static AttachmentStore get instance {
    _instance ??= AttachmentStore();
    return _instance!;
  }

  AttachmentStore() : super(Attachment.fromJson) {
    if (_instance != null) {
        throw Exception(
            'AttachmentStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending AttachmentStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use AttachmentStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getAttachmentId(Attachment attachment) => attachment.id;

	String? getAttachmentOrgId(Attachment attachment) => attachment.orgId;

	String? getAttachmentPropertyId(Attachment attachment) => attachment.propertyId;

	String? getAttachmentEntityType(Attachment attachment) => attachment.entityType;

	String? getAttachmentEntityId(Attachment attachment) => attachment.entityId;

	String? getAttachmentFileName(Attachment attachment) => attachment.fileName;

	String? getAttachmentMimeType(Attachment attachment) => attachment.mimeType;

	int? getAttachmentSizeBytes(Attachment attachment) => attachment.sizeBytes;

	String? getAttachmentStorageKey(Attachment attachment) => attachment.storageKey;

	String? getAttachmentUrl(Attachment attachment) => attachment.url;

	String? getAttachmentChecksum(Attachment attachment) => attachment.checksum;

	String? getAttachmentCreatedBy(Attachment attachment) => attachment.createdBy;

	DateTime? getAttachmentCreatedAt(Attachment attachment) => attachment.createdAt;

	DateTime? getAttachmentUpdatedAt(Attachment attachment) => attachment.updatedAt;

	DateTime? getAttachmentDeletedAt(Attachment attachment) => attachment.deletedAt;

	String? getAttachmentTransactionId(Attachment attachment) => attachment.transactionId;

	String? getAttachmentTaskId(Attachment attachment) => attachment.taskId;

	String? getAttachmentMessageId(Attachment attachment) => attachment.messageId;

	String? getAttachmentPropertyComplianceId(Attachment attachment) => attachment.propertyComplianceId;

	String? getAttachmentReviewId(Attachment attachment) => attachment.reviewId;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Attachment> getByOrgId(
    String orgId,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByPropertyId(
    String propertyId,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByEntityType(
    String entityType,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentEntityType, entityType, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByEntityId(
    String entityId,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentEntityId, entityId, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByFileName(
    String fileName,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentFileName, fileName, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByMimeType(
    String mimeType,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentMimeType, mimeType, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getBySizeBytes(
    int sizeBytes,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentSizeBytes, sizeBytes, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByStorageKey(
    String storageKey,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentStorageKey, storageKey, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByUrl(
    String url,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentUrl, url, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByChecksum(
    String checksum,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentChecksum, checksum, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByCreatedBy(
    String createdBy,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByTransactionId(
    String transactionId,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentTransactionId, transactionId, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByTaskId(
    String taskId,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentTaskId, taskId, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByMessageId(
    String messageId,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentMessageId, messageId, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByPropertyComplianceId(
    String propertyComplianceId,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentPropertyComplianceId, propertyComplianceId, modelFilter: modelFilter, includes: includes);

	
List<Attachment> getByReviewId(
    String reviewId,
    {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}
    ) =>
    getManyIncluding(getAttachmentReviewId, reviewId, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Message? getMessage(
    Attachment attachment, {ModelFilter? modelFilter, List<MessageInclude>? includes}) {
    if (attachment.messageId == null) {
        return null;
    } else {
        final message = MessageStore.instance.getById(attachment.messageId!, includes: includes);
        attachment.message = message;
        // setIncludedReferences(message, includes: includes);
        return message;
    }
}

	Organization? getOrg(
    Attachment attachment, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (attachment.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(attachment.orgId!, includes: includes);
        attachment.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	PropertyCompliance? getPropertyCompliance(
    Attachment attachment, {ModelFilter? modelFilter, List<PropertyComplianceInclude>? includes}) {
    if (attachment.propertyComplianceId == null) {
        return null;
    } else {
        final propertyCompliance = PropertyComplianceStore.instance.getById(attachment.propertyComplianceId!, includes: includes);
        attachment.propertyCompliance = propertyCompliance;
        // setIncludedReferences(propertyCompliance, includes: includes);
        return propertyCompliance;
    }
}

	Property? getProperty(
    Attachment attachment, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (attachment.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(attachment.propertyId!, includes: includes);
        attachment.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

	Review? getReview(
    Attachment attachment, {ModelFilter? modelFilter, List<ReviewInclude>? includes}) {
    if (attachment.reviewId == null) {
        return null;
    } else {
        final review = ReviewStore.instance.getById(attachment.reviewId!, includes: includes);
        attachment.review = review;
        // setIncludedReferences(review, includes: includes);
        return review;
    }
}

	Task? getTask(
    Attachment attachment, {ModelFilter? modelFilter, List<TaskInclude>? includes}) {
    if (attachment.taskId == null) {
        return null;
    } else {
        final task = TaskStore.instance.getById(attachment.taskId!, includes: includes);
        attachment.task = task;
        // setIncludedReferences(task, includes: includes);
        return task;
    }
}

	FinancialRecord? getFinancialRecord(
    Attachment attachment, {ModelFilter? modelFilter, List<FinancialRecordInclude>? includes}) {
    if (attachment.transactionId == null) {
        return null;
    } else {
        final financialRecord = FinancialRecordStore.instance.getById(attachment.transactionId!, includes: includes);
        attachment.financialRecord = financialRecord;
        // setIncludedReferences(financialRecord, includes: includes);
        return financialRecord;
    }
}

  /// GET RELATED MODELS 

  

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Attachment>> getAll$({bool useCache = true, ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: AttachmentEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Attachment?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getAttachmentId,
        value: id,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Attachment>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByEntityType$(
        String entityType,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentEntityType,
        value: entityType,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByEntityType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByEntityId$(
        String entityId,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentEntityId,
        value: entityId,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByEntityId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByFileName$(
        String fileName,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentFileName,
        value: fileName,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByFileName,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByMimeType$(
        String mimeType,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentMimeType,
        value: mimeType,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByMimeType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getBySizeBytes$(
        int sizeBytes,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getAttachmentSizeBytes,
        value: sizeBytes,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyBySizeBytes,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByStorageKey$(
        String storageKey,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentStorageKey,
        value: storageKey,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByStorageKey,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByUrl$(
        String url,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentUrl,
        value: url,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByUrl,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByChecksum$(
        String checksum,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentChecksum,
        value: checksum,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByChecksum,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAttachmentCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAttachmentUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getAttachmentDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByTransactionId$(
        String transactionId,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentTransactionId,
        value: transactionId,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByTransactionId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByTaskId$(
        String taskId,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentTaskId,
        value: taskId,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByTaskId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByMessageId$(
        String messageId,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentMessageId,
        value: messageId,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByMessageId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByPropertyComplianceId$(
        String propertyComplianceId,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentPropertyComplianceId,
        value: propertyComplianceId,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByPropertyComplianceId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Attachment>> getByReviewId$(
        String reviewId,
        {bool useCache = true,
        ModelFilter<Attachment>? modelFilter,
        List<AttachmentInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getAttachmentReviewId,
        value: reviewId,
        modelFilter: modelFilter,
        endpoint: AttachmentEndpoints.getManyByReviewId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Message?> getMessage$(
    Attachment attachment, {bool useCache = true, ModelFilter<Message>? modelFilter, List<MessageInclude>? includes}) {
    if (attachment.messageId == null) {
        return Stream.value(null);
    } else {
        return MessageStore.instance.getById$(
            attachment.messageId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((message) {
            attachment.message = message;
        });
    }
}

	Stream<Organization?> getOrg$(
    Attachment attachment, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (attachment.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            attachment.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            attachment.org = org;
        });
    }
}

	Stream<PropertyCompliance?> getPropertyCompliance$(
    Attachment attachment, {bool useCache = true, ModelFilter<PropertyCompliance>? modelFilter, List<PropertyComplianceInclude>? includes}) {
    if (attachment.propertyComplianceId == null) {
        return Stream.value(null);
    } else {
        return PropertyComplianceStore.instance.getById$(
            attachment.propertyComplianceId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((propertyCompliance) {
            attachment.propertyCompliance = propertyCompliance;
        });
    }
}

	Stream<Property?> getProperty$(
    Attachment attachment, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (attachment.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            attachment.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            attachment.property = property;
        });
    }
}

	Stream<Review?> getReview$(
    Attachment attachment, {bool useCache = true, ModelFilter<Review>? modelFilter, List<ReviewInclude>? includes}) {
    if (attachment.reviewId == null) {
        return Stream.value(null);
    } else {
        return ReviewStore.instance.getById$(
            attachment.reviewId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((review) {
            attachment.review = review;
        });
    }
}

	Stream<Task?> getTask$(
    Attachment attachment, {bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    if (attachment.taskId == null) {
        return Stream.value(null);
    } else {
        return TaskStore.instance.getById$(
            attachment.taskId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((task) {
            attachment.task = task;
        });
    }
}

	Stream<FinancialRecord?> getFinancialRecord$(
    Attachment attachment, {bool useCache = true, ModelFilter<FinancialRecord>? modelFilter, List<FinancialRecordInclude>? includes}) {
    if (attachment.transactionId == null) {
        return Stream.value(null);
    } else {
        return FinancialRecordStore.instance.getById$(
            attachment.transactionId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((financialRecord) {
            attachment.financialRecord = financialRecord;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Attachment recursiveUpsert(Attachment attachment, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Attachment'} 
        : const {};
    if (attachment.message != null && (!preventCircularSerialization || !upsertedTypes.contains('Message'))) {
        attachment.message = MessageStore.instance.recursiveUpsert(attachment.message!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (attachment.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        attachment.org = OrganizationStore.instance.recursiveUpsert(attachment.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (attachment.propertyCompliance != null && (!preventCircularSerialization || !upsertedTypes.contains('PropertyCompliance'))) {
        attachment.propertyCompliance = PropertyComplianceStore.instance.recursiveUpsert(attachment.propertyCompliance!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (attachment.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        attachment.property = PropertyStore.instance.recursiveUpsert(attachment.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (attachment.review != null && (!preventCircularSerialization || !upsertedTypes.contains('Review'))) {
        attachment.review = ReviewStore.instance.recursiveUpsert(attachment.review!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (attachment.task != null && (!preventCircularSerialization || !upsertedTypes.contains('Task'))) {
        attachment.task = TaskStore.instance.recursiveUpsert(attachment.task!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (attachment.financialRecord != null && (!preventCircularSerialization || !upsertedTypes.contains('FinancialRecord'))) {
        attachment.financialRecord = FinancialRecordStore.instance.recursiveUpsert(attachment.financialRecord!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(attachment);
}

  List<Attachment> recursiveListUpsert(List<Attachment> attachments, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedAttachments = <Attachment>[];
    for (var attachment in attachments) {
        updatedAttachments.add(recursiveUpsert(attachment, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedAttachments;
}

//   @override
//   Attachment upsert(Attachment item) {
//     return recursiveUpsert(item);
//   }

}


class AttachmentInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      AttachmentInclude.message({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Message>? modelFilter,
    List<MessageInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (attachment) => AttachmentStore.instance
            .getMessage$(attachment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (attachment) => AttachmentStore.instance
            .getMessage(attachment, modelFilter: modelFilter, includes: includes);
      }
}

	AttachmentInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (attachment) => AttachmentStore.instance
            .getOrg$(attachment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (attachment) => AttachmentStore.instance
            .getOrg(attachment, modelFilter: modelFilter, includes: includes);
      }
}

	AttachmentInclude.propertyCompliance({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<PropertyCompliance>? modelFilter,
    List<PropertyComplianceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (attachment) => AttachmentStore.instance
            .getPropertyCompliance$(attachment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (attachment) => AttachmentStore.instance
            .getPropertyCompliance(attachment, modelFilter: modelFilter, includes: includes);
      }
}

	AttachmentInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (attachment) => AttachmentStore.instance
            .getProperty$(attachment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (attachment) => AttachmentStore.instance
            .getProperty(attachment, modelFilter: modelFilter, includes: includes);
      }
}

	AttachmentInclude.review({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Review>? modelFilter,
    List<ReviewInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (attachment) => AttachmentStore.instance
            .getReview$(attachment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (attachment) => AttachmentStore.instance
            .getReview(attachment, modelFilter: modelFilter, includes: includes);
      }
}

	AttachmentInclude.task({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Task>? modelFilter,
    List<TaskInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (attachment) => AttachmentStore.instance
            .getTask$(attachment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (attachment) => AttachmentStore.instance
            .getTask(attachment, modelFilter: modelFilter, includes: includes);
      }
}

	AttachmentInclude.financialRecord({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<FinancialRecord>? modelFilter,
    List<FinancialRecordInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (attachment) => AttachmentStore.instance
            .getFinancialRecord$(attachment, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (attachment) => AttachmentStore.instance
            .getFinancialRecord(attachment, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum AttachmentEndpoints implements Endpoint {

    getAll('/attachment', HttpMethod.post, List<Attachment>),
	getById('/attachment/byId/:id', HttpMethod.post, Attachment),
	getManyByOrgId('/attachment/byOrgId/:orgId', HttpMethod.post, List<Attachment>),
	getManyByPropertyId('/attachment/byPropertyId/:propertyId', HttpMethod.post, List<Attachment>),
	getManyByEntityType('/attachment/byEntityType/:entityType', HttpMethod.post, List<Attachment>),
	getManyByEntityId('/attachment/byEntityId/:entityId', HttpMethod.post, List<Attachment>),
	getManyByFileName('/attachment/byFileName/:fileName', HttpMethod.post, List<Attachment>),
	getManyByMimeType('/attachment/byMimeType/:mimeType', HttpMethod.post, List<Attachment>),
	getManyBySizeBytes('/attachment/bySizeBytes/:sizeBytes', HttpMethod.post, List<Attachment>),
	getManyByStorageKey('/attachment/byStorageKey/:storageKey', HttpMethod.post, List<Attachment>),
	getManyByUrl('/attachment/byUrl/:url', HttpMethod.post, List<Attachment>),
	getManyByChecksum('/attachment/byChecksum/:checksum', HttpMethod.post, List<Attachment>),
	getManyByCreatedBy('/attachment/byCreatedBy/:createdBy', HttpMethod.post, List<Attachment>),
	getManyByCreatedAt('/attachment/byCreatedAt/:createdAt', HttpMethod.post, List<Attachment>),
	getManyByUpdatedAt('/attachment/byUpdatedAt/:updatedAt', HttpMethod.post, List<Attachment>),
	getManyByDeletedAt('/attachment/byDeletedAt/:deletedAt', HttpMethod.post, List<Attachment>),
	getManyByTransactionId('/attachment/byTransactionId/:transactionId', HttpMethod.post, List<Attachment>),
	getManyByTaskId('/attachment/byTaskId/:taskId', HttpMethod.post, List<Attachment>),
	getManyByMessageId('/attachment/byMessageId/:messageId', HttpMethod.post, List<Attachment>),
	getManyByPropertyComplianceId('/attachment/byPropertyComplianceId/:propertyComplianceId', HttpMethod.post, List<Attachment>),
	getManyByReviewId('/attachment/byReviewId/:reviewId', HttpMethod.post, List<Attachment>);

    const AttachmentEndpoints(this.path, this.method, this.responseType);

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
