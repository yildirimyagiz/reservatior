import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/contact_service.dart';
import '../../core/network/dio_client.dart';
import '../../gen_models/models_library.dart';
import 'dio_client_provider.dart';

// Contact Providers

final ContactServiceProvider = Provider<ContactService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return ContactService(dioClient);
});

// List Provider
final contactProvider = FutureProvider.autoDispose<List<Contact>>((ref) async {
  final service = ref.watch(ContactServiceProvider);
  return service.getContacts();
});

// Create Provider
final ContactCreateProvider = FutureProvider.autoDispose<Contact>((ref) async {
  final service = ref.watch(ContactServiceProvider);
  return service.createContact(Contact());
});

// Update Provider  
final ContactUpdateProvider = FutureProvider.autoDispose<Contact>((ref) async {
  final service = ref.watch(ContactServiceProvider);
  final state = ref.watch(ContactUpdateStateProvider);
  if (state['id'] != null && state['contact'] != null) {
    return service.updateContact(state['id'], state['contact']);
  }
  throw Exception('No update data provided');
});

// Delete Provider
final ContactDeleteProvider = FutureProvider.autoDispose<void>((ref) async {
  final service = ref.watch(ContactServiceProvider);
  final state = ref.watch(ContactDeleteStateProvider);
  if (state != null) {
    return service.deleteContact(state);
  }
  throw Exception('No delete ID provided');
});

// State Providers
final ContactUpdateStateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final ContactDeleteStateProvider = StateProvider<String?>((ref) => null);

// Loading Provider
final ContactLoadingProvider = Provider<bool>((ref) {
  final listAsync = ref.watch(contactProvider);
  final createAsync = ref.watch(ContactCreateProvider);
  final updateAsync = ref.watch(ContactUpdateProvider);
  final deleteAsync = ref.watch(ContactDeleteProvider);
  
  return listAsync.isLoading || 
         createAsync.isLoading || 
         updateAsync.isLoading || 
         deleteAsync.isLoading;
});
