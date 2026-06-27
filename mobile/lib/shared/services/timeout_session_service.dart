import 'dart:async';
import 'package:flutter/material.dart';
import 'package:local_session_timeout/local_session_timeout.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reservatior/shared/providers/auth_provider.dart';

class TimeoutSessionService {
  late final SessionTimeoutManager _sessionTimeoutManager;
  final _timeoutStreamController = StreamController<SessionState>();

  TimeoutSessionService() {
    _sessionTimeoutManager = SessionTimeoutManager(
      userActivityDebounceDuration: const Duration(seconds: 1),
      sessionConfig: SessionConfig(
        invalidateSessionForAppLostFocus: const Duration(minutes: 5),
        invalidateSessionForUserInactivity: const Duration(minutes: 15),
      ),
      sessionStateStream: _timeoutStreamController.stream,
      child: Container(), // Required child parameter
    );
  }

  Stream<SessionState> get sessionStateStream => _timeoutStreamController.stream;

  void resetSession() {
    _timeoutStreamController.add(SessionState.startListening);
  }

  void stopListening() {
    _timeoutStreamController.add(SessionState.stopListening);
  }

  void onTimeout() {
    // Handle logout or show warning
    // This will be handled by the provider
  }
}

final timeoutSessionServiceProvider = Provider<TimeoutSessionService>((ref) {
  return TimeoutSessionService();
});
