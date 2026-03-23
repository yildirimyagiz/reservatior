import 'package:flutter_test/flutter_test.dart';
import 'package:reservatour/features/auth/domain/entities/role_entity.dart';

void main() {
  group('RoleEntity', () {
    const createdAt = DateTime.parse('2023-01-01T00:00:00.000Z');
    const updatedAt = DateTime.parse('2023-01-01T01:00:00.000Z');

    const testRole = RoleEntity(
      id: 'test-role-id',
      orgId: 'test-org-id',
      name: 'Test Role',
      description: 'Test role description',
      type: RoleType.custom,
      level: RoleLevel.user,
      status: RoleStatus.active,
      permissions: ['read', 'write'],
      createdAt: createdAt,
      updatedAt: updatedAt,
    );

    test('should create RoleEntity with required properties', () {
      expect(testRole.id, equals('test-role-id'));
      expect(testRole.orgId, equals('test-org-id'));
      expect(testRole.name, equals('Test Role'));
      expect(testRole.type, equals(RoleType.custom));
      expect(testRole.level, equals(RoleLevel.user));
      expect(testRole.status, equals(RoleStatus.active));
    });

    test('should copyWith correctly update properties', () {
      final updatedRole = testRole.copyWith(
        name: 'Updated Role',
        status: RoleStatus.inactive,
      );

      expect(updatedRole.id, equals(testRole.id));
      expect(updatedRole.name, equals('Updated Role'));
      expect(updatedRole.status, equals(RoleStatus.inactive));
    });

    test('should return correct hasDescription', () {
      expect(testRole.hasDescription, isTrue);
      
      final roleWithoutDescription = testRole.copyWith(description: null);
      expect(roleWithoutDescription.hasDescription, isFalse);
    });

    test('should return correct hasPermissions', () {
      expect(testRole.hasPermissions, isTrue);
      
      final roleWithoutPermissions = testRole.copyWith(permissions: []);
      expect(roleWithoutPermissions.hasPermissions, isFalse);
    });

    test('should return correct hasParentRoleId', () {
      expect(testRole.hasParentRoleId, isFalse);
      
      final roleWithParent = testRole.copyWith(parentRoleId: 'parent-id');
      expect(roleWithParent.hasParentRoleId, isTrue);
    });

    test('should return correct isSystem', () {
      expect(testRole.isSystem, isFalse);
      
      final systemRole = testRole.copyWith(type: RoleType.system);
      expect(systemRole.isSystem, isTrue);
    });

    test('should return correct isCustom', () {
      expect(testRole.isCustom, isTrue);
      
      final systemRole = testRole.copyWith(type: RoleType.system);
      expect(systemRole.isCustom, isFalse);
    });

    test('should return correct isDefault', () {
      expect(testRole.isDefault, isFalse);
      
      final defaultRole = testRole.copyWith(isDefault: true);
      expect(defaultRole.isDefault, isTrue);
    });

    test('should return correct isActive', () {
      expect(testRole.isActive, isTrue);
      
      final inactiveRole = testRole.copyWith(status: RoleStatus.inactive);
      expect(inactiveRole.isActive, isFalse);
    });

    test('should return correct isInactive', () {
      expect(testRole.isInactive, isFalse);
      
      final inactiveRole = testRole.copyWith(status: RoleStatus.inactive);
      expect(inactiveRole.isInactive, isTrue);
    });

    test('should return correct isSuspended', () {
      expect(testRole.isSuspended, isFalse);
      
      final suspendedRole = testRole.copyWith(status: RoleStatus.suspended);
      expect(suspendedRole.isSuspended, isTrue);
    });

    test('should return correct isDeleted', () {
      expect(testRole.isDeleted, isFalse);
      
      final deletedRole = testRole.copyWith(deletedAt: DateTime.now());
      expect(deletedRole.isDeleted, isTrue);
    });

    test('should return correct isValid', () {
      expect(testRole.isValid, isTrue);
      
      final invalidRole = testRole.copyWith(status: RoleStatus.inactive);
      expect(invalidRole.isValid, isFalse);
    });

    test('should return correct isInvalid', () {
      expect(testRole.isInvalid, isFalse);
      
      final invalidRole = testRole.copyWith(status: RoleStatus.inactive);
      expect(invalidRole.isInvalid, isTrue);
    });

    test('should return correct isOperational', () {
      expect(testRole.isOperational, isTrue);
      
      final suspendedRole = testRole.copyWith(status: RoleStatus.suspended);
      expect(suspendedRole.isOperational, isFalse);
    });

    test('should return correct isDisabled', () {
      expect(testRole.isDisabled, isFalse);
      
      final suspendedRole = testRole.copyWith(status: RoleStatus.suspended);
      expect(suspendedRole.isDisabled, isTrue);
    });

    test('should return correct requiresAction', () {
      expect(testRole.requiresAction, isFalse);
      
      final suspendedRole = testRole.copyWith(status: RoleStatus.suspended);
      expect(suspendedRole.requiresAction, isTrue);
    });

    test('should return correct isFinal', () {
      expect(testRole.isFinal, isFalse);
      
      final deletedRole = testRole.copyWith(status: RoleStatus.deleted);
      expect(deletedRole.isFinal, isTrue);
    });

    test('should return correct isHighLevel', () {
      expect(testRole.isHighLevel, isFalse);
      
      final adminRole = testRole.copyWith(level: RoleLevel.admin);
      expect(adminRole.isHighLevel, isTrue);
    });

    test('should return correct isMidLevel', () {
      expect(testRole.isMidLevel, isTrue);
      
      final adminRole = testRole.copyWith(level: RoleLevel.admin);
      expect(adminRole.isMidLevel, isFalse);
    });

    test('should return correct isLowLevel', () {
      expect(testRole.isLowLevel, isFalse);
      
      final guestRole = testRole.copyWith(level: RoleLevel.guest);
      expect(guestRole.isLowLevel, isTrue);
    });

    test('should return correct canInherit', () {
      expect(testRole.canInherit, isTrue);
      
      final nonInheritableRole = testRole.copyWith(canInherit: false);
      expect(nonInheritableRole.canInherit, isFalse);
    });

    test('should return correct canDelegate', () {
      expect(testRole.canDelegate, isFalse);
      
      final delegableRole = testRole.copyWith(canDelegate: true);
      expect(delegableRole.canDelegate, isTrue);
    });

    test('should return correct timeSinceCreated', () {
      final timeSinceCreated = testRole.timeSinceCreated;
      expect(timeSinceCreated.inHours, greaterThan(0));
    });

    test('should return correct timeSinceCreatedDisplay', () {
      final display = testRole.timeSinceCreatedDisplay;
      expect(display, isA<String>());
      expect(display.isNotEmpty, isTrue);
    });

    test('should activate correctly', () {
      final mutableRole = testRole.copyWith(status: RoleStatus.inactive);
      mutableRole.activate();
      
      expect(mutableRole.status, equals(RoleStatus.active));
      expect(mutableRole.isActive, isTrue);
    });

    test('should deactivate correctly', () {
      final mutableRole = testRole;
      mutableRole.deactivate();
      
      expect(mutableRole.status, equals(RoleStatus.inactive));
      expect(mutableRole.isActive, isFalse);
    });

    test('should suspend correctly', () {
      final mutableRole = testRole;
      mutableRole.suspend();
      
      expect(mutableRole.status, equals(RoleStatus.suspended));
      expect(mutableRole.isSuspended, isTrue);
    });

    test('should addPermission correctly', () {
      final mutableRole = testRole;
      mutableRole.addPermission('admin');
      
      expect(mutableRole.hasPermission('admin'), isTrue);
      expect(mutableRole.permissions, contains('admin'));
    });

    test('should removePermission correctly', () {
      final mutableRole = testRole;
      mutableRole.removePermission('read');
      
      expect(mutableRole.hasPermission('read'), isFalse);
      expect(mutableRole.permissions, isNot(contains('read')));
    });

    test('should addTag correctly', () {
      final mutableRole = testRole;
      mutableRole.addTag('important');
      
      expect(mutableRole.hasTag('important'), isTrue);
      expect(mutableRole.tags, contains('important'));
    });

    test('should removeTag correctly', () {
      final mutableRole = testRole.copyWith(tags: ['test-tag']);
      mutableRole.removeTag('test-tag');
      
      expect(mutableRole.hasTag('test-tag'), isFalse);
      expect(mutableRole.tags, isNot(contains('test-tag')));
    });

    test('should setMetadata correctly', () {
      final mutableRole = testRole;
      mutableRole.setMetadata('key', 'value');
      
      expect(mutableRole.getMetadata('key'), equals('value'));
      expect(mutableRole.hasMetadata('key'), isTrue);
    });

    test('should removeMetadata correctly', () {
      final mutableRole = testRole.copyWith(metadata: {'key': 'value'});
      mutableRole.removeMetadata('key');
      
      expect(mutableRole.hasMetadata('key'), isFalse);
    });

    test('should wasCreatedRecently correctly', () {
      final recentRole = RoleEntity(
        id: 'recent-role',
        orgId: 'org-id',
        name: 'Recent Role',
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        updatedAt: DateTime.now(),
      );
      expect(recentRole.wasCreatedRecently(), isTrue);
      
      expect(testRole.wasCreatedRecently(), isFalse);
    });

    test('should toJson correctly', () {
      final json = testRole.toJson();
      
      expect(json['id'], equals('test-role-id'));
      expect(json['orgId'], equals('test-org-id'));
      expect(json['name'], equals('Test Role'));
      expect(json['type'], equals('custom'));
      expect(json['level'], equals('user'));
      expect(json['status'], equals('active'));
      expect(json['isActive'], isTrue);
      expect(json['isCustom'], isTrue);
    });

    test('should RoleTypeExtension work correctly', () {
      expect(RoleType.admin.displayName, equals('Admin'));
      expect(RoleType.user.displayName, equals('User'));
      expect(RoleType.guest.displayName, equals('Guest'));
      expect(RoleType.custom.displayName, equals('Özel'));
      expect(RoleType.system.displayName, equals('Sistem'));

      expect(RoleType.admin.isHighLevel, isTrue);
      expect(RoleType.user.isMidLevel, isTrue);
      expect(RoleType.guest.isLowLevel, isTrue);
      expect(RoleType.custom.isCustom, isTrue);
      expect(RoleType.system.isSystem, isTrue);
    });

    test('should RoleLevelExtension work correctly', () {
      expect(RoleLevel.superAdmin.displayName, equals('Super Admin'));
      expect(RoleLevel.admin.displayName, equals('Admin'));
      expect(RoleLevel.manager.displayName, equals('Yönetici'));
      expect(RoleLevel.user.displayName, equals('Kullanıcı'));
      expect(RoleLevel.guest.displayName, equals('Misafir'));

      expect(RoleLevel.superAdmin.level, equals(5));
      expect(RoleLevel.admin.level, equals(4));
      expect(RoleLevel.manager.level, equals(3));
      expect(RoleLevel.user.level, equals(2));
      expect(RoleLevel.guest.level, equals(1));
    });

    test('should RoleStatusExtension work correctly', () {
      expect(RoleStatus.active.displayName, equals('Aktif'));
      expect(RoleStatus.inactive.displayName, equals('Pasif'));
      expect(RoleStatus.suspended.displayName, equals('Askıda'));
      expect(RoleStatus.deleted.displayName, equals('Silindi'));

      expect(RoleStatus.active.isActive, isTrue);
      expect(RoleStatus.inactive.isInactive, isTrue);
      expect(RoleStatus.suspended.isSuspended, isTrue);
      expect(RoleStatus.deleted.isDeleted, isTrue);
    });

    test('should handle null values correctly', () {
      const roleWithNulls = RoleEntity(
        id: 'test-id',
        orgId: 'org-id',
        name: 'Test Role',
        type: RoleType.custom,
        level: RoleLevel.user,
        status: RoleStatus.active,
        permissions: [],
        createdAt: createdAt,
        updatedAt: updatedAt,
        description: null,
        parentRoleId: null,
        tags: [],
        metadata: {},
      );

      expect(roleWithNulls.hasDescription, isFalse);
      expect(roleWithNulls.hasPermissions, isFalse);
      expect(roleWithNulls.hasParentRoleId, isFalse);
      expect(roleWithNulls.hasTags, isFalse);
      expect(roleWithNulls.hasMetadata, isFalse);
    });
  });
}
