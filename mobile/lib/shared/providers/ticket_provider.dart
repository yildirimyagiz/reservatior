import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/ticket_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Ticket Providers

final TicketServiceProvider = Provider<TicketService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TicketService(dioClient);
});

// List Provider
final ticketProvider = FutureProvider.autoDispose<List<Ticket>>((ref) async {
  final service = ref.watch(TicketServiceProvider);
  return service.getTickets();
});

// Create Provider
final TicketCreateProvider = FutureProvider.autoDispose<Ticket>((ref) async {
  final service = ref.watch(TicketServiceProvider);
  return service.createTicket(Ticket());
});

// Update Provider  
final TicketUpdateProvider = FutureProvider.autoDispose<Ticket>((ref) async {
  final service = ref.watch(TicketServiceProvider);
  final state = ref.watch(TicketUpdateStateProvider);
  if (state['id'] != null && state['ticket'] != null) {
    return service.updateTicket(state['id'], state['ticket']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final TicketDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(TicketServiceProvider);
  final state = ref.watch(TicketDeleteStateProvider);
  if (state != null) {
    return service.deleteTicket(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final TicketUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final TicketDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final TicketLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(ticketProvider);
  final createAsync = ref.watch(TicketCreateProvider);
  final updateAsync = ref.watch(TicketUpdateProvider);
  final deleteAsync = ref.watch(TicketDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
