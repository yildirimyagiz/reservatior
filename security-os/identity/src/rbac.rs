use dashmap::DashMap;

use crate::errors::IdentityError;
use crate::models::{Permission, PermissionEffect, Role};

pub struct RbacEngine {
    roles: DashMap<String, Role>,
    user_roles: DashMap<String, Vec<String>>,
    #[allow(dead_code)]
    permissions_cache: DashMap<String, Vec<Permission>>,
}

impl RbacEngine {
    pub fn new() -> Self {
        Self {
            roles: DashMap::new(),
            user_roles: DashMap::new(),
            permissions_cache: DashMap::new(),
        }
    }

    pub fn create_role(&self, role: Role) -> Result<(), IdentityError> {
        if self.roles.contains_key(&role.name) {
            return Err(IdentityError::ProviderError(format!(
                "Role '{}' already exists",
                role.name
            )));
        }
        self.roles.insert(role.name.clone(), role);
        Ok(())
    }

    pub fn delete_role(&self, role_name: &str) -> bool {
        self.roles.remove(role_name).is_some()
    }

    pub fn assign_role(&self, user_id: &str, role_name: &str) -> Result<(), IdentityError> {
        if !self.roles.contains_key(role_name) {
            return Err(IdentityError::NotFound(format!(
                "Role '{}' not found",
                role_name
            )));
        }

        let mut roles = self.user_roles
            .entry(user_id.to_string())
            .or_insert_with(Vec::new);

        if roles.contains(&role_name.to_string()) {
            return Ok(());
        }

        roles.push(role_name.to_string());
        Ok(())
    }

    pub fn remove_role(&self, user_id: &str, role_name: &str) -> bool {
        if let Some(mut roles) = self.user_roles.get_mut(user_id) {
            let len_before = roles.len();
            roles.retain(|r| r != role_name);
            return roles.len() < len_before;
        }
        false
    }

    pub fn get_user_roles(&self, user_id: &str) -> Vec<String> {
        self.user_roles
            .get(user_id)
            .map(|roles| roles.clone())
            .unwrap_or_default()
    }

    pub fn get_role_permissions(&self, role_name: &str) -> Vec<Permission> {
        self.roles
            .get(role_name)
            .map(|role| role.permissions.clone())
            .unwrap_or_default()
    }

    pub fn get_user_permissions(&self, user_id: &str) -> Vec<Permission> {
        let user_roles = self.get_user_roles(user_id);
        let mut all_permissions = Vec::new();

        for role_name in &user_roles {
            let role_permissions = self.get_role_permissions(role_name);
            all_permissions.extend(role_permissions);
        }

        all_permissions
    }

    pub fn check_permission(&self, user_id: &str, resource: &str, action: &str) -> bool {
        let permissions = self.get_user_permissions(user_id);

        // Check for explicit deny first
        for perm in &permissions {
            if (perm.resource == "*" || perm.resource == resource)
                && (perm.action == "*" || perm.action == action)
                && perm.effect == PermissionEffect::Deny
            {
                return false;
            }
        }

        // Check for allow
        for perm in &permissions {
            if (perm.resource == "*" || perm.resource == resource)
                && (perm.action == "*" || perm.action == action)
                && perm.effect == PermissionEffect::Allow
            {
                return true;
            }
        }

        false
    }

    pub fn list_roles(&self) -> Vec<Role> {
        self.roles
            .iter()
            .map(|entry| entry.value().clone())
            .collect()
    }

    pub fn add_permission(&self, role_name: &str, permission: Permission) -> Result<(), IdentityError> {
        if let Some(mut role) = self.roles.get_mut(role_name) {
            role.permissions.push(permission);
            Ok(())
        } else {
            Err(IdentityError::NotFound(format!(
                "Role '{}' not found",
                role_name
            )))
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use chrono::Utc;

    fn create_test_role(name: &str) -> Role {
        Role {
            name: name.to_string(),
            description: format!("{} role description", name),
            permissions: vec![
                Permission {
                    resource: "users".to_string(),
                    action: "read".to_string(),
                    effect: PermissionEffect::Allow,
                },
            ],
            created_at: Utc::now(),
        }
    }

    #[test]
    fn test_create_role() {
        let engine = RbacEngine::new();
        let role = create_test_role("admin");

        assert!(engine.create_role(role).is_ok());
        assert_eq!(engine.list_roles().len(), 1);

        // Duplicate should fail
        let role2 = create_test_role("admin");
        assert!(engine.create_role(role2).is_err());
    }

    #[test]
    fn test_assign_and_remove_role() {
        let engine = RbacEngine::new();
        let role = create_test_role("admin");
        engine.create_role(role).unwrap();

        assert!(engine.assign_role("user-1", "admin").is_ok());
        assert_eq!(engine.get_user_roles("user-1").len(), 1);

        // Assigning same role again should be idempotent
        assert!(engine.assign_role("user-1", "admin").is_ok());
        assert_eq!(engine.get_user_roles("user-1").len(), 1);

        // Remove role
        assert!(engine.remove_role("user-1", "admin"));
        assert_eq!(engine.get_user_roles("user-1").len(), 0);

        // Remove non-existent role
        assert!(!engine.remove_role("user-1", "admin"));
    }

    #[test]
    fn test_check_permission() {
        let engine = RbacEngine::new();
        let role = Role {
            name: "reader".to_string(),
            description: "Reader role".to_string(),
            permissions: vec![
                Permission {
                    resource: "users".to_string(),
                    action: "read".to_string(),
                    effect: PermissionEffect::Allow,
                },
                Permission {
                    resource: "files".to_string(),
                    action: "*".to_string(),
                    effect: PermissionEffect::Allow,
                },
            ],
            created_at: Utc::now(),
        };

        engine.create_role(role).unwrap();
        engine.assign_role("user-1", "reader").unwrap();

        assert!(engine.check_permission("user-1", "users", "read"));
        assert!(engine.check_permission("user-1", "files", "delete"));
        assert!(!engine.check_permission("user-1", "users", "write"));
        assert!(!engine.check_permission("user-1", "unknown", "read"));
    }

    #[test]
    fn test_get_permissions() {
        let engine = RbacEngine::new();
        let role = create_test_role("admin");
        engine.create_role(role).unwrap();
        engine.assign_role("user-1", "admin").unwrap();

        let permissions = engine.get_user_permissions("user-1");
        assert_eq!(permissions.len(), 1);
        assert_eq!(permissions[0].resource, "users");
    }

    #[test]
    fn test_add_permission() {
        let engine = RbacEngine::new();
        let role = create_test_role("admin");
        engine.create_role(role).unwrap();

        let perm = Permission {
            resource: "settings".to_string(),
            action: "write".to_string(),
            effect: PermissionEffect::Allow,
        };

        assert!(engine.add_permission("admin", perm).is_ok());
        let permissions = engine.get_role_permissions("admin");
        assert_eq!(permissions.len(), 2);

        // Non-existent role
        let perm2 = Permission {
            resource: "settings".to_string(),
            action: "write".to_string(),
            effect: PermissionEffect::Allow,
        };
        assert!(engine.add_permission("nonexistent", perm2).is_err());
    }

    #[test]
    fn test_deny_takes_precedence() {
        let engine = RbacEngine::new();
        let role = Role {
            name: "mixed".to_string(),
            description: "Role with mixed permissions".to_string(),
            permissions: vec![
                Permission {
                    resource: "users".to_string(),
                    action: "read".to_string(),
                    effect: PermissionEffect::Allow,
                },
                Permission {
                    resource: "users".to_string(),
                    action: "read".to_string(),
                    effect: PermissionEffect::Deny,
                },
            ],
            created_at: Utc::now(),
        };

        engine.create_role(role).unwrap();
        engine.assign_role("user-1", "mixed").unwrap();

        // Deny should take precedence
        assert!(!engine.check_permission("user-1", "users", "read"));
    }
}
