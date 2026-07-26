use chrono::{DateTime, Utc};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct User {
    pub id: String,
    pub username: String,
    pub email: String,
    pub display_name: String,
    pub roles: Vec<String>,
    pub groups: Vec<String>,
    pub provider: String,
    pub provider_id: Option<String>,
    pub created_at: DateTime<Utc>,
    pub last_login: Option<DateTime<Utc>>,
    pub enabled: bool,
    pub mfa_enabled: bool,
    pub metadata: HashMap<String, serde_json::Value>,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct AuthToken {
    pub token_id: String,
    pub user_id: String,
    pub username: String,
    pub roles: Vec<String>,
    pub issued_at: DateTime<Utc>,
    pub expires_at: DateTime<Utc>,
    pub provider: String,
    pub token_type: TokenType,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub enum TokenType {
    AccessToken,
    RefreshToken,
    IdToken,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Permission {
    pub resource: String,
    pub action: String,
    pub effect: PermissionEffect,
}

#[derive(Debug, Clone, Serialize, Deserialize, PartialEq, Eq)]
pub enum PermissionEffect {
    Allow,
    Deny,
}

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct Role {
    pub name: String,
    pub description: String,
    pub permissions: Vec<Permission>,
    pub created_at: DateTime<Utc>,
}

#[derive(Debug, Clone)]
pub struct AuthResult {
    pub success: bool,
    pub user: Option<User>,
    pub token: Option<AuthToken>,
    pub error: Option<String>,
    pub mfa_required: bool,
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn test_user_creation() {
        let user = User {
            id: "user-001".to_string(),
            username: "admin".to_string(),
            email: "admin@example.com".to_string(),
            display_name: "Administrator".to_string(),
            roles: vec!["admin".to_string()],
            groups: vec!["admins".to_string()],
            provider: "local".to_string(),
            provider_id: None,
            created_at: Utc::now(),
            last_login: None,
            enabled: true,
            mfa_enabled: false,
            metadata: HashMap::new(),
        };

        assert_eq!(user.id, "user-001");
        assert_eq!(user.username, "admin");
        assert!(user.enabled);
        assert!(!user.mfa_enabled);
        assert_eq!(user.roles.len(), 1);
        assert_eq!(user.roles[0], "admin");
    }

    #[test]
    fn test_auth_token() {
        let now = Utc::now();
        let token = AuthToken {
            token_id: "tok-001".to_string(),
            user_id: "user-001".to_string(),
            username: "admin".to_string(),
            roles: vec!["admin".to_string()],
            issued_at: now,
            expires_at: now + chrono::Duration::hours(1),
            provider: "local".to_string(),
            token_type: TokenType::AccessToken,
        };

        assert_eq!(token.token_id, "tok-001");
        assert_eq!(token.token_type, TokenType::AccessToken);
        assert!(token.expires_at > token.issued_at);
    }

    #[test]
    fn test_permission() {
        let perm = Permission {
            resource: "users".to_string(),
            action: "read".to_string(),
            effect: PermissionEffect::Allow,
        };

        assert_eq!(perm.resource, "users");
        assert_eq!(perm.action, "read");
        assert_eq!(perm.effect, PermissionEffect::Allow);

        let deny_perm = Permission {
            resource: "users".to_string(),
            action: "delete".to_string(),
            effect: PermissionEffect::Deny,
        };

        assert_eq!(deny_perm.effect, PermissionEffect::Deny);
    }
}
