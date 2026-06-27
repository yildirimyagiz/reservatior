import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/ticket_service.dart';
import 'package:reservatior/shared/repositories/ticket_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final ticketServiceProvider = Provider<TicketService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return TicketService(dioClient);
});

final ticketRepositoryProvider = Provider<TicketRepository>((ref) {
  final service = ref.watch(ticketServiceProvider);
  return TicketRepositoryImpl(service);
});

final ticketListProvider = FutureProvider.autoDispose<List<Ticket>>((ref) async {
  final repository = ref.watch(ticketRepositoryProvider);
  return repository.getAll();
});

final ticketCreateProvider = StateProvider<Ticket?>((ref) => null);
final ticketUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ticketDeleteProvider = StateProvider<String?>((ref) => null);
final ticketLoadingProvider = StateProvider<bool>((ref) => false);
