
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

part of '../../gen_models/abcx3_stores_library.dart';

class TaskStore extends ModelStreamStore<String, Task> {

  static TaskStore? _instance;

  static TaskStore get instance {
    _instance ??= TaskStore();
    return _instance!;
  }

  TaskStore() : super(Task.fromJson) {
    if (_instance != null) {
        throw Exception(
            'TaskStore is a singleton class and an instance of it already exists. '
                'This can happen if you are extending TaskStore, so it is recommended to NOT extend the store classes. '
                'Instead you should use TaskStore.instance to access the store instance. ');
      }
      _instance = this;
  }

  /// GET PROPERTIES FROM MODEL

  String? getTaskId(Task task) => task.id;

	String? getTaskOrgId(Task task) => task.orgId;

	String? getTaskPropertyId(Task task) => task.propertyId;

	String? getTaskListingId(Task task) => task.listingId;

	String? getTaskLeaseId(Task task) => task.leaseId;

	String? getTaskBookingId(Task task) => task.bookingId;

	String? getTaskContractId(Task task) => task.contractId;

	String? getTaskReservationId(Task task) => task.reservationId;

	String? getTaskProjectId(Task task) => task.projectId;

	TaskType? getTaskType(Task task) => task.type;

	TaskStatus? getTaskStatus(Task task) => task.status;

	Priority? getTaskPriority(Task task) => task.priority;

	String? getTaskTitle(Task task) => task.title;

	String? getTaskDescription(Task task) => task.description;

	DateTime? getTaskDueAt(Task task) => task.dueAt;

	int? getTaskSlaHours(Task task) => task.slaHours;

	String? getTaskAssignedToUserId(Task task) => task.assignedToUserId;

	String? getTaskAssignedToContactId(Task task) => task.assignedToContactId;

	String? getTaskCreatedBy(Task task) => task.createdBy;

	DateTime? getTaskCreatedAt(Task task) => task.createdAt;

	DateTime? getTaskUpdatedAt(Task task) => task.updatedAt;

	DateTime? getTaskDeletedAt(Task task) => task.deletedAt;

  /// GET THIS MODEL(S) BY PROPERTY VALUE

  

  
List<Task> getByOrgId(
    String orgId,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskOrgId, orgId, modelFilter: modelFilter, includes: includes);

	
List<Task> getByPropertyId(
    String propertyId,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskPropertyId, propertyId, modelFilter: modelFilter, includes: includes);

	
List<Task> getByListingId(
    String listingId,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskListingId, listingId, modelFilter: modelFilter, includes: includes);

	
List<Task> getByLeaseId(
    String leaseId,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskLeaseId, leaseId, modelFilter: modelFilter, includes: includes);

	
List<Task> getByBookingId(
    String bookingId,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskBookingId, bookingId, modelFilter: modelFilter, includes: includes);

	
List<Task> getByContractId(
    String contractId,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskContractId, contractId, modelFilter: modelFilter, includes: includes);

	
List<Task> getByReservationId(
    String reservationId,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskReservationId, reservationId, modelFilter: modelFilter, includes: includes);

	
List<Task> getByProjectId(
    String projectId,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskProjectId, projectId, modelFilter: modelFilter, includes: includes);

	
List<Task> getByType(
    TaskType type,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskType, type, modelFilter: modelFilter, includes: includes);

	
List<Task> getByStatus(
    TaskStatus status,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskStatus, status, modelFilter: modelFilter, includes: includes);

	
List<Task> getByPriority(
    Priority priority,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskPriority, priority, modelFilter: modelFilter, includes: includes);

	
List<Task> getByTitle(
    String title,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskTitle, title, modelFilter: modelFilter, includes: includes);

	
List<Task> getByDescription(
    String description,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskDescription, description, modelFilter: modelFilter, includes: includes);

	
List<Task> getByDueAt(
    DateTime dueAt,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskDueAt, dueAt, modelFilter: modelFilter, includes: includes);

	
List<Task> getBySlaHours(
    int slaHours,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskSlaHours, slaHours, modelFilter: modelFilter, includes: includes);

	
List<Task> getByAssignedToUserId(
    String assignedToUserId,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskAssignedToUserId, assignedToUserId, modelFilter: modelFilter, includes: includes);

	
List<Task> getByAssignedToContactId(
    String assignedToContactId,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskAssignedToContactId, assignedToContactId, modelFilter: modelFilter, includes: includes);

	
List<Task> getByCreatedBy(
    String createdBy,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskCreatedBy, createdBy, modelFilter: modelFilter, includes: includes);

	
List<Task> getByCreatedAt(
    DateTime createdAt,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskCreatedAt, createdAt, modelFilter: modelFilter, includes: includes);

	
List<Task> getByUpdatedAt(
    DateTime updatedAt,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskUpdatedAt, updatedAt, modelFilter: modelFilter, includes: includes);

	
List<Task> getByDeletedAt(
    DateTime deletedAt,
    {ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}
    ) =>
    getManyIncluding(getTaskDeletedAt, deletedAt, modelFilter: modelFilter, includes: includes);

  // GET THIS MODEL BY RELATED MODEL ID IN MANY TO MANY RELATION

  

  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL

  Contact? getAssignedContact(
    Task task, {ModelFilter? modelFilter, List<ContactInclude>? includes}) {
    if (task.assignedToContactId == null) {
        return null;
    } else {
        final assignedContact = ContactStore.instance.getById(task.assignedToContactId!, includes: includes);
        task.assignedContact = assignedContact;
        // setIncludedReferences(assignedContact, includes: includes);
        return assignedContact;
    }
}

	User? getAssignedUser(
    Task task, {ModelFilter? modelFilter, List<UserInclude>? includes}) {
    if (task.assignedToUserId == null) {
        return null;
    } else {
        final assignedUser = UserStore.instance.getById(task.assignedToUserId!, includes: includes);
        task.assignedUser = assignedUser;
        // setIncludedReferences(assignedUser, includes: includes);
        return assignedUser;
    }
}

	Booking? getBooking(
    Task task, {ModelFilter? modelFilter, List<BookingInclude>? includes}) {
    if (task.bookingId == null) {
        return null;
    } else {
        final booking = BookingStore.instance.getById(task.bookingId!, includes: includes);
        task.booking = booking;
        // setIncludedReferences(booking, includes: includes);
        return booking;
    }
}

	Contract? getContract(
    Task task, {ModelFilter? modelFilter, List<ContractInclude>? includes}) {
    if (task.contractId == null) {
        return null;
    } else {
        final contract = ContractStore.instance.getById(task.contractId!, includes: includes);
        task.contract = contract;
        // setIncludedReferences(contract, includes: includes);
        return contract;
    }
}

	Lease? getLease(
    Task task, {ModelFilter? modelFilter, List<LeaseInclude>? includes}) {
    if (task.leaseId == null) {
        return null;
    } else {
        final lease = LeaseStore.instance.getById(task.leaseId!, includes: includes);
        task.lease = lease;
        // setIncludedReferences(lease, includes: includes);
        return lease;
    }
}

	Listing? getListing(
    Task task, {ModelFilter? modelFilter, List<ListingInclude>? includes}) {
    if (task.listingId == null) {
        return null;
    } else {
        final listing = ListingStore.instance.getById(task.listingId!, includes: includes);
        task.listing = listing;
        // setIncludedReferences(listing, includes: includes);
        return listing;
    }
}

	Organization? getOrg(
    Task task, {ModelFilter? modelFilter, List<OrganizationInclude>? includes}) {
    if (task.orgId == null) {
        return null;
    } else {
        final org = OrganizationStore.instance.getById(task.orgId!, includes: includes);
        task.org = org;
        // setIncludedReferences(org, includes: includes);
        return org;
    }
}

	Project? getProject(
    Task task, {ModelFilter? modelFilter, List<ProjectInclude>? includes}) {
    if (task.projectId == null) {
        return null;
    } else {
        final project = ProjectStore.instance.getById(task.projectId!, includes: includes);
        task.project = project;
        // setIncludedReferences(project, includes: includes);
        return project;
    }
}

	Property? getProperty(
    Task task, {ModelFilter? modelFilter, List<PropertyInclude>? includes}) {
    if (task.propertyId == null) {
        return null;
    } else {
        final property = PropertyStore.instance.getById(task.propertyId!, includes: includes);
        task.property = property;
        // setIncludedReferences(property, includes: includes);
        return property;
    }
}

	Reservation? getReservation(
    Task task, {ModelFilter? modelFilter, List<ReservationInclude>? includes}) {
    if (task.reservationId == null) {
        return null;
    } else {
        final reservation = ReservationStore.instance.getById(task.reservationId!, includes: includes);
        task.reservation = reservation;
        // setIncludedReferences(reservation, includes: includes);
        return reservation;
    }
}

  /// GET RELATED MODELS 

  List<Attachment> getAttachments(
    Task task, {ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    final attachments = AttachmentStore.instance.getByTaskId(task.$uid!, modelFilter: modelFilter, includes: includes);
    task.attachments = attachments;
    // setIncludedReferencesForList(attachments, includes: includes);
    return attachments;
}

	List<Agent> getAgents(
    Task task, {ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    final agents = AgentStore.instance.getBy(task.$uid!, modelFilter: modelFilter, includes: includes);
    task.agents = agents;
    // setIncludedReferencesForList(agents, includes: includes);
    return agents;
}

	List<ExtraCharge> getExtraCharges(
    Task task, {ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    final extraCharges = ExtraChargeStore.instance.getBy(task.$uid!, modelFilter: modelFilter, includes: includes);
    task.extraCharges = extraCharges;
    // setIncludedReferencesForList(extraCharges, includes: includes);
    return extraCharges;
}

	List<Agency> getAgencies(
    Task task, {ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    final agencies = AgencyStore.instance.getBy(task.$uid!, modelFilter: modelFilter, includes: includes);
    task.agencies = agencies;
    // setIncludedReferencesForList(agencies, includes: includes);
    return agencies;
}

	List<IncludedService> getIncludedServices(
    Task task, {ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    final includedServices = IncludedServiceStore.instance.getBy(task.$uid!, modelFilter: modelFilter, includes: includes);
    task.includedServices = includedServices;
    // setIncludedReferencesForList(includedServices, includes: includes);
    return includedServices;
}

	List<Analytics> getAnalytics(
    Task task, {ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    final analytics = AnalyticsStore.instance.getByTaskId(task.$uid!, modelFilter: modelFilter, includes: includes);
    task.analytics = analytics;
    // setIncludedReferencesForList(analytics, includes: includes);
    return analytics;
}

	List<Mention> getMentions(
    Task task, {ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}) {
    final mentions = MentionStore.instance.getByTaskId(task.$uid!, modelFilter: modelFilter, includes: includes);
    task.mentions = mentions;
    // setIncludedReferencesForList(mentions, includes: includes);
    return mentions;
}

  //////// STREAM METHODS //////////

  /// GET THIS MODEL as STREAM

  Stream<List<Task>> getAll$({bool useCache = true, ModelFilter<Task>? modelFilter, List<TaskInclude>? includes}) {
    final allItems$ = getAllItems$(endpoint: TaskEndpoints.getAll, modelFilter: modelFilter, useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return allItems$;
      } else {
        return getManyIncluding$(allItems$, includes);
      }
    }


  
    Stream<Task?> getById$(
        String id,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final item$ = getByFieldValue$<String>(
        getPropVal: getTaskId,
        value: id,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getById,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return item$;
    } else {
        return getIncluding$(item$, includes);
    }
}


  
    Stream<List<Task>> getByOrgId$(
        String orgId,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaskOrgId,
        value: orgId,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByOrgId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByPropertyId$(
        String propertyId,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaskPropertyId,
        value: propertyId,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByPropertyId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByListingId$(
        String listingId,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaskListingId,
        value: listingId,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByListingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByLeaseId$(
        String leaseId,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaskLeaseId,
        value: leaseId,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByLeaseId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByBookingId$(
        String bookingId,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaskBookingId,
        value: bookingId,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByBookingId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByContractId$(
        String contractId,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaskContractId,
        value: contractId,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByContractId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByReservationId$(
        String reservationId,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaskReservationId,
        value: reservationId,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByReservationId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByProjectId$(
        String projectId,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaskProjectId,
        value: projectId,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByProjectId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByType$(
        TaskType type,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<TaskType>(
        getPropVal: getTaskType,
        value: type,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByType,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByStatus$(
        TaskStatus status,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<TaskStatus>(
        getPropVal: getTaskStatus,
        value: status,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByStatus,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByPriority$(
        Priority priority,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<Priority>(
        getPropVal: getTaskPriority,
        value: priority,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByPriority,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByTitle$(
        String title,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaskTitle,
        value: title,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByTitle,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByDescription$(
        String description,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaskDescription,
        value: description,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByDescription,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByDueAt$(
        DateTime dueAt,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTaskDueAt,
        value: dueAt,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByDueAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getBySlaHours$(
        int slaHours,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<int>(
        getPropVal: getTaskSlaHours,
        value: slaHours,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyBySlaHours,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByAssignedToUserId$(
        String assignedToUserId,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaskAssignedToUserId,
        value: assignedToUserId,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByAssignedToUserId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByAssignedToContactId$(
        String assignedToContactId,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaskAssignedToContactId,
        value: assignedToContactId,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByAssignedToContactId,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByCreatedBy$(
        String createdBy,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<String>(
        getPropVal: getTaskCreatedBy,
        value: createdBy,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByCreatedBy,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByCreatedAt$(
        DateTime createdAt,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTaskCreatedAt,
        value: createdAt,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByCreatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByUpdatedAt$(
        DateTime updatedAt,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTaskUpdatedAt,
        value: updatedAt,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByUpdatedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


	
    Stream<List<Task>> getByDeletedAt$(
        DateTime deletedAt,
        {bool useCache = true,
        ModelFilter<Task>? modelFilter,
        List<TaskInclude>? includes}) {
    final items$ = getManyByFieldValue$<DateTime>(
        getPropVal: getTaskDeletedAt,
        value: deletedAt,
        modelFilter: modelFilter,
        endpoint: TaskEndpoints.getManyByDeletedAt,
        useCache: useCache);
    if (includes == null || includes.isEmpty) {
        return items$;
    } else {
        return getManyIncluding$(items$, includes);
    }
}


  /// GET RELATED MODELS WITH ID STORED IN THIS MODEL as STREAM

  Stream<Contact?> getAssignedContact$(
    Task task, {bool useCache = true, ModelFilter<Contact>? modelFilter, List<ContactInclude>? includes}) {
    if (task.assignedToContactId == null) {
        return Stream.value(null);
    } else {
        return ContactStore.instance.getById$(
            task.assignedToContactId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((assignedContact) {
            task.assignedContact = assignedContact;
        });
    }
}

	Stream<User?> getAssignedUser$(
    Task task, {bool useCache = true, ModelFilter<User>? modelFilter, List<UserInclude>? includes}) {
    if (task.assignedToUserId == null) {
        return Stream.value(null);
    } else {
        return UserStore.instance.getById$(
            task.assignedToUserId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((assignedUser) {
            task.assignedUser = assignedUser;
        });
    }
}

	Stream<Booking?> getBooking$(
    Task task, {bool useCache = true, ModelFilter<Booking>? modelFilter, List<BookingInclude>? includes}) {
    if (task.bookingId == null) {
        return Stream.value(null);
    } else {
        return BookingStore.instance.getById$(
            task.bookingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((booking) {
            task.booking = booking;
        });
    }
}

	Stream<Contract?> getContract$(
    Task task, {bool useCache = true, ModelFilter<Contract>? modelFilter, List<ContractInclude>? includes}) {
    if (task.contractId == null) {
        return Stream.value(null);
    } else {
        return ContractStore.instance.getById$(
            task.contractId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((contract) {
            task.contract = contract;
        });
    }
}

	Stream<Lease?> getLease$(
    Task task, {bool useCache = true, ModelFilter<Lease>? modelFilter, List<LeaseInclude>? includes}) {
    if (task.leaseId == null) {
        return Stream.value(null);
    } else {
        return LeaseStore.instance.getById$(
            task.leaseId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((lease) {
            task.lease = lease;
        });
    }
}

	Stream<Listing?> getListing$(
    Task task, {bool useCache = true, ModelFilter<Listing>? modelFilter, List<ListingInclude>? includes}) {
    if (task.listingId == null) {
        return Stream.value(null);
    } else {
        return ListingStore.instance.getById$(
            task.listingId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((listing) {
            task.listing = listing;
        });
    }
}

	Stream<Organization?> getOrg$(
    Task task, {bool useCache = true, ModelFilter<Organization>? modelFilter, List<OrganizationInclude>? includes}) {
    if (task.orgId == null) {
        return Stream.value(null);
    } else {
        return OrganizationStore.instance.getById$(
            task.orgId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((org) {
            task.org = org;
        });
    }
}

	Stream<Project?> getProject$(
    Task task, {bool useCache = true, ModelFilter<Project>? modelFilter, List<ProjectInclude>? includes}) {
    if (task.projectId == null) {
        return Stream.value(null);
    } else {
        return ProjectStore.instance.getById$(
            task.projectId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((project) {
            task.project = project;
        });
    }
}

	Stream<Property?> getProperty$(
    Task task, {bool useCache = true, ModelFilter<Property>? modelFilter, List<PropertyInclude>? includes}) {
    if (task.propertyId == null) {
        return Stream.value(null);
    } else {
        return PropertyStore.instance.getById$(
            task.propertyId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((property) {
            task.property = property;
        });
    }
}

	Stream<Reservation?> getReservation$(
    Task task, {bool useCache = true, ModelFilter<Reservation>? modelFilter, List<ReservationInclude>? includes}) {
    if (task.reservationId == null) {
        return Stream.value(null);
    } else {
        return ReservationStore.instance.getById$(
            task.reservationId!,
            useCache: useCache,
            modelFilter: modelFilter,
            includes: includes)
        .doOnData((reservation) {
            task.reservation = reservation;
        });
    }
}

  /// GET RELATED MODELS as STREAM

  Stream<List<Attachment>> getAttachments$(
    Task task, {bool useCache = true, ModelFilter<Attachment>? modelFilter, List<AttachmentInclude>? includes}) {
    return AttachmentStore.instance.getByTaskId$(
        task.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((attachments) {
        task.attachments = attachments;
    });

}

	Stream<List<Agent>> getAgents$(
    Task task, {bool useCache = true, ModelFilter<Agent>? modelFilter, List<AgentInclude>? includes}) {
    return AgentStore.instance.getBy$(
        task.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agents) {
        task.agents = agents;
    });

}

	Stream<List<ExtraCharge>> getExtraCharges$(
    Task task, {bool useCache = true, ModelFilter<ExtraCharge>? modelFilter, List<ExtraChargeInclude>? includes}) {
    return ExtraChargeStore.instance.getBy$(
        task.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((extraCharges) {
        task.extraCharges = extraCharges;
    });

}

	Stream<List<Agency>> getAgencies$(
    Task task, {bool useCache = true, ModelFilter<Agency>? modelFilter, List<AgencyInclude>? includes}) {
    return AgencyStore.instance.getBy$(
        task.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((agencies) {
        task.agencies = agencies;
    });

}

	Stream<List<IncludedService>> getIncludedServices$(
    Task task, {bool useCache = true, ModelFilter<IncludedService>? modelFilter, List<IncludedServiceInclude>? includes}) {
    return IncludedServiceStore.instance.getBy$(
        task.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((includedServices) {
        task.includedServices = includedServices;
    });

}

	Stream<List<Analytics>> getAnalytics$(
    Task task, {bool useCache = true, ModelFilter<Analytics>? modelFilter, List<AnalyticsInclude>? includes}) {
    return AnalyticsStore.instance.getByTaskId$(
        task.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((analytics) {
        task.analytics = analytics;
    });

}

	Stream<List<Mention>> getMentions$(
    Task task, {bool useCache = true, ModelFilter<Mention>? modelFilter, List<MentionInclude>? includes}) {
    return MentionStore.instance.getByTaskId$(
        task.$uid!,
        useCache: useCache,
        modelFilter: modelFilter,
        includes: includes)
    .doOnData((mentions) {
        task.mentions = mentions;
    });

}

  // ADD REF MODELS TO REF STORES

  /// Recursively upserts this model and its related models to their respective stores.
///
/// [serializedTypes] - Internal parameter tracking which model types have been upserted
/// in the current chain to prevent circular references.
/// [preventCircularSerialization] - When true (default), prevents infinite recursion by
/// skipping relations whose types have already been upserted in the current chain.
Task recursiveUpsert(Task task, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final Set<String> upsertedTypes = preventCircularSerialization 
        ? {...?serializedTypes, 'Task'} 
        : const {};
    if (task.attachments != null && (!preventCircularSerialization || !upsertedTypes.contains('Attachment'))) {
        task.attachments = AttachmentStore.instance.recursiveListUpsert(task.attachments!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.assignedContact != null && (!preventCircularSerialization || !upsertedTypes.contains('Contact'))) {
        task.assignedContact = ContactStore.instance.recursiveUpsert(task.assignedContact!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.assignedUser != null && (!preventCircularSerialization || !upsertedTypes.contains('User'))) {
        task.assignedUser = UserStore.instance.recursiveUpsert(task.assignedUser!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.booking != null && (!preventCircularSerialization || !upsertedTypes.contains('Booking'))) {
        task.booking = BookingStore.instance.recursiveUpsert(task.booking!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.contract != null && (!preventCircularSerialization || !upsertedTypes.contains('Contract'))) {
        task.contract = ContractStore.instance.recursiveUpsert(task.contract!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.lease != null && (!preventCircularSerialization || !upsertedTypes.contains('Lease'))) {
        task.lease = LeaseStore.instance.recursiveUpsert(task.lease!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.listing != null && (!preventCircularSerialization || !upsertedTypes.contains('Listing'))) {
        task.listing = ListingStore.instance.recursiveUpsert(task.listing!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.org != null && (!preventCircularSerialization || !upsertedTypes.contains('Organization'))) {
        task.org = OrganizationStore.instance.recursiveUpsert(task.org!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.project != null && (!preventCircularSerialization || !upsertedTypes.contains('Project'))) {
        task.project = ProjectStore.instance.recursiveUpsert(task.project!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.property != null && (!preventCircularSerialization || !upsertedTypes.contains('Property'))) {
        task.property = PropertyStore.instance.recursiveUpsert(task.property!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.reservation != null && (!preventCircularSerialization || !upsertedTypes.contains('Reservation'))) {
        task.reservation = ReservationStore.instance.recursiveUpsert(task.reservation!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.agents != null && (!preventCircularSerialization || !upsertedTypes.contains('Agent'))) {
        task.agents = AgentStore.instance.recursiveListUpsert(task.agents!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.extraCharges != null && (!preventCircularSerialization || !upsertedTypes.contains('ExtraCharge'))) {
        task.extraCharges = ExtraChargeStore.instance.recursiveListUpsert(task.extraCharges!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.agencies != null && (!preventCircularSerialization || !upsertedTypes.contains('Agency'))) {
        task.agencies = AgencyStore.instance.recursiveListUpsert(task.agencies!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.includedServices != null && (!preventCircularSerialization || !upsertedTypes.contains('IncludedService'))) {
        task.includedServices = IncludedServiceStore.instance.recursiveListUpsert(task.includedServices!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.analytics != null && (!preventCircularSerialization || !upsertedTypes.contains('Analytics'))) {
        task.analytics = AnalyticsStore.instance.recursiveListUpsert(task.analytics!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }if (task.mentions != null && (!preventCircularSerialization || !upsertedTypes.contains('Mention'))) {
        task.mentions = MentionStore.instance.recursiveListUpsert(task.mentions!, serializedTypes: upsertedTypes, preventCircularSerialization: preventCircularSerialization);
    }
    return super.upsert(task);
}

  List<Task> recursiveListUpsert(List<Task> tasks, {
    Set<String>? serializedTypes,
    bool preventCircularSerialization = true,
}) {
    final updatedTasks = <Task>[];
    for (var task in tasks) {
        updatedTasks.add(recursiveUpsert(task, serializedTypes: serializedTypes, preventCircularSerialization: preventCircularSerialization));
    }
    return updatedTasks;
}

//   @override
//   Task upsert(Task item) {
//     return recursiveUpsert(item);
//   }

}


class TaskInclude<T extends PrismaModel> implements StoreIncludes<T> {

    @override
    bool useCache;

    @override
    bool useAsync;

    @override
  ModelFilter<T>? modelFilter;
  
    @override
    late Function method;
  
      TaskInclude.attachments({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Attachment>? modelFilter,
    List<AttachmentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getAttachments$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getAttachments(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.assignedContact({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contact>? modelFilter,
    List<ContactInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getAssignedContact$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getAssignedContact(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.assignedUser({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<User>? modelFilter,
    List<UserInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getAssignedUser$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getAssignedUser(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.booking({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Booking>? modelFilter,
    List<BookingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getBooking$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getBooking(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.contract({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Contract>? modelFilter,
    List<ContractInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getContract$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getContract(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.lease({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Lease>? modelFilter,
    List<LeaseInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getLease$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getLease(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.listing({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Listing>? modelFilter,
    List<ListingInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getListing$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getListing(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.org({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Organization>? modelFilter,
    List<OrganizationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getOrg$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getOrg(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.project({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Project>? modelFilter,
    List<ProjectInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getProject$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getProject(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.property({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Property>? modelFilter,
    List<PropertyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getProperty$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getProperty(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.reservation({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Reservation>? modelFilter,
    List<ReservationInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getReservation$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getReservation(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.agents({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agent>? modelFilter,
    List<AgentInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getAgents$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getAgents(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.extraCharges({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<ExtraCharge>? modelFilter,
    List<ExtraChargeInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getExtraCharges$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getExtraCharges(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.agencies({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Agency>? modelFilter,
    List<AgencyInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getAgencies$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getAgencies(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.includedServices({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<IncludedService>? modelFilter,
    List<IncludedServiceInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getIncludedServices$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getIncludedServices(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.analytics({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Analytics>? modelFilter,
    List<AnalyticsInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getAnalytics$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getAnalytics(task, modelFilter: modelFilter, includes: includes);
      }
}

	TaskInclude.mentions({
    this.useCache = true,
    this.useAsync = true,
    ModelFilter<Mention>? modelFilter,
    List<MentionInclude>? includes}) {
    if (useAsync) {
        this.modelFilter = modelFilter as ModelFilter<T>?;
        method = (task) => TaskStore.instance
            .getMentions$(task, useCache: useCache, modelFilter: modelFilter, includes: includes);
      } else {
        method = (task) => TaskStore.instance
            .getMentions(task, modelFilter: modelFilter, includes: includes);
      }
}
  }


enum TaskEndpoints implements Endpoint {

    getAll('/task', HttpMethod.post, List<Task>),
	getById('/task/byId/:id', HttpMethod.post, Task),
	getManyByOrgId('/task/byOrgId/:orgId', HttpMethod.post, List<Task>),
	getManyByPropertyId('/task/byPropertyId/:propertyId', HttpMethod.post, List<Task>),
	getManyByListingId('/task/byListingId/:listingId', HttpMethod.post, List<Task>),
	getManyByLeaseId('/task/byLeaseId/:leaseId', HttpMethod.post, List<Task>),
	getManyByBookingId('/task/byBookingId/:bookingId', HttpMethod.post, List<Task>),
	getManyByContractId('/task/byContractId/:contractId', HttpMethod.post, List<Task>),
	getManyByReservationId('/task/byReservationId/:reservationId', HttpMethod.post, List<Task>),
	getManyByProjectId('/task/byProjectId/:projectId', HttpMethod.post, List<Task>),
	getManyByType('/task/byType/:type', HttpMethod.post, List<Task>),
	getManyByStatus('/task/byStatus/:status', HttpMethod.post, List<Task>),
	getManyByPriority('/task/byPriority/:priority', HttpMethod.post, List<Task>),
	getManyByTitle('/task/byTitle/:title', HttpMethod.post, List<Task>),
	getManyByDescription('/task/byDescription/:description', HttpMethod.post, List<Task>),
	getManyByDueAt('/task/byDueAt/:dueAt', HttpMethod.post, List<Task>),
	getManyBySlaHours('/task/bySlaHours/:slaHours', HttpMethod.post, List<Task>),
	getManyByAssignedToUserId('/task/byAssignedToUserId/:assignedToUserId', HttpMethod.post, List<Task>),
	getManyByAssignedToContactId('/task/byAssignedToContactId/:assignedToContactId', HttpMethod.post, List<Task>),
	getManyByCreatedBy('/task/byCreatedBy/:createdBy', HttpMethod.post, List<Task>),
	getManyByCreatedAt('/task/byCreatedAt/:createdAt', HttpMethod.post, List<Task>),
	getManyByUpdatedAt('/task/byUpdatedAt/:updatedAt', HttpMethod.post, List<Task>),
	getManyByDeletedAt('/task/byDeletedAt/:deletedAt', HttpMethod.post, List<Task>);

    const TaskEndpoints(this.path, this.method, this.responseType);

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
