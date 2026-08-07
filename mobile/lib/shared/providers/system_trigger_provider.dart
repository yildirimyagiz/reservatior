import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/core/network/dio_client.dart';
import 'package:reservatior/shared/models/user.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';
import 'package:reservatior/shared/providers/dio_client_provider.dart';
import 'package:reservatior/shared/services/sse_trigger_service.dart';

class TriggerTask {
  final String id;
  final String source;
  final String type;
  final String status;
  final String title;
  final String description;
  final DateTime createdAt;
  final int progress;

  TriggerTask({
    required this.id,
    required this.source,
    required this.type,
    required this.status,
    required this.title,
    required this.description,
    required this.createdAt,
    required this.progress,
  });

  factory TriggerTask.fromJson(Map<String, dynamic> json) {
    return TriggerTask(
      id: json['id'] as String,
      source: json['source'] as String,
      type: json['type'] as String,
      status: json['status'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      createdAt: DateTime.parse(json['createdAt'] as String),
      progress: json['progress'] as int? ?? 0,
    );
  }
}

class SystemTriggerState {
  final List<TriggerTask> tasks;
  final List<SseEvent> liveEvents;
  final bool isLoading;
  final String? errorMessage;
  final bool isConnected;
  final bool isOffline;

  SystemTriggerState({
    required this.tasks,
    required this.liveEvents,
    required this.isLoading,
    this.errorMessage,
    required this.isConnected,
    required this.isOffline,
  });

  SystemTriggerState copyWith({
    List<TriggerTask>? tasks,
    List<SseEvent>? liveEvents,
    bool? isLoading,
    String? errorMessage,
    bool? isConnected,
    bool? isOffline,
  }) {
    return SystemTriggerState(
      tasks: tasks ?? this.tasks,
      liveEvents: liveEvents ?? this.liveEvents,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isConnected: isConnected ?? this.isConnected,
      isOffline: isOffline ?? this.isOffline,
    );
  }
}

class SystemTriggerNotifier extends StateNotifier<SystemTriggerState> {
  final DioClient _dioClient;
  final SseTriggerService _sseService;
  final User? _user;
  final Connectivity _connectivity = Connectivity();
  StreamSubscription<SseEvent>? _sseSubscription;
  StreamSubscription<List<ConnectivityResult>>? _connectivitySubscription;
  Timer? _pollingTimer;

  SystemTriggerNotifier(this._dioClient, this._sseService, this._user)
      : super(SystemTriggerState(
          tasks: [],
          liveEvents: [],
          isLoading: true,
          isConnected: false,
          isOffline: false,
        )) {
    fetchTasks();
    _startSseListening();

    // Fallback polling every 10 seconds in case SSE drops
    _pollingTimer = Timer.periodic(const Duration(seconds: 10), (_) => fetchTasks(showLoading: false));

    // Initial connectivity check + listen for changes
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      _onConnectivityChanged,
      onError: (_) {},
    );
    _checkInitialConnectivity();
  }

  Future<void> _checkInitialConnectivity() async {
    try {
      final results = await _connectivity.checkConnectivity();
      await _onConnectivityChanged(results);
    } catch (e) {
      debugPrint('ℹ️ Initial connectivity check failed: $e');
    }
  }

  Future<void> _onConnectivityChanged(List<ConnectivityResult> results) async {
    final isOffline = results.contains(ConnectivityResult.none) || results.isEmpty;
    if (isOffline == state.isOffline) return;

    state = state.copyWith(isOffline: isOffline, isConnected: isOffline ? false : state.isConnected);
    if (isOffline) {
      debugPrint('ℹ️ Device offline — pausing SSE stream');
      _sseService.stopConnection();
    } else {
      debugPrint('ℹ️ Device online — resuming SSE stream');
      _startSseListening();
      fetchTasks(showLoading: false);
    }
  }

  Future<void> fetchTasks({bool showLoading = true}) async {
    if (_user == null) return;
    
    if (showLoading && state.tasks.isEmpty) {
      state = state.copyWith(isLoading: true);
    }
    
    try {
      final orgId = _user!.organizationId ?? 'global';
      final userId = _user!.id;
      
      final response = await _dioClient.get(
        '/system/triggers',
        queryParameters: {'orgId': orgId, 'userId': userId},
      );
      
      if (response.statusCode == 200 && response.data['success'] == true) {
        final list = response.data['data'] as List? ?? [];
        final tasks = list.map((json) => TriggerTask.fromJson(json)).toList();
        
        state = state.copyWith(
          tasks: tasks,
          isLoading: false,
          errorMessage: null,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to fetch active tasks',
        );
      }
    } catch (e) {
      debugPrint('❌ Failed to fetch system triggers: $e');
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void _startSseListening() {
    _sseSubscription?.cancel();
    if (state.isOffline) {
      debugPrint('ℹ️ Skipping SSE start — device offline');
      return;
    }

    _sseSubscription = _sseService.eventStream.listen(
      (event) {
        // Update connection status
        final wasConnected = state.isConnected;
        
        // Add to live events
        final updatedEvents = [event, ...state.liveEvents];
        if (updatedEvents.length > 5) {
          updatedEvents.removeLast();
        }
        
        state = state.copyWith(
          liveEvents: updatedEvents,
          isConnected: _sseService.isConnected,
        );
        
        // Trigger a refresh immediately, and again after 1.5 seconds to capture DB updates
        fetchTasks(showLoading: false);
        Future.delayed(const Duration(milliseconds: 1500), () {
          fetchTasks(showLoading: false);
        });
      },
      onError: (err) {
        state = state.copyWith(isConnected: false);
      },
      onDone: () {
        state = state.copyWith(isConnected: false);
      },
    );
    
    // Update connectivity state periodically based on service status
    Timer.periodic(const Duration(seconds: 2), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (state.isConnected != _sseService.isConnected) {
        state = state.copyWith(isConnected: _sseService.isConnected);
      }
    });
  }

  @override
  void dispose() {
    _sseSubscription?.cancel();
    _pollingTimer?.cancel();
    _connectivitySubscription?.cancel();
    _sseService.stopConnection();
    super.dispose();
  }
}

final systemTriggerProvider = StateNotifierProvider.autoDispose<SystemTriggerNotifier, SystemTriggerState>((ref) {
  final dioClient = ref.watch(dioClientProvider);
  final authState = ref.watch(authProvider);
  final user = authState.user;
  
  final service = SseTriggerService();
  return SystemTriggerNotifier(dioClient, service, user);
});
