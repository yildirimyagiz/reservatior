
//***  AUTO-GENERATED FILE - DO NOT MODIFY ***// 

import '../abcx3_common.library.dart';
import 'contact_type.dart';
import 'appointment.dart';
import 'attorney_management.dart';
import 'booking.dart';
import 'client_relationship.dart';
import 'organization.dart';
import 'deal.dart';
import 'event_attendee.dart';
import 'financial_record.dart';
import 'guest_profile.dart';
import 'guest_review.dart';
import 'immigration_status_check.dart';
import 'lead.dart';
import 'lease.dart';
import 'maintenance_work_order.dart';
import 'mortgage_offer.dart';
import 'mortgage_pre_approval.dart';
import 'payout.dart';
import 'project.dart';
import 'property_compliance.dart';
import 'property_offer.dart';
import 'quote.dart';
import 'rent_arrears.dart';
import 'reservation.dart';
import 'right_to_rent_check.dart';
import 'signature_signer.dart';
import 'solicitor_management.dart';
import 'task.dart';
import 'tax1099_form.dart';
import 'tenant_application.dart';


class Contact implements PrismaModel<String, Contact> , Id<String> {
    @override
String? id;
	String? orgId;
	ContactType? type;
	String? fullName;
	String? email;
	String? phone;
	String? notes;
	String? locale;
	String? currency;
	DateTime? createdAt;
	DateTime? updatedAt;
	DateTime? deletedAt;
	List<Appointment>? assignedAppointments;
	List<Appointment>? appointments;
	List<AttorneyManagement>? attorneyCases;
	List<Booking>? bookings;
	List<ClientRelationship>? clientRelationships;
	Organization? org;
	List<Deal>? dealAgents;
	List<Deal>? dealClients;
	List<EventAttendee>? eventAttendees;
	List<FinancialRecord>? vendorRecords;
	GuestProfile? guestProfile;
	List<GuestReview>? guestReviews;
	List<ImmigrationStatusCheck>? immigrationStatusChecks;
	List<Lead>? leads;
	List<Lease>? leases;
	List<MaintenanceWorkOrder>? workOrders;
	List<MortgageOffer>? mortgageOffers;
	List<MortgagePreApproval>? mortgagePreApprovals;
	List<Payout>? payoutProcessors;
	List<Payout>? payoutRecipients;
	List<Project>? projects;
	List<PropertyCompliance>? propertyCompliance;
	List<PropertyOffer>? propertyOffers;
	List<Quote>? quotes;
	List<RentArrears>? rentArrears;
	List<Reservation>? reservations;
	List<RightToRentCheck>? rightToRentChecks;
	List<SignatureSigner>? signatureSigners;
	List<SolicitorManagement>? solicitorManagements;
	List<Task>? tasks;
	List<Tax1099Form>? tax1099Forms;
	List<TenantApplication>? tenantApplications;
	DateTime? consentGivenAt;
	DateTime? consentWithdrawnAt;
	String? dataSubjectId;
	int? $assignedAppointmentsCount;
	int? $appointmentsCount;
	int? $attorneyCasesCount;
	int? $bookingsCount;
	int? $clientRelationshipsCount;
	int? $dealAgentsCount;
	int? $dealClientsCount;
	int? $eventAttendeesCount;
	int? $vendorRecordsCount;
	int? $guestReviewsCount;
	int? $immigrationStatusChecksCount;
	int? $leadsCount;
	int? $leasesCount;
	int? $workOrdersCount;
	int? $mortgageOffersCount;
	int? $mortgagePreApprovalsCount;
	int? $payoutProcessorsCount;
	int? $payoutRecipientsCount;
	int? $projectsCount;
	int? $propertyComplianceCount;
	int? $propertyOffersCount;
	int? $quotesCount;
	int? $rentArrearsCount;
	int? $reservationsCount;
	int? $rightToRentChecksCount;
	int? $signatureSignersCount;
	int? $solicitorManagementsCount;
	int? $tasksCount;
	int? $tax1099FormsCount;
	int? $tenantApplicationsCount;

    Set<String> $assignedFields = {};
    
    /// Creates a new instance of this class.
  /// All parameters are optional and default to null.
    Contact({ this.id,
	 this.orgId,
	 this.type,
	 this.fullName,
	 this.email,
	 this.phone,
	 this.notes,
	 this.locale,
	 this.currency,
	 this.createdAt,
	 this.updatedAt,
	 this.deletedAt,
	 this.assignedAppointments,
	 this.appointments,
	 this.attorneyCases,
	 this.bookings,
	 this.clientRelationships,
	 this.org,
	 this.dealAgents,
	 this.dealClients,
	 this.eventAttendees,
	 this.vendorRecords,
	 this.guestProfile,
	 this.guestReviews,
	 this.immigrationStatusChecks,
	 this.leads,
	 this.leases,
	 this.workOrders,
	 this.mortgageOffers,
	 this.mortgagePreApprovals,
	 this.payoutProcessors,
	 this.payoutRecipients,
	 this.projects,
	 this.propertyCompliance,
	 this.propertyOffers,
	 this.quotes,
	 this.rentArrears,
	 this.reservations,
	 this.rightToRentChecks,
	 this.signatureSigners,
	 this.solicitorManagements,
	 this.tasks,
	 this.tax1099Forms,
	 this.tenantApplications,
	 this.consentGivenAt,
	 this.consentWithdrawnAt,
	 this.dataSubjectId,
	this.$assignedAppointmentsCount,
	this.$appointmentsCount,
	this.$attorneyCasesCount,
	this.$bookingsCount,
	this.$clientRelationshipsCount,
	this.$dealAgentsCount,
	this.$dealClientsCount,
	this.$eventAttendeesCount,
	this.$vendorRecordsCount,
	this.$guestReviewsCount,
	this.$immigrationStatusChecksCount,
	this.$leadsCount,
	this.$leasesCount,
	this.$workOrdersCount,
	this.$mortgageOffersCount,
	this.$mortgagePreApprovalsCount,
	this.$payoutProcessorsCount,
	this.$payoutRecipientsCount,
	this.$projectsCount,
	this.$propertyComplianceCount,
	this.$propertyOffersCount,
	this.$quotesCount,
	this.$rentArrearsCount,
	this.$reservationsCount,
	this.$rightToRentChecksCount,
	this.$signatureSignersCount,
	this.$solicitorManagementsCount,
	this.$tasksCount,
	this.$tax1099FormsCount,
	this.$tenantApplicationsCount,
      this.$assignedFields = const {},
    });

    
@override
String? get $uid => id;

    Map<String, GetPropertyValueFunction<Contact, dynamic>> propertyValueFunctionMap = {
      "id": (m) => m.id,

	"orgId": (m) => m.orgId,

	"type": (m) => m.type,

	"fullName": (m) => m.fullName,

	"email": (m) => m.email,

	"phone": (m) => m.phone,

	"notes": (m) => m.notes,

	"locale": (m) => m.locale,

	"currency": (m) => m.currency,

	"createdAt": (m) => m.createdAt,

	"updatedAt": (m) => m.updatedAt,

	"deletedAt": (m) => m.deletedAt,

	"assignedAppointments": (m) => m.assignedAppointments,

	"appointments": (m) => m.appointments,

	"attorneyCases": (m) => m.attorneyCases,

	"bookings": (m) => m.bookings,

	"clientRelationships": (m) => m.clientRelationships,

	"org": (m) => m.org,

	"dealAgents": (m) => m.dealAgents,

	"dealClients": (m) => m.dealClients,

	"eventAttendees": (m) => m.eventAttendees,

	"vendorRecords": (m) => m.vendorRecords,

	"guestProfile": (m) => m.guestProfile,

	"guestReviews": (m) => m.guestReviews,

	"immigrationStatusChecks": (m) => m.immigrationStatusChecks,

	"leads": (m) => m.leads,

	"leases": (m) => m.leases,

	"workOrders": (m) => m.workOrders,

	"mortgageOffers": (m) => m.mortgageOffers,

	"mortgagePreApprovals": (m) => m.mortgagePreApprovals,

	"payoutProcessors": (m) => m.payoutProcessors,

	"payoutRecipients": (m) => m.payoutRecipients,

	"projects": (m) => m.projects,

	"propertyCompliance": (m) => m.propertyCompliance,

	"propertyOffers": (m) => m.propertyOffers,

	"quotes": (m) => m.quotes,

	"rentArrears": (m) => m.rentArrears,

	"reservations": (m) => m.reservations,

	"rightToRentChecks": (m) => m.rightToRentChecks,

	"signatureSigners": (m) => m.signatureSigners,

	"solicitorManagements": (m) => m.solicitorManagements,

	"tasks": (m) => m.tasks,

	"tax1099Forms": (m) => m.tax1099Forms,

	"tenantApplications": (m) => m.tenantApplications,

	"consentGivenAt": (m) => m.consentGivenAt,

	"consentWithdrawnAt": (m) => m.consentWithdrawnAt,

	"dataSubjectId": (m) => m.dataSubjectId,
    };

    /// gets a function by property name that returns the property value from the model
    @override
  V? Function(Contact) getPropToValueFunction<V>(String propertyName) {
    final propFunction = propertyValueFunctionMap[propertyName];
    if (propFunction == null) {
      throw Exception('Property "$propertyName" not found in Contact');
    }
    return propFunction as V? Function(Contact);
  }

    
@override
bool equalById(UID<String> other) => $uid == other.$uid;

    /// Creates a new instance of this class from a JSON object.
    @override
    factory Contact.fromJson(JsonMap json) =>
      Contact(
        id: json['id'] as String?,
	orgId: json['orgId'] as String?,
	type: json['type'] != null ? ContactType.fromJson(json['type']) : null,
	fullName: json['fullName'] as String?,
	email: json['email'] as String?,
	phone: json['phone'] as String?,
	notes: json['notes'] as String?,
	locale: json['locale'] as String?,
	currency: json['currency'] as String?,
	createdAt: json['createdAt'] != null ? DateTime.parse(json['createdAt']) : null,
	updatedAt: json['updatedAt'] != null ? DateTime.parse(json['updatedAt']) : null,
	deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt']) : null,
	assignedAppointments: json['assignedAppointments'] != null ? createModels<Appointment>((json['assignedAppointments'] as List).cast<JsonMap>(), Appointment.fromJson) : null,
	appointments: json['appointments'] != null ? createModels<Appointment>((json['appointments'] as List).cast<JsonMap>(), Appointment.fromJson) : null,
	attorneyCases: json['attorneyCases'] != null ? createModels<AttorneyManagement>((json['attorneyCases'] as List).cast<JsonMap>(), AttorneyManagement.fromJson) : null,
	bookings: json['bookings'] != null ? createModels<Booking>((json['bookings'] as List).cast<JsonMap>(), Booking.fromJson) : null,
	clientRelationships: json['clientRelationships'] != null ? createModels<ClientRelationship>((json['clientRelationships'] as List).cast<JsonMap>(), ClientRelationship.fromJson) : null,
	org: json['org'] != null ? Organization.fromJson(json['org'] as JsonMap) : null,
	dealAgents: json['dealAgents'] != null ? createModels<Deal>((json['dealAgents'] as List).cast<JsonMap>(), Deal.fromJson) : null,
	dealClients: json['dealClients'] != null ? createModels<Deal>((json['dealClients'] as List).cast<JsonMap>(), Deal.fromJson) : null,
	eventAttendees: json['eventAttendees'] != null ? createModels<EventAttendee>((json['eventAttendees'] as List).cast<JsonMap>(), EventAttendee.fromJson) : null,
	vendorRecords: json['vendorRecords'] != null ? createModels<FinancialRecord>((json['vendorRecords'] as List).cast<JsonMap>(), FinancialRecord.fromJson) : null,
	guestProfile: json['guestProfile'] != null ? GuestProfile.fromJson(json['guestProfile'] as JsonMap) : null,
	guestReviews: json['guestReviews'] != null ? createModels<GuestReview>((json['guestReviews'] as List).cast<JsonMap>(), GuestReview.fromJson) : null,
	immigrationStatusChecks: json['immigrationStatusChecks'] != null ? createModels<ImmigrationStatusCheck>((json['immigrationStatusChecks'] as List).cast<JsonMap>(), ImmigrationStatusCheck.fromJson) : null,
	leads: json['leads'] != null ? createModels<Lead>((json['leads'] as List).cast<JsonMap>(), Lead.fromJson) : null,
	leases: json['leases'] != null ? createModels<Lease>((json['leases'] as List).cast<JsonMap>(), Lease.fromJson) : null,
	workOrders: json['workOrders'] != null ? createModels<MaintenanceWorkOrder>((json['workOrders'] as List).cast<JsonMap>(), MaintenanceWorkOrder.fromJson) : null,
	mortgageOffers: json['mortgageOffers'] != null ? createModels<MortgageOffer>((json['mortgageOffers'] as List).cast<JsonMap>(), MortgageOffer.fromJson) : null,
	mortgagePreApprovals: json['mortgagePreApprovals'] != null ? createModels<MortgagePreApproval>((json['mortgagePreApprovals'] as List).cast<JsonMap>(), MortgagePreApproval.fromJson) : null,
	payoutProcessors: json['payoutProcessors'] != null ? createModels<Payout>((json['payoutProcessors'] as List).cast<JsonMap>(), Payout.fromJson) : null,
	payoutRecipients: json['payoutRecipients'] != null ? createModels<Payout>((json['payoutRecipients'] as List).cast<JsonMap>(), Payout.fromJson) : null,
	projects: json['projects'] != null ? createModels<Project>((json['projects'] as List).cast<JsonMap>(), Project.fromJson) : null,
	propertyCompliance: json['propertyCompliance'] != null ? createModels<PropertyCompliance>((json['propertyCompliance'] as List).cast<JsonMap>(), PropertyCompliance.fromJson) : null,
	propertyOffers: json['propertyOffers'] != null ? createModels<PropertyOffer>((json['propertyOffers'] as List).cast<JsonMap>(), PropertyOffer.fromJson) : null,
	quotes: json['quotes'] != null ? createModels<Quote>((json['quotes'] as List).cast<JsonMap>(), Quote.fromJson) : null,
	rentArrears: json['rentArrears'] != null ? createModels<RentArrears>((json['rentArrears'] as List).cast<JsonMap>(), RentArrears.fromJson) : null,
	reservations: json['reservations'] != null ? createModels<Reservation>((json['reservations'] as List).cast<JsonMap>(), Reservation.fromJson) : null,
	rightToRentChecks: json['rightToRentChecks'] != null ? createModels<RightToRentCheck>((json['rightToRentChecks'] as List).cast<JsonMap>(), RightToRentCheck.fromJson) : null,
	signatureSigners: json['signatureSigners'] != null ? createModels<SignatureSigner>((json['signatureSigners'] as List).cast<JsonMap>(), SignatureSigner.fromJson) : null,
	solicitorManagements: json['solicitorManagements'] != null ? createModels<SolicitorManagement>((json['solicitorManagements'] as List).cast<JsonMap>(), SolicitorManagement.fromJson) : null,
	tasks: json['tasks'] != null ? createModels<Task>((json['tasks'] as List).cast<JsonMap>(), Task.fromJson) : null,
	tax1099Forms: json['tax1099Forms'] != null ? createModels<Tax1099Form>((json['tax1099Forms'] as List).cast<JsonMap>(), Tax1099Form.fromJson) : null,
	tenantApplications: json['tenantApplications'] != null ? createModels<TenantApplication>((json['tenantApplications'] as List).cast<JsonMap>(), TenantApplication.fromJson) : null,
	consentGivenAt: json['consentGivenAt'] != null ? DateTime.parse(json['consentGivenAt']) : null,
	consentWithdrawnAt: json['consentWithdrawnAt'] != null ? DateTime.parse(json['consentWithdrawnAt']) : null,
	dataSubjectId: json['dataSubjectId'] as String?,
	$assignedAppointmentsCount: json['_count']?['assignedAppointments'] as int?,
	$appointmentsCount: json['_count']?['appointments'] as int?,
	$attorneyCasesCount: json['_count']?['attorneyCases'] as int?,
	$bookingsCount: json['_count']?['bookings'] as int?,
	$clientRelationshipsCount: json['_count']?['clientRelationships'] as int?,
	$dealAgentsCount: json['_count']?['dealAgents'] as int?,
	$dealClientsCount: json['_count']?['dealClients'] as int?,
	$eventAttendeesCount: json['_count']?['eventAttendees'] as int?,
	$vendorRecordsCount: json['_count']?['vendorRecords'] as int?,
	$guestReviewsCount: json['_count']?['guestReviews'] as int?,
	$immigrationStatusChecksCount: json['_count']?['immigrationStatusChecks'] as int?,
	$leadsCount: json['_count']?['leads'] as int?,
	$leasesCount: json['_count']?['leases'] as int?,
	$workOrdersCount: json['_count']?['workOrders'] as int?,
	$mortgageOffersCount: json['_count']?['mortgageOffers'] as int?,
	$mortgagePreApprovalsCount: json['_count']?['mortgagePreApprovals'] as int?,
	$payoutProcessorsCount: json['_count']?['payoutProcessors'] as int?,
	$payoutRecipientsCount: json['_count']?['payoutRecipients'] as int?,
	$projectsCount: json['_count']?['projects'] as int?,
	$propertyComplianceCount: json['_count']?['propertyCompliance'] as int?,
	$propertyOffersCount: json['_count']?['propertyOffers'] as int?,
	$quotesCount: json['_count']?['quotes'] as int?,
	$rentArrearsCount: json['_count']?['rentArrears'] as int?,
	$reservationsCount: json['_count']?['reservations'] as int?,
	$rightToRentChecksCount: json['_count']?['rightToRentChecks'] as int?,
	$signatureSignersCount: json['_count']?['signatureSigners'] as int?,
	$solicitorManagementsCount: json['_count']?['solicitorManagements'] as int?,
	$tasksCount: json['_count']?['tasks'] as int?,
	$tax1099FormsCount: json['_count']?['tax1099Forms'] as int?,
	$tenantApplicationsCount: json['_count']?['tenantApplications'] as int?,
        $assignedFields: json.keys.toSet(),
      );

      /// Creates a new instance populated with the values of this instance and the given values,
    /// where the given values has precedence.
      @override  
    Contact copyWith({
        Value<String?>? id,
		Value<String?>? orgId,
		Value<ContactType?>? type,
		Value<String?>? fullName,
		Value<String?>? email,
		Value<String?>? phone,
		Value<String?>? notes,
		Value<String?>? locale,
		Value<String?>? currency,
		Value<DateTime?>? createdAt,
		Value<DateTime?>? updatedAt,
		Value<DateTime?>? deletedAt,
		Value<List<Appointment>?>? assignedAppointments,
		Value<List<Appointment>?>? appointments,
		Value<List<AttorneyManagement>?>? attorneyCases,
		Value<List<Booking>?>? bookings,
		Value<List<ClientRelationship>?>? clientRelationships,
		Value<Organization?>? org,
		Value<List<Deal>?>? dealAgents,
		Value<List<Deal>?>? dealClients,
		Value<List<EventAttendee>?>? eventAttendees,
		Value<List<FinancialRecord>?>? vendorRecords,
		Value<GuestProfile?>? guestProfile,
		Value<List<GuestReview>?>? guestReviews,
		Value<List<ImmigrationStatusCheck>?>? immigrationStatusChecks,
		Value<List<Lead>?>? leads,
		Value<List<Lease>?>? leases,
		Value<List<MaintenanceWorkOrder>?>? workOrders,
		Value<List<MortgageOffer>?>? mortgageOffers,
		Value<List<MortgagePreApproval>?>? mortgagePreApprovals,
		Value<List<Payout>?>? payoutProcessors,
		Value<List<Payout>?>? payoutRecipients,
		Value<List<Project>?>? projects,
		Value<List<PropertyCompliance>?>? propertyCompliance,
		Value<List<PropertyOffer>?>? propertyOffers,
		Value<List<Quote>?>? quotes,
		Value<List<RentArrears>?>? rentArrears,
		Value<List<Reservation>?>? reservations,
		Value<List<RightToRentCheck>?>? rightToRentChecks,
		Value<List<SignatureSigner>?>? signatureSigners,
		Value<List<SolicitorManagement>?>? solicitorManagements,
		Value<List<Task>?>? tasks,
		Value<List<Tax1099Form>?>? tax1099Forms,
		Value<List<TenantApplication>?>? tenantApplications,
		Value<DateTime?>? consentGivenAt,
		Value<DateTime?>? consentWithdrawnAt,
		Value<String?>? dataSubjectId,
		int? $assignedAppointmentsCount,
		int? $appointmentsCount,
		int? $attorneyCasesCount,
		int? $bookingsCount,
		int? $clientRelationshipsCount,
		int? $dealAgentsCount,
		int? $dealClientsCount,
		int? $eventAttendeesCount,
		int? $vendorRecordsCount,
		int? $guestReviewsCount,
		int? $immigrationStatusChecksCount,
		int? $leadsCount,
		int? $leasesCount,
		int? $workOrdersCount,
		int? $mortgageOffersCount,
		int? $mortgagePreApprovalsCount,
		int? $payoutProcessorsCount,
		int? $payoutRecipientsCount,
		int? $projectsCount,
		int? $propertyComplianceCount,
		int? $propertyOffersCount,
		int? $quotesCount,
		int? $rentArrearsCount,
		int? $reservationsCount,
		int? $rightToRentChecksCount,
		int? $signatureSignersCount,
		int? $solicitorManagementsCount,
		int? $tasksCount,
		int? $tax1099FormsCount,
		int? $tenantApplicationsCount,
        }) {
        return Contact(
            id: id != null ? id.value : this.id,
		orgId: orgId != null ? orgId.value : this.orgId,
		type: type != null ? type.value : this.type,
		fullName: fullName != null ? fullName.value : this.fullName,
		email: email != null ? email.value : this.email,
		phone: phone != null ? phone.value : this.phone,
		notes: notes != null ? notes.value : this.notes,
		locale: locale != null ? locale.value : this.locale,
		currency: currency != null ? currency.value : this.currency,
		createdAt: createdAt != null ? createdAt.value : this.createdAt,
		updatedAt: updatedAt != null ? updatedAt.value : this.updatedAt,
		deletedAt: deletedAt != null ? deletedAt.value : this.deletedAt,
		assignedAppointments: assignedAppointments != null ? assignedAppointments.value : this.assignedAppointments,
		appointments: appointments != null ? appointments.value : this.appointments,
		attorneyCases: attorneyCases != null ? attorneyCases.value : this.attorneyCases,
		bookings: bookings != null ? bookings.value : this.bookings,
		clientRelationships: clientRelationships != null ? clientRelationships.value : this.clientRelationships,
		org: org != null ? org.value : this.org,
		dealAgents: dealAgents != null ? dealAgents.value : this.dealAgents,
		dealClients: dealClients != null ? dealClients.value : this.dealClients,
		eventAttendees: eventAttendees != null ? eventAttendees.value : this.eventAttendees,
		vendorRecords: vendorRecords != null ? vendorRecords.value : this.vendorRecords,
		guestProfile: guestProfile != null ? guestProfile.value : this.guestProfile,
		guestReviews: guestReviews != null ? guestReviews.value : this.guestReviews,
		immigrationStatusChecks: immigrationStatusChecks != null ? immigrationStatusChecks.value : this.immigrationStatusChecks,
		leads: leads != null ? leads.value : this.leads,
		leases: leases != null ? leases.value : this.leases,
		workOrders: workOrders != null ? workOrders.value : this.workOrders,
		mortgageOffers: mortgageOffers != null ? mortgageOffers.value : this.mortgageOffers,
		mortgagePreApprovals: mortgagePreApprovals != null ? mortgagePreApprovals.value : this.mortgagePreApprovals,
		payoutProcessors: payoutProcessors != null ? payoutProcessors.value : this.payoutProcessors,
		payoutRecipients: payoutRecipients != null ? payoutRecipients.value : this.payoutRecipients,
		projects: projects != null ? projects.value : this.projects,
		propertyCompliance: propertyCompliance != null ? propertyCompliance.value : this.propertyCompliance,
		propertyOffers: propertyOffers != null ? propertyOffers.value : this.propertyOffers,
		quotes: quotes != null ? quotes.value : this.quotes,
		rentArrears: rentArrears != null ? rentArrears.value : this.rentArrears,
		reservations: reservations != null ? reservations.value : this.reservations,
		rightToRentChecks: rightToRentChecks != null ? rightToRentChecks.value : this.rightToRentChecks,
		signatureSigners: signatureSigners != null ? signatureSigners.value : this.signatureSigners,
		solicitorManagements: solicitorManagements != null ? solicitorManagements.value : this.solicitorManagements,
		tasks: tasks != null ? tasks.value : this.tasks,
		tax1099Forms: tax1099Forms != null ? tax1099Forms.value : this.tax1099Forms,
		tenantApplications: tenantApplications != null ? tenantApplications.value : this.tenantApplications,
		consentGivenAt: consentGivenAt != null ? consentGivenAt.value : this.consentGivenAt,
		consentWithdrawnAt: consentWithdrawnAt != null ? consentWithdrawnAt.value : this.consentWithdrawnAt,
		dataSubjectId: dataSubjectId != null ? dataSubjectId.value : this.dataSubjectId,
		$assignedAppointmentsCount: $assignedAppointmentsCount ?? this.$assignedAppointmentsCount,
		$appointmentsCount: $appointmentsCount ?? this.$appointmentsCount,
		$attorneyCasesCount: $attorneyCasesCount ?? this.$attorneyCasesCount,
		$bookingsCount: $bookingsCount ?? this.$bookingsCount,
		$clientRelationshipsCount: $clientRelationshipsCount ?? this.$clientRelationshipsCount,
		$dealAgentsCount: $dealAgentsCount ?? this.$dealAgentsCount,
		$dealClientsCount: $dealClientsCount ?? this.$dealClientsCount,
		$eventAttendeesCount: $eventAttendeesCount ?? this.$eventAttendeesCount,
		$vendorRecordsCount: $vendorRecordsCount ?? this.$vendorRecordsCount,
		$guestReviewsCount: $guestReviewsCount ?? this.$guestReviewsCount,
		$immigrationStatusChecksCount: $immigrationStatusChecksCount ?? this.$immigrationStatusChecksCount,
		$leadsCount: $leadsCount ?? this.$leadsCount,
		$leasesCount: $leasesCount ?? this.$leasesCount,
		$workOrdersCount: $workOrdersCount ?? this.$workOrdersCount,
		$mortgageOffersCount: $mortgageOffersCount ?? this.$mortgageOffersCount,
		$mortgagePreApprovalsCount: $mortgagePreApprovalsCount ?? this.$mortgagePreApprovalsCount,
		$payoutProcessorsCount: $payoutProcessorsCount ?? this.$payoutProcessorsCount,
		$payoutRecipientsCount: $payoutRecipientsCount ?? this.$payoutRecipientsCount,
		$projectsCount: $projectsCount ?? this.$projectsCount,
		$propertyComplianceCount: $propertyComplianceCount ?? this.$propertyComplianceCount,
		$propertyOffersCount: $propertyOffersCount ?? this.$propertyOffersCount,
		$quotesCount: $quotesCount ?? this.$quotesCount,
		$rentArrearsCount: $rentArrearsCount ?? this.$rentArrearsCount,
		$reservationsCount: $reservationsCount ?? this.$reservationsCount,
		$rightToRentChecksCount: $rightToRentChecksCount ?? this.$rightToRentChecksCount,
		$signatureSignersCount: $signatureSignersCount ?? this.$signatureSignersCount,
		$solicitorManagementsCount: $solicitorManagementsCount ?? this.$solicitorManagementsCount,
		$tasksCount: $tasksCount ?? this.$tasksCount,
		$tax1099FormsCount: $tax1099FormsCount ?? this.$tax1099FormsCount,
		$tenantApplicationsCount: $tenantApplicationsCount ?? this.$tenantApplicationsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.

    @override
    Contact copyWithInstanceValues(Contact contact) {
        return Contact(
            id: contact.id ?? id,
		orgId: contact.orgId ?? orgId,
		type: contact.type ?? type,
		fullName: contact.fullName ?? fullName,
		email: contact.email ?? email,
		phone: contact.phone ?? phone,
		notes: contact.notes ?? notes,
		locale: contact.locale ?? locale,
		currency: contact.currency ?? currency,
		createdAt: contact.createdAt ?? createdAt,
		updatedAt: contact.updatedAt ?? updatedAt,
		deletedAt: contact.deletedAt ?? deletedAt,
		assignedAppointments: contact.assignedAppointments ?? assignedAppointments,
		appointments: contact.appointments ?? appointments,
		attorneyCases: contact.attorneyCases ?? attorneyCases,
		bookings: contact.bookings ?? bookings,
		clientRelationships: contact.clientRelationships ?? clientRelationships,
		org: contact.org ?? org,
		dealAgents: contact.dealAgents ?? dealAgents,
		dealClients: contact.dealClients ?? dealClients,
		eventAttendees: contact.eventAttendees ?? eventAttendees,
		vendorRecords: contact.vendorRecords ?? vendorRecords,
		guestProfile: contact.guestProfile ?? guestProfile,
		guestReviews: contact.guestReviews ?? guestReviews,
		immigrationStatusChecks: contact.immigrationStatusChecks ?? immigrationStatusChecks,
		leads: contact.leads ?? leads,
		leases: contact.leases ?? leases,
		workOrders: contact.workOrders ?? workOrders,
		mortgageOffers: contact.mortgageOffers ?? mortgageOffers,
		mortgagePreApprovals: contact.mortgagePreApprovals ?? mortgagePreApprovals,
		payoutProcessors: contact.payoutProcessors ?? payoutProcessors,
		payoutRecipients: contact.payoutRecipients ?? payoutRecipients,
		projects: contact.projects ?? projects,
		propertyCompliance: contact.propertyCompliance ?? propertyCompliance,
		propertyOffers: contact.propertyOffers ?? propertyOffers,
		quotes: contact.quotes ?? quotes,
		rentArrears: contact.rentArrears ?? rentArrears,
		reservations: contact.reservations ?? reservations,
		rightToRentChecks: contact.rightToRentChecks ?? rightToRentChecks,
		signatureSigners: contact.signatureSigners ?? signatureSigners,
		solicitorManagements: contact.solicitorManagements ?? solicitorManagements,
		tasks: contact.tasks ?? tasks,
		tax1099Forms: contact.tax1099Forms ?? tax1099Forms,
		tenantApplications: contact.tenantApplications ?? tenantApplications,
		consentGivenAt: contact.consentGivenAt ?? consentGivenAt,
		consentWithdrawnAt: contact.consentWithdrawnAt ?? consentWithdrawnAt,
		dataSubjectId: contact.dataSubjectId ?? dataSubjectId,
		$assignedAppointmentsCount: contact.$assignedAppointmentsCount ?? $assignedAppointmentsCount,
		$appointmentsCount: contact.$appointmentsCount ?? $appointmentsCount,
		$attorneyCasesCount: contact.$attorneyCasesCount ?? $attorneyCasesCount,
		$bookingsCount: contact.$bookingsCount ?? $bookingsCount,
		$clientRelationshipsCount: contact.$clientRelationshipsCount ?? $clientRelationshipsCount,
		$dealAgentsCount: contact.$dealAgentsCount ?? $dealAgentsCount,
		$dealClientsCount: contact.$dealClientsCount ?? $dealClientsCount,
		$eventAttendeesCount: contact.$eventAttendeesCount ?? $eventAttendeesCount,
		$vendorRecordsCount: contact.$vendorRecordsCount ?? $vendorRecordsCount,
		$guestReviewsCount: contact.$guestReviewsCount ?? $guestReviewsCount,
		$immigrationStatusChecksCount: contact.$immigrationStatusChecksCount ?? $immigrationStatusChecksCount,
		$leadsCount: contact.$leadsCount ?? $leadsCount,
		$leasesCount: contact.$leasesCount ?? $leasesCount,
		$workOrdersCount: contact.$workOrdersCount ?? $workOrdersCount,
		$mortgageOffersCount: contact.$mortgageOffersCount ?? $mortgageOffersCount,
		$mortgagePreApprovalsCount: contact.$mortgagePreApprovalsCount ?? $mortgagePreApprovalsCount,
		$payoutProcessorsCount: contact.$payoutProcessorsCount ?? $payoutProcessorsCount,
		$payoutRecipientsCount: contact.$payoutRecipientsCount ?? $payoutRecipientsCount,
		$projectsCount: contact.$projectsCount ?? $projectsCount,
		$propertyComplianceCount: contact.$propertyComplianceCount ?? $propertyComplianceCount,
		$propertyOffersCount: contact.$propertyOffersCount ?? $propertyOffersCount,
		$quotesCount: contact.$quotesCount ?? $quotesCount,
		$rentArrearsCount: contact.$rentArrearsCount ?? $rentArrearsCount,
		$reservationsCount: contact.$reservationsCount ?? $reservationsCount,
		$rightToRentChecksCount: contact.$rightToRentChecksCount ?? $rightToRentChecksCount,
		$signatureSignersCount: contact.$signatureSignersCount ?? $signatureSignersCount,
		$solicitorManagementsCount: contact.$solicitorManagementsCount ?? $solicitorManagementsCount,
		$tasksCount: contact.$tasksCount ?? $tasksCount,
		$tax1099FormsCount: contact.$tax1099FormsCount ?? $tax1099FormsCount,
		$tenantApplicationsCount: contact.$tenantApplicationsCount ?? $tenantApplicationsCount
        );
    }

    /// Creates a new instance populated with the values of this instance and the given instance,
    /// where the given instance's values has precedence.
    /// Just like copyWithInstanceValues, but merges lists instead of replacing them.

    @override
    Contact mergeWithInstanceValues(Contact contact) {
        return Contact(
            id: contact.$assignedFields.contains('id') ? contact.id : id,
		orgId: contact.$assignedFields.contains('orgId') ? contact.orgId : orgId,
		type: contact.$assignedFields.contains('type') ? contact.type : type,
		fullName: contact.$assignedFields.contains('fullName') ? contact.fullName : fullName,
		email: contact.$assignedFields.contains('email') ? contact.email : email,
		phone: contact.$assignedFields.contains('phone') ? contact.phone : phone,
		notes: contact.$assignedFields.contains('notes') ? contact.notes : notes,
		locale: contact.$assignedFields.contains('locale') ? contact.locale : locale,
		currency: contact.$assignedFields.contains('currency') ? contact.currency : currency,
		createdAt: contact.$assignedFields.contains('createdAt') ? contact.createdAt : createdAt,
		updatedAt: contact.$assignedFields.contains('updatedAt') ? contact.updatedAt : updatedAt,
		deletedAt: contact.$assignedFields.contains('deletedAt') ? contact.deletedAt : deletedAt,
		assignedAppointments: (contact.$assignedFields.contains('assignedAppointments') && contact.assignedAppointments != null) ? mergeModelLists(assignedAppointments, contact.assignedAppointments) : assignedAppointments,
		appointments: (contact.$assignedFields.contains('appointments') && contact.appointments != null) ? mergeModelLists(appointments, contact.appointments) : appointments,
		attorneyCases: (contact.$assignedFields.contains('attorneyCases') && contact.attorneyCases != null) ? mergeModelLists(attorneyCases, contact.attorneyCases) : attorneyCases,
		bookings: (contact.$assignedFields.contains('bookings') && contact.bookings != null) ? mergeModelLists(bookings, contact.bookings) : bookings,
		clientRelationships: (contact.$assignedFields.contains('clientRelationships') && contact.clientRelationships != null) ? mergeModelLists(clientRelationships, contact.clientRelationships) : clientRelationships,
		org: contact.$assignedFields.contains('org') ? contact.org : org,
		dealAgents: (contact.$assignedFields.contains('dealAgents') && contact.dealAgents != null) ? mergeModelLists(dealAgents, contact.dealAgents) : dealAgents,
		dealClients: (contact.$assignedFields.contains('dealClients') && contact.dealClients != null) ? mergeModelLists(dealClients, contact.dealClients) : dealClients,
		eventAttendees: (contact.$assignedFields.contains('eventAttendees') && contact.eventAttendees != null) ? mergeModelLists(eventAttendees, contact.eventAttendees) : eventAttendees,
		vendorRecords: (contact.$assignedFields.contains('vendorRecords') && contact.vendorRecords != null) ? mergeModelLists(vendorRecords, contact.vendorRecords) : vendorRecords,
		guestProfile: contact.$assignedFields.contains('guestProfile') ? contact.guestProfile : guestProfile,
		guestReviews: (contact.$assignedFields.contains('guestReviews') && contact.guestReviews != null) ? mergeModelLists(guestReviews, contact.guestReviews) : guestReviews,
		immigrationStatusChecks: (contact.$assignedFields.contains('immigrationStatusChecks') && contact.immigrationStatusChecks != null) ? mergeModelLists(immigrationStatusChecks, contact.immigrationStatusChecks) : immigrationStatusChecks,
		leads: (contact.$assignedFields.contains('leads') && contact.leads != null) ? mergeModelLists(leads, contact.leads) : leads,
		leases: (contact.$assignedFields.contains('leases') && contact.leases != null) ? mergeModelLists(leases, contact.leases) : leases,
		workOrders: (contact.$assignedFields.contains('workOrders') && contact.workOrders != null) ? mergeModelLists(workOrders, contact.workOrders) : workOrders,
		mortgageOffers: (contact.$assignedFields.contains('mortgageOffers') && contact.mortgageOffers != null) ? mergeModelLists(mortgageOffers, contact.mortgageOffers) : mortgageOffers,
		mortgagePreApprovals: (contact.$assignedFields.contains('mortgagePreApprovals') && contact.mortgagePreApprovals != null) ? mergeModelLists(mortgagePreApprovals, contact.mortgagePreApprovals) : mortgagePreApprovals,
		payoutProcessors: (contact.$assignedFields.contains('payoutProcessors') && contact.payoutProcessors != null) ? mergeModelLists(payoutProcessors, contact.payoutProcessors) : payoutProcessors,
		payoutRecipients: (contact.$assignedFields.contains('payoutRecipients') && contact.payoutRecipients != null) ? mergeModelLists(payoutRecipients, contact.payoutRecipients) : payoutRecipients,
		projects: (contact.$assignedFields.contains('projects') && contact.projects != null) ? mergeModelLists(projects, contact.projects) : projects,
		propertyCompliance: (contact.$assignedFields.contains('propertyCompliance') && contact.propertyCompliance != null) ? mergeModelLists(propertyCompliance, contact.propertyCompliance) : propertyCompliance,
		propertyOffers: (contact.$assignedFields.contains('propertyOffers') && contact.propertyOffers != null) ? mergeModelLists(propertyOffers, contact.propertyOffers) : propertyOffers,
		quotes: (contact.$assignedFields.contains('quotes') && contact.quotes != null) ? mergeModelLists(quotes, contact.quotes) : quotes,
		rentArrears: (contact.$assignedFields.contains('rentArrears') && contact.rentArrears != null) ? mergeModelLists(rentArrears, contact.rentArrears) : rentArrears,
		reservations: (contact.$assignedFields.contains('reservations') && contact.reservations != null) ? mergeModelLists(reservations, contact.reservations) : reservations,
		rightToRentChecks: (contact.$assignedFields.contains('rightToRentChecks') && contact.rightToRentChecks != null) ? mergeModelLists(rightToRentChecks, contact.rightToRentChecks) : rightToRentChecks,
		signatureSigners: (contact.$assignedFields.contains('signatureSigners') && contact.signatureSigners != null) ? mergeModelLists(signatureSigners, contact.signatureSigners) : signatureSigners,
		solicitorManagements: (contact.$assignedFields.contains('solicitorManagements') && contact.solicitorManagements != null) ? mergeModelLists(solicitorManagements, contact.solicitorManagements) : solicitorManagements,
		tasks: (contact.$assignedFields.contains('tasks') && contact.tasks != null) ? mergeModelLists(tasks, contact.tasks) : tasks,
		tax1099Forms: (contact.$assignedFields.contains('tax1099Forms') && contact.tax1099Forms != null) ? mergeModelLists(tax1099Forms, contact.tax1099Forms) : tax1099Forms,
		tenantApplications: (contact.$assignedFields.contains('tenantApplications') && contact.tenantApplications != null) ? mergeModelLists(tenantApplications, contact.tenantApplications) : tenantApplications,
		consentGivenAt: contact.$assignedFields.contains('consentGivenAt') ? contact.consentGivenAt : consentGivenAt,
		consentWithdrawnAt: contact.$assignedFields.contains('consentWithdrawnAt') ? contact.consentWithdrawnAt : consentWithdrawnAt,
		dataSubjectId: contact.$assignedFields.contains('dataSubjectId') ? contact.dataSubjectId : dataSubjectId,
		$assignedAppointmentsCount: contact.$assignedAppointmentsCount ?? $assignedAppointmentsCount,
		$appointmentsCount: contact.$appointmentsCount ?? $appointmentsCount,
		$attorneyCasesCount: contact.$attorneyCasesCount ?? $attorneyCasesCount,
		$bookingsCount: contact.$bookingsCount ?? $bookingsCount,
		$clientRelationshipsCount: contact.$clientRelationshipsCount ?? $clientRelationshipsCount,
		$dealAgentsCount: contact.$dealAgentsCount ?? $dealAgentsCount,
		$dealClientsCount: contact.$dealClientsCount ?? $dealClientsCount,
		$eventAttendeesCount: contact.$eventAttendeesCount ?? $eventAttendeesCount,
		$vendorRecordsCount: contact.$vendorRecordsCount ?? $vendorRecordsCount,
		$guestReviewsCount: contact.$guestReviewsCount ?? $guestReviewsCount,
		$immigrationStatusChecksCount: contact.$immigrationStatusChecksCount ?? $immigrationStatusChecksCount,
		$leadsCount: contact.$leadsCount ?? $leadsCount,
		$leasesCount: contact.$leasesCount ?? $leasesCount,
		$workOrdersCount: contact.$workOrdersCount ?? $workOrdersCount,
		$mortgageOffersCount: contact.$mortgageOffersCount ?? $mortgageOffersCount,
		$mortgagePreApprovalsCount: contact.$mortgagePreApprovalsCount ?? $mortgagePreApprovalsCount,
		$payoutProcessorsCount: contact.$payoutProcessorsCount ?? $payoutProcessorsCount,
		$payoutRecipientsCount: contact.$payoutRecipientsCount ?? $payoutRecipientsCount,
		$projectsCount: contact.$projectsCount ?? $projectsCount,
		$propertyComplianceCount: contact.$propertyComplianceCount ?? $propertyComplianceCount,
		$propertyOffersCount: contact.$propertyOffersCount ?? $propertyOffersCount,
		$quotesCount: contact.$quotesCount ?? $quotesCount,
		$rentArrearsCount: contact.$rentArrearsCount ?? $rentArrearsCount,
		$reservationsCount: contact.$reservationsCount ?? $reservationsCount,
		$rightToRentChecksCount: contact.$rightToRentChecksCount ?? $rightToRentChecksCount,
		$signatureSignersCount: contact.$signatureSignersCount ?? $signatureSignersCount,
		$solicitorManagementsCount: contact.$solicitorManagementsCount ?? $solicitorManagementsCount,
		$tasksCount: contact.$tasksCount ?? $tasksCount,
		$tax1099FormsCount: contact.$tax1099FormsCount ?? $tax1099FormsCount,
		$tenantApplicationsCount: contact.$tenantApplicationsCount ?? $tenantApplicationsCount
        );
    }


    /// Updates this instance with the values of the given instance,
  /// where the given instance has precedence.

    @override
    Contact updateWithInstanceValues(Contact contact) {
        if (contact.$assignedFields.contains('id')) { id = contact.id; }
		if (contact.$assignedFields.contains('orgId')) { orgId = contact.orgId; }
		if (contact.$assignedFields.contains('type')) { type = contact.type; }
		if (contact.$assignedFields.contains('fullName')) { fullName = contact.fullName; }
		if (contact.$assignedFields.contains('email')) { email = contact.email; }
		if (contact.$assignedFields.contains('phone')) { phone = contact.phone; }
		if (contact.$assignedFields.contains('notes')) { notes = contact.notes; }
		if (contact.$assignedFields.contains('locale')) { locale = contact.locale; }
		if (contact.$assignedFields.contains('currency')) { currency = contact.currency; }
		if (contact.$assignedFields.contains('createdAt')) { createdAt = contact.createdAt; }
		if (contact.$assignedFields.contains('updatedAt')) { updatedAt = contact.updatedAt; }
		if (contact.$assignedFields.contains('deletedAt')) { deletedAt = contact.deletedAt; }
		if (contact.$assignedFields.contains('assignedAppointments') && contact.assignedAppointments != null) { assignedAppointments = mergeModelLists(assignedAppointments, contact.assignedAppointments); }
		if (contact.$assignedFields.contains('appointments') && contact.appointments != null) { appointments = mergeModelLists(appointments, contact.appointments); }
		if (contact.$assignedFields.contains('attorneyCases') && contact.attorneyCases != null) { attorneyCases = mergeModelLists(attorneyCases, contact.attorneyCases); }
		if (contact.$assignedFields.contains('bookings') && contact.bookings != null) { bookings = mergeModelLists(bookings, contact.bookings); }
		if (contact.$assignedFields.contains('clientRelationships') && contact.clientRelationships != null) { clientRelationships = mergeModelLists(clientRelationships, contact.clientRelationships); }
		if (contact.$assignedFields.contains('org')) { org = contact.org; }
		if (contact.$assignedFields.contains('dealAgents') && contact.dealAgents != null) { dealAgents = mergeModelLists(dealAgents, contact.dealAgents); }
		if (contact.$assignedFields.contains('dealClients') && contact.dealClients != null) { dealClients = mergeModelLists(dealClients, contact.dealClients); }
		if (contact.$assignedFields.contains('eventAttendees') && contact.eventAttendees != null) { eventAttendees = mergeModelLists(eventAttendees, contact.eventAttendees); }
		if (contact.$assignedFields.contains('vendorRecords') && contact.vendorRecords != null) { vendorRecords = mergeModelLists(vendorRecords, contact.vendorRecords); }
		if (contact.$assignedFields.contains('guestProfile')) { guestProfile = contact.guestProfile; }
		if (contact.$assignedFields.contains('guestReviews') && contact.guestReviews != null) { guestReviews = mergeModelLists(guestReviews, contact.guestReviews); }
		if (contact.$assignedFields.contains('immigrationStatusChecks') && contact.immigrationStatusChecks != null) { immigrationStatusChecks = mergeModelLists(immigrationStatusChecks, contact.immigrationStatusChecks); }
		if (contact.$assignedFields.contains('leads') && contact.leads != null) { leads = mergeModelLists(leads, contact.leads); }
		if (contact.$assignedFields.contains('leases') && contact.leases != null) { leases = mergeModelLists(leases, contact.leases); }
		if (contact.$assignedFields.contains('workOrders') && contact.workOrders != null) { workOrders = mergeModelLists(workOrders, contact.workOrders); }
		if (contact.$assignedFields.contains('mortgageOffers') && contact.mortgageOffers != null) { mortgageOffers = mergeModelLists(mortgageOffers, contact.mortgageOffers); }
		if (contact.$assignedFields.contains('mortgagePreApprovals') && contact.mortgagePreApprovals != null) { mortgagePreApprovals = mergeModelLists(mortgagePreApprovals, contact.mortgagePreApprovals); }
		if (contact.$assignedFields.contains('payoutProcessors') && contact.payoutProcessors != null) { payoutProcessors = mergeModelLists(payoutProcessors, contact.payoutProcessors); }
		if (contact.$assignedFields.contains('payoutRecipients') && contact.payoutRecipients != null) { payoutRecipients = mergeModelLists(payoutRecipients, contact.payoutRecipients); }
		if (contact.$assignedFields.contains('projects') && contact.projects != null) { projects = mergeModelLists(projects, contact.projects); }
		if (contact.$assignedFields.contains('propertyCompliance') && contact.propertyCompliance != null) { propertyCompliance = mergeModelLists(propertyCompliance, contact.propertyCompliance); }
		if (contact.$assignedFields.contains('propertyOffers') && contact.propertyOffers != null) { propertyOffers = mergeModelLists(propertyOffers, contact.propertyOffers); }
		if (contact.$assignedFields.contains('quotes') && contact.quotes != null) { quotes = mergeModelLists(quotes, contact.quotes); }
		if (contact.$assignedFields.contains('rentArrears') && contact.rentArrears != null) { rentArrears = mergeModelLists(rentArrears, contact.rentArrears); }
		if (contact.$assignedFields.contains('reservations') && contact.reservations != null) { reservations = mergeModelLists(reservations, contact.reservations); }
		if (contact.$assignedFields.contains('rightToRentChecks') && contact.rightToRentChecks != null) { rightToRentChecks = mergeModelLists(rightToRentChecks, contact.rightToRentChecks); }
		if (contact.$assignedFields.contains('signatureSigners') && contact.signatureSigners != null) { signatureSigners = mergeModelLists(signatureSigners, contact.signatureSigners); }
		if (contact.$assignedFields.contains('solicitorManagements') && contact.solicitorManagements != null) { solicitorManagements = mergeModelLists(solicitorManagements, contact.solicitorManagements); }
		if (contact.$assignedFields.contains('tasks') && contact.tasks != null) { tasks = mergeModelLists(tasks, contact.tasks); }
		if (contact.$assignedFields.contains('tax1099Forms') && contact.tax1099Forms != null) { tax1099Forms = mergeModelLists(tax1099Forms, contact.tax1099Forms); }
		if (contact.$assignedFields.contains('tenantApplications') && contact.tenantApplications != null) { tenantApplications = mergeModelLists(tenantApplications, contact.tenantApplications); }
		if (contact.$assignedFields.contains('consentGivenAt')) { consentGivenAt = contact.consentGivenAt; }
		if (contact.$assignedFields.contains('consentWithdrawnAt')) { consentWithdrawnAt = contact.consentWithdrawnAt; }
		if (contact.$assignedFields.contains('dataSubjectId')) { dataSubjectId = contact.dataSubjectId; }
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
          ? {...?serializedTypes, 'Contact'} 
          : const {};
      return {
        if(id != null) 'id': id,
	if(orgId != null) 'orgId': orgId,
	if(type != null) 'type': type?.toJson(),
	if(fullName != null) 'fullName': fullName,
	if(email != null) 'email': email,
	if(phone != null) 'phone': phone,
	if(notes != null) 'notes': notes,
	if(locale != null) 'locale': locale,
	if(currency != null) 'currency': currency,
	if(createdAt != null) 'createdAt': createdAt?.toIso8601String(),
	if(updatedAt != null) 'updatedAt': updatedAt?.toIso8601String(),
	if(deletedAt != null) 'deletedAt': deletedAt?.toIso8601String(),
	if(assignedAppointments != null && (!preventCircularSerialization || !serializedModels.contains('Appointment'))) 'assignedAppointments': assignedAppointments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(appointments != null && (!preventCircularSerialization || !serializedModels.contains('Appointment'))) 'appointments': appointments?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(attorneyCases != null && (!preventCircularSerialization || !serializedModels.contains('AttorneyManagement'))) 'attorneyCases': attorneyCases?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(bookings != null && (!preventCircularSerialization || !serializedModels.contains('Booking'))) 'bookings': bookings?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(clientRelationships != null && (!preventCircularSerialization || !serializedModels.contains('ClientRelationship'))) 'clientRelationships': clientRelationships?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(org != null && (!preventCircularSerialization || !serializedModels.contains('Organization'))) 'org': org?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(dealAgents != null && (!preventCircularSerialization || !serializedModels.contains('Deal'))) 'dealAgents': dealAgents?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(dealClients != null && (!preventCircularSerialization || !serializedModels.contains('Deal'))) 'dealClients': dealClients?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(eventAttendees != null && (!preventCircularSerialization || !serializedModels.contains('EventAttendee'))) 'eventAttendees': eventAttendees?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(vendorRecords != null && (!preventCircularSerialization || !serializedModels.contains('FinancialRecord'))) 'vendorRecords': vendorRecords?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(guestProfile != null && (!preventCircularSerialization || !serializedModels.contains('GuestProfile'))) 'guestProfile': guestProfile?.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization),
	if(guestReviews != null && (!preventCircularSerialization || !serializedModels.contains('GuestReview'))) 'guestReviews': guestReviews?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(immigrationStatusChecks != null && (!preventCircularSerialization || !serializedModels.contains('ImmigrationStatusCheck'))) 'immigrationStatusChecks': immigrationStatusChecks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(leads != null && (!preventCircularSerialization || !serializedModels.contains('Lead'))) 'leads': leads?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(leases != null && (!preventCircularSerialization || !serializedModels.contains('Lease'))) 'leases': leases?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(workOrders != null && (!preventCircularSerialization || !serializedModels.contains('MaintenanceWorkOrder'))) 'workOrders': workOrders?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mortgageOffers != null && (!preventCircularSerialization || !serializedModels.contains('MortgageOffer'))) 'mortgageOffers': mortgageOffers?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(mortgagePreApprovals != null && (!preventCircularSerialization || !serializedModels.contains('MortgagePreApproval'))) 'mortgagePreApprovals': mortgagePreApprovals?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(payoutProcessors != null && (!preventCircularSerialization || !serializedModels.contains('Payout'))) 'payoutProcessors': payoutProcessors?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(payoutRecipients != null && (!preventCircularSerialization || !serializedModels.contains('Payout'))) 'payoutRecipients': payoutRecipients?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(projects != null && (!preventCircularSerialization || !serializedModels.contains('Project'))) 'projects': projects?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyCompliance != null && (!preventCircularSerialization || !serializedModels.contains('PropertyCompliance'))) 'propertyCompliance': propertyCompliance?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(propertyOffers != null && (!preventCircularSerialization || !serializedModels.contains('PropertyOffer'))) 'propertyOffers': propertyOffers?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(quotes != null && (!preventCircularSerialization || !serializedModels.contains('Quote'))) 'quotes': quotes?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(rentArrears != null && (!preventCircularSerialization || !serializedModels.contains('RentArrears'))) 'rentArrears': rentArrears?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(reservations != null && (!preventCircularSerialization || !serializedModels.contains('Reservation'))) 'reservations': reservations?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(rightToRentChecks != null && (!preventCircularSerialization || !serializedModels.contains('RightToRentCheck'))) 'rightToRentChecks': rightToRentChecks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(signatureSigners != null && (!preventCircularSerialization || !serializedModels.contains('SignatureSigner'))) 'signatureSigners': signatureSigners?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(solicitorManagements != null && (!preventCircularSerialization || !serializedModels.contains('SolicitorManagement'))) 'solicitorManagements': solicitorManagements?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tasks != null && (!preventCircularSerialization || !serializedModels.contains('Task'))) 'tasks': tasks?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tax1099Forms != null && (!preventCircularSerialization || !serializedModels.contains('Tax1099Form'))) 'tax1099Forms': tax1099Forms?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(tenantApplications != null && (!preventCircularSerialization || !serializedModels.contains('TenantApplication'))) 'tenantApplications': tenantApplications?.map((item) => item.toJson(serializedTypes: serializedModels, preventCircularSerialization: preventCircularSerialization)).toList(),
	if(consentGivenAt != null) 'consentGivenAt': consentGivenAt?.toIso8601String(),
	if(consentWithdrawnAt != null) 'consentWithdrawnAt': consentWithdrawnAt?.toIso8601String(),
	if(dataSubjectId != null) 'dataSubjectId': dataSubjectId,
		if ($assignedAppointmentsCount != null || $appointmentsCount != null || $attorneyCasesCount != null || $bookingsCount != null || $clientRelationshipsCount != null || $dealAgentsCount != null || $dealClientsCount != null || $eventAttendeesCount != null || $vendorRecordsCount != null || $guestReviewsCount != null || $immigrationStatusChecksCount != null || $leadsCount != null || $leasesCount != null || $workOrdersCount != null || $mortgageOffersCount != null || $mortgagePreApprovalsCount != null || $payoutProcessorsCount != null || $payoutRecipientsCount != null || $projectsCount != null || $propertyComplianceCount != null || $propertyOffersCount != null || $quotesCount != null || $rentArrearsCount != null || $reservationsCount != null || $rightToRentChecksCount != null || $signatureSignersCount != null || $solicitorManagementsCount != null || $tasksCount != null || $tax1099FormsCount != null || $tenantApplicationsCount != null) '_count': { 
		if ($assignedAppointmentsCount != null) 'assignedAppointments': $assignedAppointmentsCount, 
		if ($appointmentsCount != null) 'appointments': $appointmentsCount, 
		if ($attorneyCasesCount != null) 'attorneyCases': $attorneyCasesCount, 
		if ($bookingsCount != null) 'bookings': $bookingsCount, 
		if ($clientRelationshipsCount != null) 'clientRelationships': $clientRelationshipsCount, 
		if ($dealAgentsCount != null) 'dealAgents': $dealAgentsCount, 
		if ($dealClientsCount != null) 'dealClients': $dealClientsCount, 
		if ($eventAttendeesCount != null) 'eventAttendees': $eventAttendeesCount, 
		if ($vendorRecordsCount != null) 'vendorRecords': $vendorRecordsCount, 
		if ($guestReviewsCount != null) 'guestReviews': $guestReviewsCount, 
		if ($immigrationStatusChecksCount != null) 'immigrationStatusChecks': $immigrationStatusChecksCount, 
		if ($leadsCount != null) 'leads': $leadsCount, 
		if ($leasesCount != null) 'leases': $leasesCount, 
		if ($workOrdersCount != null) 'workOrders': $workOrdersCount, 
		if ($mortgageOffersCount != null) 'mortgageOffers': $mortgageOffersCount, 
		if ($mortgagePreApprovalsCount != null) 'mortgagePreApprovals': $mortgagePreApprovalsCount, 
		if ($payoutProcessorsCount != null) 'payoutProcessors': $payoutProcessorsCount, 
		if ($payoutRecipientsCount != null) 'payoutRecipients': $payoutRecipientsCount, 
		if ($projectsCount != null) 'projects': $projectsCount, 
		if ($propertyComplianceCount != null) 'propertyCompliance': $propertyComplianceCount, 
		if ($propertyOffersCount != null) 'propertyOffers': $propertyOffersCount, 
		if ($quotesCount != null) 'quotes': $quotesCount, 
		if ($rentArrearsCount != null) 'rentArrears': $rentArrearsCount, 
		if ($reservationsCount != null) 'reservations': $reservationsCount, 
		if ($rightToRentChecksCount != null) 'rightToRentChecks': $rightToRentChecksCount, 
		if ($signatureSignersCount != null) 'signatureSigners': $signatureSignersCount, 
		if ($solicitorManagementsCount != null) 'solicitorManagements': $solicitorManagementsCount, 
		if ($tasksCount != null) 'tasks': $tasksCount, 
		if ($tax1099FormsCount != null) 'tax1099Forms': $tax1099FormsCount, 
		if ($tenantApplicationsCount != null) 'tenantApplications': $tenantApplicationsCount, 
		},
      };
    }

      /// Determines whether this instance and another object represent the same
      /// instance.
    @override
    bool operator == (Object other) =>
            identical(this, other) || other is Contact &&
                runtimeType == other.runtimeType && $uid == other.$uid;

    /// Updates this instance with the values of the given instance,
    /// where this instance has precedence.
    @override
        int get hashCode => $uid.hashCode;
    }
    