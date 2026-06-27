import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/services/mobile_device_service.dart';
import 'package:reservatior/shared/repositories/mobile_device_repository.dart';
import 'package:reservatior/shared/models/models.dart';
import 'dio_client_provider.dart';

final mobileDeviceServiceProvider = Provider<MobileDeviceService>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  return MobileDeviceService(dioClient);
});

final mobileDeviceRepositoryProvider = Provider<MobileDeviceRepository>((ref) {
  final service = ref.watch(mobileDeviceServiceProvider);
  return MobileDeviceRepositoryImpl(service);
});

final mobileDeviceListProvider = FutureProvider.autoDispose<List<MobileDevice>>((ref) async {
  final repository = ref.watch(mobileDeviceRepositoryProvider);
  return repository.getAll();
});

final mobileDeviceCreateProvider = StateProvider<MobileDevice?>((ref) => null);
final mobileDeviceUpdateProvider = StateProvider<Map<String, dynamic>>((ref) => {});
final mobileDeviceDeleteProvider = StateProvider<String?>((ref) => null);
final mobileDeviceLoadingProvider = StateProvider<bool>((ref) => false);
