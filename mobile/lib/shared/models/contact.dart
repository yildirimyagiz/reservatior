import 'package:reservatior/shared/enums/contact_type.dart';
import 'appointment.dart';
import 'attorney_management.dart';
import 'booking.dart';
import 'client_relationship.dart';
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
import 'organization.dart';
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

class Contact {
  final String id;
  final String orgId;
  final ContactType type;
  final String fullName;
  final String? email;
  final String? phone;
  final String? notes;
  final String? locale;
  final String? currency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final DateTime? deletedAt;
  final List<Appointment> assignedAppointments;
  final List<Appointment> appointments;
  final List<AttorneyManagement> attorneyCases;
  final List<Booking> bookings;
  final List<ClientRelationship> clientRelationships;
  final Organization org;
  final List<Deal> dealAgents;
  final List<Deal> dealClients;
  final List<EventAttendee> eventAttendees;
  final List<FinancialRecord> vendorRecords;
  final GuestProfile? guestProfile;
  final List<GuestReview> guestReviews;
  final List<ImmigrationStatusCheck> immigrationStatusChecks;
  final List<Lead> leads;
  final List<Lease> leases;
  final List<MaintenanceWorkOrder> workOrders;
  final List<MortgageOffer> mortgageOffers;
  final List<MortgagePreApproval> mortgagePreApprovals;
  final List<Payout> payoutProcessors;
  final List<Payout> payoutRecipients;
  final List<Project> projects;
  final List<PropertyCompliance> propertyCompliance;
  final List<PropertyOffer> propertyOffers;
  final List<Quote> quotes;
  final List<RentArrears> rentArrears;
  final List<Reservation> reservations;
  final List<RightToRentCheck> rightToRentChecks;
  final List<SignatureSigner> signatureSigners;
  final List<SolicitorManagement> solicitorManagements;
  final List<Task> tasks;
  final List<Tax1099Form> tax1099Forms;
  final List<TenantApplication> tenantApplications;
  final DateTime? consentGivenAt;
  final DateTime? consentWithdrawnAt;
  final String? dataSubjectId;

  const Contact({
    required this.id,
    required this.orgId,
    required this.type,
    required this.fullName,
    this.email,
    this.phone,
    this.notes,
    this.locale,
    this.currency,
    required this.createdAt,
    required this.updatedAt,
    this.deletedAt,
    this.assignedAppointments = const [],
    this.appointments = const [],
    this.attorneyCases = const [],
    this.bookings = const [],
    this.clientRelationships = const [],
    required this.org,
    this.dealAgents = const [],
    this.dealClients = const [],
    this.eventAttendees = const [],
    this.vendorRecords = const [],
    this.guestProfile,
    this.guestReviews = const [],
    this.immigrationStatusChecks = const [],
    this.leads = const [],
    this.leases = const [],
    this.workOrders = const [],
    this.mortgageOffers = const [],
    this.mortgagePreApprovals = const [],
    this.payoutProcessors = const [],
    this.payoutRecipients = const [],
    this.projects = const [],
    this.propertyCompliance = const [],
    this.propertyOffers = const [],
    this.quotes = const [],
    this.rentArrears = const [],
    this.reservations = const [],
    this.rightToRentChecks = const [],
    this.signatureSigners = const [],
    this.solicitorManagements = const [],
    this.tasks = const [],
    this.tax1099Forms = const [],
    this.tenantApplications = const [],
    this.consentGivenAt,
    this.consentWithdrawnAt,
    this.dataSubjectId,
  });

  factory Contact.fromJson(Map<String, dynamic> json) {
    return Contact(
      id: json['id'] as String,
      orgId: json['orgId'] as String,
      type: ContactType.values.firstWhere((v) => v.name == json['type']),
      fullName: json['fullName'] as String,
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      notes: json['notes'] as String?,
      locale: json['locale'] as String?,
      currency: json['currency'] as String?,
      createdAt: DateTime.parse(json['createdAt'] as String),
      updatedAt: DateTime.parse(json['updatedAt'] as String),
      deletedAt: json['deletedAt'] != null ? DateTime.parse(json['deletedAt'] as String) : null,
      assignedAppointments: (json['assignedAppointments'] as List<dynamic>?)?.map((e) => Appointment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      appointments: (json['appointments'] as List<dynamic>?)?.map((e) => Appointment.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      attorneyCases: (json['attorneyCases'] as List<dynamic>?)?.map((e) => AttorneyManagement.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      bookings: (json['bookings'] as List<dynamic>?)?.map((e) => Booking.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      clientRelationships: (json['clientRelationships'] as List<dynamic>?)?.map((e) => ClientRelationship.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      org: Organization.fromJson(json['org'] as Map<String, dynamic>),
      dealAgents: (json['dealAgents'] as List<dynamic>?)?.map((e) => Deal.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      dealClients: (json['dealClients'] as List<dynamic>?)?.map((e) => Deal.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      eventAttendees: (json['eventAttendees'] as List<dynamic>?)?.map((e) => EventAttendee.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      vendorRecords: (json['vendorRecords'] as List<dynamic>?)?.map((e) => FinancialRecord.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      guestProfile: json['guestProfile'] != null ? GuestProfile.fromJson(json['guestProfile'] as Map<String, dynamic>) : null,
      guestReviews: (json['guestReviews'] as List<dynamic>?)?.map((e) => GuestReview.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      immigrationStatusChecks: (json['immigrationStatusChecks'] as List<dynamic>?)?.map((e) => ImmigrationStatusCheck.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      leads: (json['leads'] as List<dynamic>?)?.map((e) => Lead.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      leases: (json['leases'] as List<dynamic>?)?.map((e) => Lease.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      workOrders: (json['workOrders'] as List<dynamic>?)?.map((e) => MaintenanceWorkOrder.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mortgageOffers: (json['mortgageOffers'] as List<dynamic>?)?.map((e) => MortgageOffer.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      mortgagePreApprovals: (json['mortgagePreApprovals'] as List<dynamic>?)?.map((e) => MortgagePreApproval.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      payoutProcessors: (json['payoutProcessors'] as List<dynamic>?)?.map((e) => Payout.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      payoutRecipients: (json['payoutRecipients'] as List<dynamic>?)?.map((e) => Payout.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      projects: (json['projects'] as List<dynamic>?)?.map((e) => Project.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyCompliance: (json['propertyCompliance'] as List<dynamic>?)?.map((e) => PropertyCompliance.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      propertyOffers: (json['propertyOffers'] as List<dynamic>?)?.map((e) => PropertyOffer.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      quotes: (json['quotes'] as List<dynamic>?)?.map((e) => Quote.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      rentArrears: (json['rentArrears'] as List<dynamic>?)?.map((e) => RentArrears.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      reservations: (json['reservations'] as List<dynamic>?)?.map((e) => Reservation.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      rightToRentChecks: (json['rightToRentChecks'] as List<dynamic>?)?.map((e) => RightToRentCheck.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      signatureSigners: (json['signatureSigners'] as List<dynamic>?)?.map((e) => SignatureSigner.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      solicitorManagements: (json['solicitorManagements'] as List<dynamic>?)?.map((e) => SolicitorManagement.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tasks: (json['tasks'] as List<dynamic>?)?.map((e) => Task.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tax1099Forms: (json['tax1099Forms'] as List<dynamic>?)?.map((e) => Tax1099Form.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      tenantApplications: (json['tenantApplications'] as List<dynamic>?)?.map((e) => TenantApplication.fromJson(e as Map<String, dynamic>)).toList() ?? [],
      consentGivenAt: json['consentGivenAt'] != null ? DateTime.parse(json['consentGivenAt'] as String) : null,
      consentWithdrawnAt: json['consentWithdrawnAt'] != null ? DateTime.parse(json['consentWithdrawnAt'] as String) : null,
      dataSubjectId: json['dataSubjectId'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'orgId': orgId,
      'type': type.name,
      'fullName': fullName,
      'email': email,
      'phone': phone,
      'notes': notes,
      'locale': locale,
      'currency': currency,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'deletedAt': deletedAt?.toIso8601String(),
      'assignedAppointments': assignedAppointments.map((e) => e.toJson()).toList(),
      'appointments': appointments.map((e) => e.toJson()).toList(),
      'attorneyCases': attorneyCases.map((e) => e.toJson()).toList(),
      'bookings': bookings.map((e) => e.toJson()).toList(),
      'clientRelationships': clientRelationships.map((e) => e.toJson()).toList(),
      'org': org.toJson(),
      'dealAgents': dealAgents.map((e) => e.toJson()).toList(),
      'dealClients': dealClients.map((e) => e.toJson()).toList(),
      'eventAttendees': eventAttendees.map((e) => e.toJson()).toList(),
      'vendorRecords': vendorRecords.map((e) => e.toJson()).toList(),
      'guestProfile': guestProfile?.toJson(),
      'guestReviews': guestReviews.map((e) => e.toJson()).toList(),
      'immigrationStatusChecks': immigrationStatusChecks.map((e) => e.toJson()).toList(),
      'leads': leads.map((e) => e.toJson()).toList(),
      'leases': leases.map((e) => e.toJson()).toList(),
      'workOrders': workOrders.map((e) => e.toJson()).toList(),
      'mortgageOffers': mortgageOffers.map((e) => e.toJson()).toList(),
      'mortgagePreApprovals': mortgagePreApprovals.map((e) => e.toJson()).toList(),
      'payoutProcessors': payoutProcessors.map((e) => e.toJson()).toList(),
      'payoutRecipients': payoutRecipients.map((e) => e.toJson()).toList(),
      'projects': projects.map((e) => e.toJson()).toList(),
      'propertyCompliance': propertyCompliance.map((e) => e.toJson()).toList(),
      'propertyOffers': propertyOffers.map((e) => e.toJson()).toList(),
      'quotes': quotes.map((e) => e.toJson()).toList(),
      'rentArrears': rentArrears.map((e) => e.toJson()).toList(),
      'reservations': reservations.map((e) => e.toJson()).toList(),
      'rightToRentChecks': rightToRentChecks.map((e) => e.toJson()).toList(),
      'signatureSigners': signatureSigners.map((e) => e.toJson()).toList(),
      'solicitorManagements': solicitorManagements.map((e) => e.toJson()).toList(),
      'tasks': tasks.map((e) => e.toJson()).toList(),
      'tax1099Forms': tax1099Forms.map((e) => e.toJson()).toList(),
      'tenantApplications': tenantApplications.map((e) => e.toJson()).toList(),
      'consentGivenAt': consentGivenAt?.toIso8601String(),
      'consentWithdrawnAt': consentWithdrawnAt?.toIso8601String(),
      'dataSubjectId': dataSubjectId,
    };
  }

  Contact copyWith({
    String? id,
    String? orgId,
    ContactType? type,
    String? fullName,
    String? email,
    String? phone,
    String? notes,
    String? locale,
    String? currency,
    DateTime? createdAt,
    DateTime? updatedAt,
    DateTime? deletedAt,
    List<Appointment>? assignedAppointments,
    List<Appointment>? appointments,
    List<AttorneyManagement>? attorneyCases,
    List<Booking>? bookings,
    List<ClientRelationship>? clientRelationships,
    Organization? org,
    List<Deal>? dealAgents,
    List<Deal>? dealClients,
    List<EventAttendee>? eventAttendees,
    List<FinancialRecord>? vendorRecords,
    GuestProfile? guestProfile,
    List<GuestReview>? guestReviews,
    List<ImmigrationStatusCheck>? immigrationStatusChecks,
    List<Lead>? leads,
    List<Lease>? leases,
    List<MaintenanceWorkOrder>? workOrders,
    List<MortgageOffer>? mortgageOffers,
    List<MortgagePreApproval>? mortgagePreApprovals,
    List<Payout>? payoutProcessors,
    List<Payout>? payoutRecipients,
    List<Project>? projects,
    List<PropertyCompliance>? propertyCompliance,
    List<PropertyOffer>? propertyOffers,
    List<Quote>? quotes,
    List<RentArrears>? rentArrears,
    List<Reservation>? reservations,
    List<RightToRentCheck>? rightToRentChecks,
    List<SignatureSigner>? signatureSigners,
    List<SolicitorManagement>? solicitorManagements,
    List<Task>? tasks,
    List<Tax1099Form>? tax1099Forms,
    List<TenantApplication>? tenantApplications,
    DateTime? consentGivenAt,
    DateTime? consentWithdrawnAt,
    String? dataSubjectId,
  }) {
    return Contact(
      id: id ?? this.id,
      orgId: orgId ?? this.orgId,
      type: type ?? this.type,
      fullName: fullName ?? this.fullName,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      notes: notes ?? this.notes,
      locale: locale ?? this.locale,
      currency: currency ?? this.currency,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      deletedAt: deletedAt ?? this.deletedAt,
      assignedAppointments: assignedAppointments ?? this.assignedAppointments,
      appointments: appointments ?? this.appointments,
      attorneyCases: attorneyCases ?? this.attorneyCases,
      bookings: bookings ?? this.bookings,
      clientRelationships: clientRelationships ?? this.clientRelationships,
      org: org ?? this.org,
      dealAgents: dealAgents ?? this.dealAgents,
      dealClients: dealClients ?? this.dealClients,
      eventAttendees: eventAttendees ?? this.eventAttendees,
      vendorRecords: vendorRecords ?? this.vendorRecords,
      guestProfile: guestProfile ?? this.guestProfile,
      guestReviews: guestReviews ?? this.guestReviews,
      immigrationStatusChecks: immigrationStatusChecks ?? this.immigrationStatusChecks,
      leads: leads ?? this.leads,
      leases: leases ?? this.leases,
      workOrders: workOrders ?? this.workOrders,
      mortgageOffers: mortgageOffers ?? this.mortgageOffers,
      mortgagePreApprovals: mortgagePreApprovals ?? this.mortgagePreApprovals,
      payoutProcessors: payoutProcessors ?? this.payoutProcessors,
      payoutRecipients: payoutRecipients ?? this.payoutRecipients,
      projects: projects ?? this.projects,
      propertyCompliance: propertyCompliance ?? this.propertyCompliance,
      propertyOffers: propertyOffers ?? this.propertyOffers,
      quotes: quotes ?? this.quotes,
      rentArrears: rentArrears ?? this.rentArrears,
      reservations: reservations ?? this.reservations,
      rightToRentChecks: rightToRentChecks ?? this.rightToRentChecks,
      signatureSigners: signatureSigners ?? this.signatureSigners,
      solicitorManagements: solicitorManagements ?? this.solicitorManagements,
      tasks: tasks ?? this.tasks,
      tax1099Forms: tax1099Forms ?? this.tax1099Forms,
      tenantApplications: tenantApplications ?? this.tenantApplications,
      consentGivenAt: consentGivenAt ?? this.consentGivenAt,
      consentWithdrawnAt: consentWithdrawnAt ?? this.consentWithdrawnAt,
      dataSubjectId: dataSubjectId ?? this.dataSubjectId,
    );
  }
}
