import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/features/client/contacts/data/models/contact_model.dart';
import 'package:reservatior/features/client/contacts/data/services/contact_service.dart';

final contactServiceProvider = Provider((ref) {
  return ContactService(DioClient());
});

final contactProvider = StateNotifierProvider<ContactNotifier, AsyncValue<List<ContactModel>>>((ref) {
  return ContactNotifier(ref.watch(contactServiceProvider));
});

class ContactNotifier extends StateNotifier<AsyncValue<List<ContactModel>>> {
  final ContactService _service;

  ContactNotifier(this._service) : super(const AsyncValue.loading()) {
    fetchContacts();
  }

  Future<void> fetchContacts() async {
    state = const AsyncValue.loading();
    try {
      final contacts = await _service.getContacts();
      state = AsyncValue.data(contacts);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> createContact(String fullName, String email, String phone, String type) async {
    try {
      await _service.createContact(fullName, email, phone, type);
      await fetchContacts();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> deleteContact(String id) async {
    try {
      await _service.deleteContact(id);
      await fetchContacts();
    } catch (e) {
      rethrow;
    }
  }
}
