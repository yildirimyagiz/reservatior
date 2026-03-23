import 'package:flutter_test/flutter_test.dart';
import 'package:equatable/equatable.dart';
import 'package:reservatour/features/auth/domain/entities/session_entity.dart';

void main() {
  group('SessionEntity', () {
    const createdAt = DateTime.parse('2023-01-01T00:00:00.000Z');
    const updatedAt = DateTime.parse('2023-01-01T01:00:00.000Z');
    const expiresAt = DateTime.parse('2023-01-02T00:00:00.000Z');
    const lastAccessAt = DateTime.parse('2023-01-01T12:00:00.000Z');

    const testSession = SessionEntity(
      id: 'test-session-id',
      userId: 'test-user-id',
      orgId: 'test-org-id',
      deviceId: 'test-device-id',
      token: 'test-token',
      refreshToken: 'test-refresh-token',
      location: 'Istanbul, Turkey',
      userAgent: 'Mozilla/5.0 (Test Browser)',
      ipAddress: '192.168.1.1',
      createdAt: createdAt,
      updatedAt: updatedAt,
      expiresAt: expiresAt,
      lastAccessAt: lastAccessAt,
      metadata: {'key': 'value'},
      isActive: true,
      isExpired: false,
      isRevoked: false,
    );

    test('should create SessionEntity with required properties', () {
      expect(testSession.id, equals('test-session-id'));
      expect(testSession.userId, equals('test-user-id'));
      expect(testSession.orgId, equals('test-org-id'));
      expect(testSession.deviceId, equals('test-device-id'));
      expect(testSession.token, equals('test-token'));
    });

    test('should copyWith correctly update properties', () {
      final updatedSession = testSession.copyWith(
        isActive: false,
        lastAccessAt: DateTime.parse('2023-01-01T13:00:00.000Z'),
      );

      expect(updatedSession.id, equals(testSession.id));
      expect(updatedSession.isActive, equals(false));
      expect(updatedSession.lastAccessAt, equals(DateTime.parse('2023-01-01T13:00:00.000Z')));
    });

    test('should return correct hasRefreshToken', () {
      expect(testSession.hasRefreshToken, isTrue);
      
      final sessionWithoutRefreshToken = testSession.copyWith(refreshToken: null);
      expect(sessionWithoutRefreshToken.hasRefreshToken, isFalse);
    });

    test('should return correct hasLocation', () {
      expect(testSession.hasLocation, isTrue);
      
      final sessionWithoutLocation = testSession.copyWith(location: null);
      expect(sessionWithoutLocation.hasLocation, isFalse);
    });

    test('should return correct hasUserAgent', () {
      expect(testSession.hasUserAgent, isTrue);
      
      final sessionWithoutUserAgent = testSession.copyWith(userAgent: null);
      expect(sessionWithoutUserAgent.hasUserAgent, isFalse);
    });

    test('should return correct hasIpAddress', () {
      expect(testSession.hasIpAddress, isTrue);
      
      final sessionWithoutIpAddress = testSession.copyWith(ipAddress: null);
      expect(sessionWithoutIpAddress.hasIpAddress, isFalse);
    });

    test('should return correct hasExpiresAt', () {
      expect(testSession.hasExpiresAt, isTrue);
      
      final sessionWithoutExpiresAt = testSession.copyWith(expiresAt: null);
      expect(sessionWithoutExpiresAt.hasExpiresAt, isFalse);
    });

    test('should return correct hasLastAccessAt', () {
      expect(testSession.hasLastAccessAt, isTrue);
      
      final sessionWithoutLastAccessAt = testSession.copyWith(lastAccessAt: null);
      expect(sessionWithoutLastAccessAt.hasLastAccessAt, isFalse);
    });

    test('should return correct hasMetadata', () {
      expect(testSession.hasMetadata, isTrue);
      
      final sessionWithoutMetadata = testSession.copyWith(metadata: {});
      expect(sessionWithoutMetadata.hasMetadata, isFalse);
    });

    test('should return correct isValid', () {
      expect(testSession.isValid, isTrue);
      
      final expiredSession = testSession.copyWith(isExpired: true);
      expect(expiredSession.isValid, isFalse);
      
      final revokedSession = testSession.copyWith(isRevoked: true);
      expect(revokedSession.isValid, isFalse);
    });

    test('should return correct isExpiredNow', () {
      expect(testSession.isExpiredNow, isFalse);
      
      final expiredSession = testSession.copyWith(expiresAt: DateTime.now().subtract(const Duration(hours: 1)));
      expect(expiredSession.isExpiredNow, isTrue);
    });

    test('should return correct willExpireSoon', () {
      expect(testSession.willExpireSoon(), isFalse);
      
      final soonToExpireSession = testSession.copyWith(expiresAt: DateTime.now().add(const Duration(hours: 6)));
      expect(soonToExpireSession.willExpireSoon(), isTrue);
    });

    test('should return correct timeSinceCreated', () {
      final timeSinceCreated = testSession.timeSinceCreated;
      expect(timeSinceCreated.inHours, greaterThan(0));
    });

    test('should return correct timeSinceLastAccess', () {
      final timeSinceLastAccess = testSession.timeSinceLastAccess;
      expect(timeSinceLastAccess.inHours, greaterThan(0));
    });

    test('should return correct timeToExpiry', () {
      final timeToExpiry = testSession.timeToExpiry;
      expect(timeToExpiry.inHours, greaterThan(0));
    });

    test('should return correct timeSinceCreatedDisplay', () {
      final display = testSession.timeSinceCreatedDisplay;
      expect(display, isA<String>());
      expect(display.isNotEmpty, isTrue);
    });

    test('should return correct timeSinceLastAccessDisplay', () {
      final display = testSession.timeSinceLastAccessDisplay;
      expect(display, isA<String>());
      expect(display.isNotEmpty, isTrue);
    });

    test('should return correct timeToExpiryDisplay', () {
      final display = testSession.timeToExpiryDisplay;
      expect(display, isA<String>());
      expect(display.isNotEmpty, isTrue);
    });

    test('should markAsExpired correctly', () {
      final mutableSession = testSession;
      mutableSession.markAsExpired();
      
      expect(mutableSession.isExpired, isTrue);
      expect(mutableSession.isActive, isFalse);
    });

    test('should markAsRevoked correctly', () {
      final mutableSession = testSession;
      mutableSession.markAsRevoked();
      
      expect(mutableSession.isRevoked, isTrue);
      expect(mutableSession.isActive, isFalse);
    });

    test('should activate correctly', () {
      final mutableSession = testSession.copyWith(isActive: false);
      mutableSession.activate();
      
      expect(mutableSession.isActive, isTrue);
      expect(mutableSession.isExpired, isFalse);
      expect(mutableSession.isRevoked, isFalse);
    });

    test('should deactivate correctly', () {
      final mutableSession = testSession;
      mutableSession.deactivate();
      
      expect(mutableSession.isActive, isFalse);
    });

    test('should extendSession correctly', () {
      final mutableSession = testSession;
      final newExpiry = DateTime.now().add(const Duration(days: 2));
      mutableSession.extendSession(newExpiry);
      
      expect(mutableSession.expiresAt, equals(newExpiry));
    });

    test('should updateLastAccess correctly', () {
      final mutableSession = testSession;
      final newAccessTime = DateTime.now();
      mutableSession.updateLastAccess(newAccessTime);
      
      expect(mutableSession.lastAccessAt, equals(newAccessTime));
    });

    test('should setMetadata correctly', () {
      final mutableSession = testSession;
      mutableSession.setMetadata('newKey', 'newValue');
      
      expect(mutableSession.getMetadata('newKey'), equals('newValue'));
      expect(mutableSession.hasMetadata('newKey'), isTrue);
    });

    test('should removeMetadata correctly', () {
      final mutableSession = testSession;
      mutableSession.removeMetadata('key');
      
      expect(mutableSession.hasMetadata('key'), isFalse);
    });

    test('should wasAccessedRecently correctly', () {
      final recentSession = testSession.copyWith(lastAccessAt: DateTime.now().subtract(const Duration(minutes: 30)));
      expect(recentSession.wasAccessedRecently(), isTrue);
      
      final oldSession = testSession.copyWith(lastAccessAt: DateTime.now().subtract(const Duration(hours: 2)));
      expect(oldSession.wasAccessedRecently(), isFalse);
    });

    test('should toJson correctly', () {
      final json = testSession.toJson();
      
      expect(json['id'], equals('test-session-id'));
      expect(json['userId'], equals('test-user-id'));
      expect(json['orgId'], equals('test-org-id'));
      expect(json['deviceId'], equals('test-device-id'));
      expect(json['token'], equals('test-token'));
      expect(json['isActive'], isTrue);
      expect(json['isExpired'], isFalse);
      expect(json['isRevoked'], isFalse);
    });

    test('should implement Equatable correctly', () {
      const session1 = SessionEntity(
        id: 'test-id',
        userId: 'user-id',
        orgId: 'org-id',
        deviceId: 'device-id',
        token: 'token',
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      const session2 = SessionEntity(
        id: 'test-id',
        userId: 'user-id',
        orgId: 'org-id',
        deviceId: 'device-id',
        token: 'token',
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      const session3 = SessionEntity(
        id: 'different-id',
        userId: 'user-id',
        orgId: 'org-id',
        deviceId: 'device-id',
        token: 'token',
        createdAt: createdAt,
        updatedAt: updatedAt,
      );

      expect(session1, equals(session2));
      expect(session1, isNot(equals(session3)));
    });

    test('should handle null values correctly', () {
      const sessionWithNulls = SessionEntity(
        id: 'test-id',
        userId: 'user-id',
        orgId: 'org-id',
        deviceId: 'device-id',
        token: 'token',
        createdAt: createdAt,
        updatedAt: updatedAt,
        refreshToken: null,
        location: null,
        userAgent: null,
        ipAddress: null,
        expiresAt: null,
        lastAccessAt: null,
        metadata: {},
      );

      expect(sessionWithNulls.hasRefreshToken, isFalse);
      expect(sessionWithNulls.hasLocation, isFalse);
      expect(sessionWithNulls.hasUserAgent, isFalse);
      expect(sessionWithNulls.hasIpAddress, isFalse);
      expect(sessionWithNulls.hasExpiresAt, isFalse);
      expect(sessionWithNulls.hasLastAccessAt, isFalse);
      expect(sessionWithNulls.hasMetadata, isFalse);
    });
  });
}
