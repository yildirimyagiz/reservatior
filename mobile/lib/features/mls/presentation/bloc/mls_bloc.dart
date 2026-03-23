import 'package:flutter_riverpod/flutter_riverpod.dart';

class MlsBloc extends StateNotifier<AsyncValue<List<dynamic>>> {
  MlsBloc() : super(const AsyncValue.data([]));
}
