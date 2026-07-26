use async_trait::async_trait;
use dashmap::DashMap;

use crate::errors::IdentityError;
use crate::jwt::{hash_password, JwtManager};
use crate::models::{AuthToken, AuthResult, TokenType, User};

#[async_trait]
pub trait AuthProvider: Send + Sync {
    fn name(&self) -> &str;
    fn provider_type(&self) -> ProviderType;
    async fn authenticate(&self, credentials: &AuthCredentials) -> Result<AuthResult, IdentityError>;
    async fn validate_token(&self, token: &str) -> Result<User, IdentityError>;
    async fn refresh_token(&self, refresh_token: &str) -> Result<AuthToken, IdentityError>;
    async fn revoke_token(&self, token: &str) -> Result<(), IdentityError>;
    async fn health_check(&self) -> bool;
}

#[derive(Debug, Clone, PartialEq, Eq)]
pub enum ProviderType {
    Oidc,
    Ldap,
    Saml,
    OAuth2,
    Local,
}

#[derive(Debug, Clone)]
pub enum AuthCredentials {
    UsernamePassword { username: String, password: String },
    ApiKey(String),
    Token(String),
}

// ── OIDC Provider ─────────────────────────────────────────────────────────────
pub struct OidcProvider {
    name: String,
    #[allow(dead_code)]
    issuer: String,
    #[allow(dead_code)]
    client_id: String,
    #[allow(dead_code)]
    client_secret: String,
    #[allow(dead_code)]
    jwks_uri: String,
    #[allow(dead_code)]
    redirect_url: String,
    users: DashMap<String, User>,
}

impl OidcProvider {
    pub fn new(name: &str, issuer: &str, client_id: &str, client_secret: &str) -> Self {
        Self {
            name: name.to_string(),
            issuer: issuer.to_string(),
            client_id: client_id.to_string(),
            client_secret: client_secret.to_string(),
            jwks_uri: format!("{}/.well-known/jwks.json", issuer),
            redirect_url: String::new(),
            users: DashMap::new(),
        }
    }

    pub fn add_user(&self, user: User) {
        self.users.insert(user.username.clone(), user);
    }
}

#[async_trait]
impl AuthProvider for OidcProvider {
    fn name(&self) -> &str {
        &self.name
    }

    fn provider_type(&self) -> ProviderType {
        ProviderType::Oidc
    }

    async fn authenticate(&self, credentials: &AuthCredentials) -> Result<AuthResult, IdentityError> {
        match credentials {
            AuthCredentials::UsernamePassword { username, .. } => {
                if let Some(user) = self.users.get(username) {
                    if user.enabled {
                        Ok(AuthResult {
                            success: true,
                            user: Some(user.clone()),
                            token: None,
                            error: None,
                            mfa_required: false,
                        })
                    } else {
                        Ok(AuthResult {
                            success: false,
                            user: None,
                            token: None,
                            error: Some("User is disabled".to_string()),
                            mfa_required: false,
                        })
                    }
                } else {
                    Ok(AuthResult {
                        success: false,
                        user: None,
                        token: None,
                        error: Some("User not found".to_string()),
                        mfa_required: false,
                    })
                }
            }
            _ => Ok(AuthResult {
                success: false,
                user: None,
                token: None,
                error: Some("Unsupported credential type for OIDC".to_string()),
                mfa_required: false,
            }),
        }
    }

    async fn validate_token(&self, token: &str) -> Result<User, IdentityError> {
        // In a real implementation, this would verify the JWT against the JWKS endpoint.
        // For simulation, we check if the token matches a user in our store.
        for entry in self.users.iter() {
            if entry.value().id == token || entry.value().username == token {
                return Ok(entry.value().clone());
            }
        }
        Err(IdentityError::TokenInvalid("Token not recognized".to_string()))
    }

    async fn refresh_token(&self, _refresh_token: &str) -> Result<AuthToken, IdentityError> {
        Err(IdentityError::ProviderError("OIDC refresh not implemented in simulation".to_string()))
    }

    async fn revoke_token(&self, _token: &str) -> Result<(), IdentityError> {
        Ok(())
    }

    async fn health_check(&self) -> bool {
        true
    }
}

// ── LDAP Provider ─────────────────────────────────────────────────────────────
pub struct LdapProvider {
    name: String,
    #[allow(dead_code)]
    url: String,
    #[allow(dead_code)]
    base_dn: String,
    #[allow(dead_code)]
    bind_dn: String,
    #[allow(dead_code)]
    bind_password: String,
    users: DashMap<String, User>,
}

impl LdapProvider {
    pub fn new(name: &str, url: &str, base_dn: &str, bind_dn: &str, bind_password: &str) -> Self {
        Self {
            name: name.to_string(),
            url: url.to_string(),
            base_dn: base_dn.to_string(),
            bind_dn: bind_dn.to_string(),
            bind_password: bind_password.to_string(),
            users: DashMap::new(),
        }
    }

    pub fn add_user(&self, user: User) {
        self.users.insert(user.username.clone(), user);
    }
}

#[async_trait]
impl AuthProvider for LdapProvider {
    fn name(&self) -> &str {
        &self.name
    }

    fn provider_type(&self) -> ProviderType {
        ProviderType::Ldap
    }

    async fn authenticate(&self, credentials: &AuthCredentials) -> Result<AuthResult, IdentityError> {
        match credentials {
            AuthCredentials::UsernamePassword { username, .. } => {
                if let Some(user) = self.users.get(username) {
                    if user.enabled {
                        Ok(AuthResult {
                            success: true,
                            user: Some(user.clone()),
                            token: None,
                            error: None,
                            mfa_required: false,
                        })
                    } else {
                        Ok(AuthResult {
                            success: false,
                            user: None,
                            token: None,
                            error: Some("User is disabled".to_string()),
                            mfa_required: false,
                        })
                    }
                } else {
                    Ok(AuthResult {
                        success: false,
                        user: None,
                        token: None,
                        error: Some("User not found in LDAP".to_string()),
                        mfa_required: false,
                    })
                }
            }
            _ => Ok(AuthResult {
                success: false,
                user: None,
                token: None,
                error: Some("Unsupported credential type for LDAP".to_string()),
                mfa_required: false,
            }),
        }
    }

    async fn validate_token(&self, token: &str) -> Result<User, IdentityError> {
        for entry in self.users.iter() {
            if entry.value().id == token || entry.value().username == token {
                return Ok(entry.value().clone());
            }
        }
        Err(IdentityError::TokenInvalid("Token not recognized".to_string()))
    }

    async fn refresh_token(&self, _refresh_token: &str) -> Result<AuthToken, IdentityError> {
        Err(IdentityError::ProviderError("LDAP refresh not implemented in simulation".to_string()))
    }

    async fn revoke_token(&self, _token: &str) -> Result<(), IdentityError> {
        Ok(())
    }

    async fn health_check(&self) -> bool {
        true
    }
}

// ── Local Provider ────────────────────────────────────────────────────────────
pub struct LocalProvider {
    name: String,
    users: DashMap<String, User>,
    passwords: DashMap<String, String>,
    jwt_manager: JwtManager,
}

impl LocalProvider {
    pub fn new(name: &str) -> Self {
        Self {
            name: name.to_string(),
            users: DashMap::new(),
            passwords: DashMap::new(),
            jwt_manager: JwtManager::new("local-secret-key", "local-provider"),
        }
    }

    pub fn create_user(&self, user: User, password: &str) -> Result<(), IdentityError> {
        if self.users.contains_key(&user.username) {
            return Err(IdentityError::ProviderError(format!(
                "User '{}' already exists",
                user.username
            )));
        }

        let hashed = hash_password(password);
        self.passwords.insert(user.username.clone(), hashed);
        self.users.insert(user.username.clone(), user);
        Ok(())
    }

    #[allow(dead_code)]
    fn get_jwt_manager(&self) -> &JwtManager {
        &self.jwt_manager
    }
}

#[async_trait]
impl AuthProvider for LocalProvider {
    fn name(&self) -> &str {
        &self.name
    }

    fn provider_type(&self) -> ProviderType {
        ProviderType::Local
    }

    async fn authenticate(&self, credentials: &AuthCredentials) -> Result<AuthResult, IdentityError> {
        match credentials {
            AuthCredentials::UsernamePassword { username, password } => {
                let user = self.users.get(username)
                    .ok_or_else(|| IdentityError::AuthenticationFailed(
                        format!("User '{}' not found", username)
                    ))?;

                if !user.enabled {
                    return Ok(AuthResult {
                        success: false,
                        user: None,
                        token: None,
                        error: Some("User is disabled".to_string()),
                        mfa_required: false,
                    });
                }

                let stored_hash = self.passwords.get(username)
                    .ok_or_else(|| IdentityError::AuthenticationFailed(
                        "Password hash not found".to_string()
                    ))?;

                let input_hash = hash_password(password);
                if *stored_hash != input_hash {
                    return Ok(AuthResult {
                        success: false,
                        user: None,
                        token: None,
                        error: Some("Invalid password".to_string()),
                        mfa_required: false,
                    });
                }

                let token = self.jwt_manager.create_auth_token(&user, TokenType::AccessToken)?;
                let user_clone = user.clone();

                Ok(AuthResult {
                    success: true,
                    user: Some(user_clone),
                    token: Some(token),
                    error: None,
                    mfa_required: false,
                })
            }
            _ => Ok(AuthResult {
                success: false,
                user: None,
                token: None,
                error: Some("Unsupported credential type for local provider".to_string()),
                mfa_required: false,
            }),
        }
    }

    async fn validate_token(&self, token: &str) -> Result<User, IdentityError> {
        let claims = self.jwt_manager.validate_token(token)?;

        self.users.get(&claims.username)
            .map(|user| user.clone())
            .ok_or_else(|| IdentityError::TokenInvalid("User not found".to_string()))
    }

    async fn refresh_token(&self, refresh_token: &str) -> Result<AuthToken, IdentityError> {
        let claims = self.jwt_manager.validate_token(refresh_token)?;

        if claims.token_type != "refresh" {
            return Err(IdentityError::TokenInvalid("Not a refresh token".to_string()));
        }

        let user = self.users.get(&claims.username)
            .ok_or_else(|| IdentityError::TokenInvalid("User not found".to_string()))?;

        self.jwt_manager.create_auth_token(&user, TokenType::AccessToken)
    }

    async fn revoke_token(&self, token: &str) -> Result<(), IdentityError> {
        self.jwt_manager.revoke_token(token);
        Ok(())
    }

    async fn health_check(&self) -> bool {
        true
    }
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::collections::HashMap;
    use uuid::Uuid;

    fn create_test_user(username: &str) -> User {
        User {
            id: Uuid::new_v4().to_string(),
            username: username.to_string(),
            email: format!("{}@example.com", username),
            display_name: username.to_string(),
            roles: vec!["user".to_string()],
            groups: vec!["users".to_string()],
            provider: "local".to_string(),
            provider_id: None,
            created_at: chrono::Utc::now(),
            last_login: None,
            enabled: true,
            mfa_enabled: false,
            metadata: HashMap::new(),
        }
    }

    #[tokio::test]
    async fn test_local_provider_create_user() {
        let provider = LocalProvider::new("test-local");
        let user = create_test_user("alice");

        assert!(provider.create_user(user, "password123").is_ok());
        assert!(provider.users.contains_key("alice"));
    }

    #[tokio::test]
    async fn test_local_provider_authenticate() {
        let provider = LocalProvider::new("test-local");
        let user = create_test_user("bob");
        provider.create_user(user, "secret").unwrap();

        let creds = AuthCredentials::UsernamePassword {
            username: "bob".to_string(),
            password: "secret".to_string(),
        };

        let result = provider.authenticate(&creds).await.unwrap();
        assert!(result.success);
        assert!(result.user.is_some());
        assert!(result.token.is_some());
        assert_eq!(result.user.unwrap().username, "bob");

        // Wrong password
        let creds_wrong = AuthCredentials::UsernamePassword {
            username: "bob".to_string(),
            password: "wrong".to_string(),
        };

        let result = provider.authenticate(&creds_wrong).await.unwrap();
        assert!(!result.success);
        assert!(result.error.is_some());
    }

    #[tokio::test]
    async fn test_local_provider_validate_token() {
        let provider = LocalProvider::new("test-local");
        let user = create_test_user("charlie");
        provider.create_user(user, "pass123").unwrap();

        let creds = AuthCredentials::UsernamePassword {
            username: "charlie".to_string(),
            password: "pass123".to_string(),
        };

        let auth_result = provider.authenticate(&creds).await.unwrap();
        let token = auth_result.token.unwrap();

        // Validate the JWT token
        let validated_user = provider.validate_token(&token.token_id).await;
        assert!(validated_user.is_err()); // token_id is not the JWT string

        // Create a real JWT and validate
        let jwt = provider.jwt_manager.create_access_token(
            provider.users.get("charlie").unwrap().value()
        ).unwrap();
        let validated_user = provider.validate_token(&jwt).await;
        assert!(validated_user.is_ok());
        assert_eq!(validated_user.unwrap().username, "charlie");
    }

    #[tokio::test]
    async fn test_local_provider_health_check() {
        let provider = LocalProvider::new("test-local");
        assert!(provider.health_check().await);
    }

    #[tokio::test]
    async fn test_oidc_provider_construction() {
        let provider = OidcProvider::new(
            "test-oidc",
            "https://issuer.example.com",
            "client-id",
            "client-secret",
        );

        assert_eq!(provider.name(), "test-oidc");
        assert_eq!(provider.provider_type(), ProviderType::Oidc);
        assert!(provider.health_check().await);
    }

    #[tokio::test]
    async fn test_oidc_provider_health_check() {
        let provider = OidcProvider::new(
            "test-oidc",
            "https://issuer.example.com",
            "client-id",
            "client-secret",
        );

        assert!(provider.health_check().await);
    }

    #[tokio::test]
    async fn test_ldap_provider_construction() {
        let provider = LdapProvider::new(
            "test-ldap",
            "ldap://localhost:389",
            "dc=example,dc=com",
            "cn=admin,dc=example,dc=com",
            "admin-password",
        );

        assert_eq!(provider.name(), "test-ldap");
        assert_eq!(provider.provider_type(), ProviderType::Ldap);
        assert!(provider.health_check().await);
    }

    #[tokio::test]
    async fn test_ldap_provider_health_check() {
        let provider = LdapProvider::new(
            "test-ldap",
            "ldap://localhost:389",
            "dc=example,dc=com",
            "cn=admin,dc=example,dc=com",
            "admin-password",
        );

        assert!(provider.health_check().await);
    }
}
