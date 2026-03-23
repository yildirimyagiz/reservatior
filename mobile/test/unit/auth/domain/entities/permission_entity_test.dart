import 'package:flutter_test/flutter_test.dart';
import 'package:reservatour/features/auth/domain/entities/permission_entity.dart';

void main() {
  group('PermissionEntity', () {
    const createdAt = DateTime.parse('2023-01-01T00:00:00.000Z');
    const updatedAt = DateTime.parse('2023-01-01T01:00:00.000Z');

    const testPermission = PermissionEntity(
      id: 'test-permission-id',
      orgId: 'test-org-id',
      key: 'test.permission',
      name: 'Test Permission',
      description: 'Test permission description',
      type: PermissionType.read,
      category: PermissionCategory.user,
      scope: PermissionScope.organization,
      level: PermissionLevel.basic,
      status: PermissionStatus.active,
      createdAt: createdAt,
      updatedAt: updatedAt,
    );

    test('should create PermissionEntity with required properties', () {
      expect(testPermission.id, equals('test-permission-id'));
      expect(testPermission.orgId, equals('test-org-id'));
      expect(testPermission.key, equals('test.permission'));
      expect(testPermission.name, equals('Test Permission'));
      expect(testPermission.type, equals(PermissionType.read));
      expect(testPermission.category, equals(PermissionCategory.user));
      expect(testPermission.scope, equals(PermissionScope.organization));
      expect(testPermission.level, equals(PermissionLevel.basic));
      expect(testPermission.status, equals(PermissionStatus.active));
    });

    test('should copyWith correctly update properties', () {
      final updatedPermission = testPermission.copyWith(
        name: 'Updated Permission',
        status: PermissionStatus.inactive,
      );

      expect(updatedPermission.id, equals(testPermission.id));
      expect(updatedPermission.name, equals('Updated Permission'));
      expect(updatedPermission.status, equals(PermissionStatus.inactive));
    });

    test('should return correct hasDescription', () {
      expect(testPermission.hasDescription, isTrue);
      
      final permissionWithoutDescription = testPermission.copyWith(description: null);
      expect(permissionWithoutDescription.hasDescription, isFalse);
    });

    test('should return correct hasAllowedRoles', () {
      expect(testPermission.hasAllowedRoles, isFalse);
      
      final permissionWithRoles = testPermission.copyWith(allowedRoles: ['admin', 'user']);
      expect(permissionWithRoles.hasAllowedRoles, isTrue);
    });

    test('should return correct hasDeniedRoles', () {
      expect(testPermission.hasDeniedRoles, isFalse);
      
      final permissionWithDeniedRoles = testPermission.copyWith(deniedRoles: ['guest']);
      expect(permissionWithDeniedRoles.hasDeniedRoles, isTrue);
    });

    test('should return correct hasRequiredPermissions', () {
      expect(testPermission.hasRequiredPermissions, isFalse);
      
      final permissionWithRequired = testPermission.copyWith(requiredPermissions: ['base.read']);
      expect(permissionWithRequired.hasRequiredPermissions, isTrue);
    });

    test('should return correct hasImpliedPermissions', () {
      expect(testPermission.hasImpliedPermissions, isFalse);
      
      final permissionWithImplied = testPermission.copyWith(impliedPermissions: ['test.read']);
      expect(permissionWithImplied.hasImpliedPermissions, isTrue);
    });

    test('should return correct hasMetadata', () {
      expect(testPermission.hasMetadata, isFalse);
      
      final permissionWithMetadata = testPermission.copyWith(metadata: {'key': 'value'});
      expect(permissionWithMetadata.hasMetadata, isTrue);
    });

    test('should return correct isSystem', () {
      expect(testPermission.isSystem, isFalse);
      
      final systemPermission = testPermission.copyWith(type: PermissionType.system);
      expect(systemPermission.isSystem, isTrue);
    });

    test('should return correct isCustom', () {
      expect(testPermission.isCustom, isFalse);
      
      final customPermission = testPermission.copyWith(type: PermissionType.custom);
      expect(customPermission.isCustom, isTrue);
    });

    test('should return correct isDefault', () {
      expect(testPermission.isDefault, isFalse);
      
      final defaultPermission = testPermission.copyWith(isDefault: true);
      expect(defaultPermission.isDefault, isTrue);
    });

    test('should return correct isActive', () {
      expect(testPermission.isActive, isTrue);
      
      final inactivePermission = testPermission.copyWith(status: PermissionStatus.inactive);
      expect(inactivePermission.isActive, isFalse);
    });

    test('should return correct isInactive', () {
      expect(testPermission.isInactive, isFalse);
      
      final inactivePermission = testPermission.copyWith(status: PermissionStatus.inactive);
      expect(inactivePermission.isInactive, isTrue);
    });

    test('should return correct isSuspended', () {
      expect(testPermission.isSuspended, isFalse);
      
      final suspendedPermission = testPermission.copyWith(status: PermissionStatus.suspended);
      expect(suspendedPermission.isSuspended, isTrue);
    });

    test('should return correct isDeleted', () {
      expect(testPermission.isDeleted, isFalse);
      
      final deletedPermission = testPermission.copyWith(deletedAt: DateTime.now());
      expect(deletedPermission.isDeleted, isTrue);
    });

    test('should return correct isValid', () {
      expect(testPermission.isValid, isTrue);
      
      final invalidPermission = testPermission.copyWith(status: PermissionStatus.inactive);
      expect(invalidPermission.isValid, isFalse);
    });

    test('should return correct isOperational', () {
      expect(testPermission.isOperational, isTrue);
      
      final suspendedPermission = testPermission.copyWith(status: PermissionStatus.suspended);
      expect(suspendedPermission.isOperational, isFalse);
    });

    test('should return correct isDisabled', () {
      expect(testPermission.isDisabled, isFalse);
      
      final suspendedPermission = testPermission.copyWith(status: PermissionStatus.suspended);
      expect(suspendedPermission.isDisabled, isTrue);
    });

    test('should return correct requiresAction', () {
      expect(testPermission.requiresAction, isFalse);
      
      final suspendedPermission = testPermission.copyWith(status: PermissionStatus.suspended);
      expect(suspendedPermission.requiresAction, isTrue);
    });

    test('should return correct isFinal', () {
      expect(testPermission.isFinal, isFalse);
      
      final deletedPermission = testPermission.copyWith(status: PermissionStatus.deleted);
      expect(deletedPermission.isFinal, isTrue);
    });

    test('should return correct isHighLevel', () {
      expect(testPermission.isHighLevel, isFalse);
      
      final adminPermission = testPermission.copyWith(level: PermissionLevel.admin);
      expect(adminPermission.isHighLevel, isTrue);
    });

    test('should return correct isMidLevel', () {
      expect(testPermission.isMidLevel, isTrue);
      
      final adminPermission = testPermission.copyWith(level: PermissionLevel.admin);
      expect(adminPermission.isMidLevel, isFalse);
    });

    test('should return correct isLowLevel', () {
      expect(testPermission.isLowLevel, isFalse);
      
      final basicPermission = testPermission.copyWith(level: PermissionLevel.basic);
      expect(basicPermission.isLowLevel, isTrue);
    });

    test('should return correct isGlobal', () {
      expect(testPermission.isGlobal, isFalse);
      
      final globalPermission = testPermission.copyWith(scope: PermissionScope.global);
      expect(globalPermission.isGlobal, isTrue);
    });

    test('should return correct isOrganizationLevel', () {
      expect(testPermission.isOrganizationLevel, isTrue);
      
      final globalPermission = testPermission.copyWith(scope: PermissionScope.global);
      expect(globalPermission.isOrganizationLevel, isFalse);
    });

    test('should return correct isDepartmentLevel', () {
      expect(testPermission.isDepartmentLevel, isFalse);
      
      final departmentPermission = testPermission.copyWith(scope: PermissionScope.department);
      expect(departmentPermission.isDepartmentLevel, isTrue);
    });

    test('should return correct isTeamLevel', () {
      expect(testPermission.isTeamLevel, isFalse);
      
      final teamPermission = testPermission.copyWith(scope: PermissionScope.team);
      expect(teamPermission.isTeamLevel, isTrue);
    });

    test('should return correct isProjectLevel', () {
      expect(testPermission.isProjectLevel, isFalse);
      
      final projectPermission = testPermission.copyWith(scope: PermissionScope.project);
      expect(projectPermission.isProjectLevel, isTrue);
    });

    test('should return correct isUserLevel', () {
      expect(testPermission.isUserLevel, isFalse);
      
      final userPermission = testPermission.copyWith(scope: PermissionScope.user);
      expect(userPermission.isUserLevel, isTrue);
    });

    test('should return correct isCustom', () {
      expect(testPermission.isCustom, isFalse);
      
      final customPermission = testPermission.copyWith(scope: PermissionScope.custom);
      expect(customPermission.isCustom, isTrue);
    });

    test('should return correct isBroadScope', () {
      expect(testPermission.isBroadScope, isTrue);
      
      final userPermission = testPermission.copyWith(scope: PermissionScope.user);
      expect(userPermission.isBroadScope, isFalse);
    });

    test('should return correct isNarrowScope', () {
      expect(testPermission.isNarrowScope, isFalse);
      
      final userPermission = testPermission.copyWith(scope: PermissionScope.user);
      expect(userPermission.isNarrowScope, isTrue);
    });

    test('should return correct isDataPermission', () {
      expect(testPermission.isDataPermission, isTrue);
      
      final systemPermission = testPermission.copyWith(category: PermissionCategory.system);
      expect(systemPermission.isDataPermission, isFalse);
    });

    test('should return correct isSystemPermission', () {
      expect(testPermission.isSystemPermission, isFalse);
      
      final systemPermission = testPermission.copyWith(category: PermissionCategory.system);
      expect(systemPermission.isSystemPermission, isTrue);
    });

    test('should return correct isSecurityPermission', () {
      expect(testPermission.isSecurityPermission, isFalse);
      
      final securityPermission = testPermission.copyWith(category: PermissionCategory.security);
      expect(securityPermission.isSecurityPermission, isTrue);
    });

    test('should return correct isBusinessPermission', () {
      expect(testPermission.isBusinessPermission, isFalse);
      
      final businessPermission = testPermission.copyWith(category: PermissionCategory.business);
      expect(businessPermission.isBusinessPermission, isTrue);
    });

    test('should return correct isOperationalPermission', () {
      expect(testPermission.isOperationalPermission, isFalse);
      
      final operationalPermission = testPermission.copyWith(category: PermissionCategory.operational);
      expect(operationalPermission.isOperationalPermission, isTrue);
    });

    test('should return correct isAdministrativePermission', () {
      expect(testPermission.isAdministrativePermission, isFalse);
      
      final adminPermission = testPermission.copyWith(category: PermissionCategory.administrative);
      expect(adminPermission.isAdministrativePermission, isTrue);
    });

    test('should return correct isCriticalPermission', () {
      expect(testPermission.isCriticalPermission, isFalse);
      
      final criticalPermission = testPermission.copyWith(level: PermissionLevel.critical);
      expect(criticalPermission.isCriticalPermission, isTrue);
    });

    test('should return correct isSensitivePermission', () {
      expect(testPermission.isSensitivePermission, isFalse);
      
      final sensitivePermission = testPermission.copyWith(level: PermissionLevel.sensitive);
      expect(sensitivePermission.isSensitivePermission, isTrue);
    });

    test('should return correct timeSinceCreated', () {
      final timeSinceCreated = testPermission.timeSinceCreated;
      expect(timeSinceCreated.inHours, greaterThan(0));
    });

    test('should return correct timeSinceCreatedDisplay', () {
      final display = testPermission.timeSinceCreatedDisplay;
      expect(display, isA<String>());
      expect(display.isNotEmpty, isTrue);
    });

    test('should activate correctly', () {
      final mutablePermission = testPermission.copyWith(status: PermissionStatus.inactive);
      mutablePermission.activate();
      
      expect(mutablePermission.status, equals(PermissionStatus.active));
      expect(mutablePermission.isActive, isTrue);
    });

    test('should deactivate correctly', () {
      final mutablePermission = testPermission;
      mutablePermission.deactivate();
      
      expect(mutablePermission.status, equals(PermissionStatus.inactive));
      expect(mutablePermission.isActive, isFalse);
    });

    test('should suspend correctly', () {
      final mutablePermission = testPermission;
      mutablePermission.suspend();
      
      expect(mutablePermission.status, equals(PermissionStatus.suspended));
      expect(mutablePermission.isSuspended, isTrue);
    });

    test('should addAllowedRole correctly', () {
      final mutablePermission = testPermission;
      mutablePermission.addAllowedRole('admin');
      
      expect(mutablePermission.hasAllowedRole('admin'), isTrue);
      expect(mutablePermission.allowedRoles, contains('admin'));
    });

    test('should removeAllowedRole correctly', () {
      final mutablePermission = testPermission.copyWith(allowedRoles: ['admin']);
      mutablePermission.removeAllowedRole('admin');
      
      expect(mutablePermission.hasAllowedRole('admin'), isFalse);
      expect(mutablePermission.allowedRoles, isNot(contains('admin')));
    });

    test('should addDeniedRole correctly', () {
      final mutablePermission = testPermission;
      mutablePermission.addDeniedRole('guest');
      
      expect(mutablePermission.hasDeniedRole('guest'), isTrue);
      expect(mutablePermission.deniedRoles, contains('guest'));
    });

    test('should removeDeniedRole correctly', () {
      final mutablePermission = testPermission.copyWith(deniedRoles: ['guest']);
      mutablePermission.removeDeniedRole('guest');
      
      expect(mutablePermission.hasDeniedRole('guest'), isFalse);
      expect(mutablePermission.deniedRoles, isNot(contains('guest')));
    });

    test('should addRequiredPermission correctly', () {
      final mutablePermission = testPermission;
      mutablePermission.addRequiredPermission('base.read');
      
      expect(mutablePermission.hasRequiredPermission('base.read'), isTrue);
      expect(mutablePermission.requiredPermissions, contains('base.read'));
    });

    test('should removeRequiredPermission correctly', () {
      final mutablePermission = testPermission.copyWith(requiredPermissions: ['base.read']);
      mutablePermission.removeRequiredPermission('base.read');
      
      expect(mutablePermission.hasRequiredPermission('base.read'), isFalse);
      expect(mutablePermission.requiredPermissions, isNot(contains('base.read')));
    });

    test('should addImpliedPermission correctly', () {
      final mutablePermission = testPermission;
      mutablePermission.addImpliedPermission('test.read');
      
      expect(mutablePermission.hasImpliedPermission('test.read'), isTrue);
      expect(mutablePermission.impliedPermissions, contains('test.read'));
    });

    test('should removeImpliedPermission correctly', () {
      final mutablePermission = testPermission.copyWith(impliedPermissions: ['test.read']);
      mutablePermission.removeImpliedPermission('test.read');
      
      expect(mutablePermission.hasImpliedPermission('test.read'), isFalse);
      expect(mutablePermission.impliedPermissions, isNot(contains('test.read')));
    });

    test('should addTag correctly', () {
      final mutablePermission = testPermission;
      mutablePermission.addTag('important');
      
      expect(mutablePermission.hasTag('important'), isTrue);
      expect(mutablePermission.tags, contains('important'));
    });

    test('should removeTag correctly', () {
      final mutablePermission = testPermission.copyWith(tags: ['test-tag']);
      mutablePermission.removeTag('test-tag');
      
      expect(mutablePermission.hasTag('test-tag'), isFalse);
      expect(mutablePermission.tags, isNot(contains('test-tag')));
    });

    test('should setMetadata correctly', () {
      final mutablePermission = testPermission;
      mutablePermission.setMetadata('key', 'value');
      
      expect(mutablePermission.getMetadata('key'), equals('value'));
      expect(mutablePermission.hasMetadata('key'), isTrue);
    });

    test('should removeMetadata correctly', () {
      final mutablePermission = testPermission.copyWith(metadata: {'key': 'value'});
      mutablePermission.removeMetadata('key');
      
      expect(mutablePermission.hasMetadata('key'), isFalse);
    });

    test('should wasCreatedRecently correctly', () {
      final recentPermission = PermissionEntity(
        id: 'recent-permission',
        orgId: 'org-id',
        key: 'recent.permission',
        name: 'Recent Permission',
        type: PermissionType.read,
        category: PermissionCategory.user,
        scope: PermissionScope.organization,
        level: PermissionLevel.basic,
        status: PermissionStatus.active,
        createdAt: DateTime.now().subtract(const Duration(minutes: 30)),
        updatedAt: DateTime.now(),
      );
      expect(recentPermission.wasCreatedRecently(), isTrue);
      
      expect(testPermission.wasCreatedRecently(), isFalse);
    });

    test('should toJson correctly', () {
      final json = testPermission.toJson();
      
      expect(json['id'], equals('test-permission-id'));
      expect(json['orgId'], equals('test-org-id'));
      expect(json['key'], equals('test.permission'));
      expect(json['name'], equals('Test Permission'));
      expect(json['type'], equals('read'));
      expect(json['category'], equals('user'));
      expect(json['scope'], equals('organization'));
      expect(json['level'], equals('basic'));
      expect(json['status'], equals('active'));
      expect(json['isActive'], isTrue);
    });

    test('should handle null values correctly', () {
      const permissionWithNulls = PermissionEntity(
        id: 'test-id',
        orgId: 'org-id',
        key: 'test.permission',
        name: 'Test Permission',
        type: PermissionType.read,
        category: PermissionCategory.user,
        scope: PermissionScope.organization,
        level: PermissionLevel.basic,
        status: PermissionStatus.active,
        createdAt: createdAt,
        updatedAt: updatedAt,
        description: null,
        allowedRoles: [],
        deniedRoles: [],
        requiredPermissions: [],
        impliedPermissions: [],
        tags: [],
        metadata: {},
      );

      expect(permissionWithNulls.hasDescription, isFalse);
      expect(permissionWithNulls.hasAllowedRoles, isFalse);
      expect(permissionWithNulls.hasDeniedRoles, isFalse);
      expect(permissionWithNulls.hasRequiredPermissions, isFalse);
      expect(permissionWithNulls.hasImpliedPermissions, isFalse);
      expect(permissionWithNulls.hasTags, isFalse);
      expect(permissionWithNulls.hasMetadata, isFalse);
    });
  });
}
