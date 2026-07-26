use chrono::Utc;
use jsonwebtoken::{decode, encode, Algorithm, DecodingKey, EncodingKey, Header, Validation};
use serde::{Deserialize, Serialize};
use sha2::{Digest, Sha256};
use uuid::Uuid;

use crate::errors::IdentityError;
use crate::models::{AuthToken, TokenType, User};

#[derive(Debug, Clone, Serialize, Deserialize)]
pub struct TokenClaims {
    pub sub: String,
    pub username: String,
    pub roles: Vec<String>,
    pub iat: u64,
    pub exp: u64,
    pub iss: String,
    pub token_type: String,
}

pub struct JwtManager {
    secret: String,
    issuer: String,
    access_token_ttl_secs: u64,
    refresh_token_ttl_secs: u64,
}

impl JwtManager {
    pub fn new(secret: &str, issuer: &str) -> Self {
        Self {
            secret: secret.to_string(),
            issuer: issuer.to_string(),
            access_token_ttl_secs: 3600,
            refresh_token_ttl_secs: 86400 * 7,
        }
    }

    pub fn create_access_token(&self, user: &User) -> Result<String, IdentityError> {
        let now = Utc::now().timestamp() as u64;
        let exp = now + self.access_token_ttl_secs;

        let claims = TokenClaims {
            sub: user.id.clone(),
            username: user.username.clone(),
            roles: user.roles.clone(),
            iat: now,
            exp,
            iss: self.issuer.clone(),
            token_type: "access".to_string(),
        };

        encode(
            &Header::default(),
            &claims,
            &EncodingKey::from_secret(self.secret.as_bytes()),
        )
        .map_err(|e| IdentityError::TokenInvalid(e.to_string()))
    }

    pub fn create_refresh_token(&self, user: &User) -> Result<String, IdentityError> {
        let now = Utc::now().timestamp() as u64;
        let exp = now + self.refresh_token_ttl_secs;

        let claims = TokenClaims {
            sub: user.id.clone(),
            username: user.username.clone(),
            roles: user.roles.clone(),
            iat: now,
            exp,
            iss: self.issuer.clone(),
            token_type: "refresh".to_string(),
        };

        encode(
            &Header::default(),
            &claims,
            &EncodingKey::from_secret(self.secret.as_bytes()),
        )
        .map_err(|e| IdentityError::TokenInvalid(e.to_string()))
    }

    pub fn validate_token(&self, token: &str) -> Result<TokenClaims, IdentityError> {
        let token_data = decode::<TokenClaims>(
            token,
            &DecodingKey::from_secret(self.secret.as_bytes()),
            &Validation::new(Algorithm::HS256),
        )
        .map_err(|e| {
            if e.kind() == &jsonwebtoken::errors::ErrorKind::ExpiredSignature {
                IdentityError::TokenExpired
            } else {
                IdentityError::TokenInvalid(e.to_string())
            }
        })?;

        let now = Utc::now().timestamp() as u64;
        if token_data.claims.exp < now {
            return Err(IdentityError::TokenExpired);
        }

        if token_data.claims.iss != self.issuer {
            return Err(IdentityError::TokenInvalid("Invalid issuer".to_string()));
        }

        Ok(token_data.claims)
    }

    pub fn extract_claims(&self, token: &str) -> Result<TokenClaims, IdentityError> {
        let token_data = decode::<TokenClaims>(
            token,
            &DecodingKey::from_secret(self.secret.as_bytes()),
            &Validation::new(Algorithm::HS256),
        )
        .map_err(|e| IdentityError::TokenInvalid(e.to_string()))?;

        Ok(token_data.claims)
    }

    pub fn revoke_token(&self, token: &str) -> bool {
        // In a real implementation, this would add the token to a revocation list.
        // For now, we just verify the token is valid format and return true.
        self.extract_claims(token).is_ok()
    }

    pub fn create_auth_token(&self, user: &User, token_type: TokenType) -> Result<AuthToken, IdentityError> {
        let now = Utc::now();
        let ttl = match token_type {
            TokenType::AccessToken => self.access_token_ttl_secs,
            TokenType::RefreshToken => self.refresh_token_ttl_secs,
            TokenType::IdToken => self.access_token_ttl_secs,
        };

        Ok(AuthToken {
            token_id: Uuid::new_v4().to_string(),
            user_id: user.id.clone(),
            username: user.username.clone(),
            roles: user.roles.clone(),
            issued_at: now,
            expires_at: now + chrono::Duration::seconds(ttl as i64),
            provider: user.provider.clone(),
            token_type,
        })
    }
}

pub fn hash_password(password: &str) -> String {
    let mut hasher = Sha256::new();
    hasher.update(password.as_bytes());
    let result = hasher.finalize();
    hex::encode(result)
}

#[cfg(test)]
mod tests {
    use super::*;
    use std::collections::HashMap;

    fn create_test_user() -> User {
        User {
            id: "user-001".to_string(),
            username: "testuser".to_string(),
            email: "test@example.com".to_string(),
            display_name: "Test User".to_string(),
            roles: vec!["admin".to_string(), "user".to_string()],
            groups: vec!["admins".to_string()],
            provider: "local".to_string(),
            provider_id: None,
            created_at: Utc::now(),
            last_login: None,
            enabled: true,
            mfa_enabled: false,
            metadata: HashMap::new(),
        }
    }

    #[test]
    fn test_create_access_token() {
        let manager = JwtManager::new("test-secret", "test-issuer");
        let user = create_test_user();

        let token = manager.create_access_token(&user);
        assert!(token.is_ok());

        let token_str = token.unwrap();
        assert!(!token_str.is_empty());
    }

    #[test]
    fn test_create_refresh_token() {
        let manager = JwtManager::new("test-secret", "test-issuer");
        let user = create_test_user();

        let token = manager.create_refresh_token(&user);
        assert!(token.is_ok());

        let token_str = token.unwrap();
        assert!(!token_str.is_empty());

        // Refresh token should have different claims
        let claims = manager.extract_claims(&token_str).unwrap();
        assert_eq!(claims.token_type, "refresh");
    }

    #[test]
    fn test_validate_token() {
        let manager = JwtManager::new("test-secret", "test-issuer");
        let user = create_test_user();

        let token = manager.create_access_token(&user).unwrap();
        let claims = manager.validate_token(&token);

        assert!(claims.is_ok());
        let claims = claims.unwrap();
        assert_eq!(claims.sub, user.id);
        assert_eq!(claims.username, user.username);
        assert_eq!(claims.iss, "test-issuer");
        assert_eq!(claims.token_type, "access");
    }

    #[test]
    fn test_extract_claims() {
        let manager = JwtManager::new("test-secret", "test-issuer");
        let user = create_test_user();

        let token = manager.create_access_token(&user).unwrap();
        let claims = manager.extract_claims(&token);

        assert!(claims.is_ok());
        let claims = claims.unwrap();
        assert_eq!(claims.roles.len(), 2);
        assert!(claims.roles.contains(&"admin".to_string()));
        assert!(claims.roles.contains(&"user".to_string()));
    }

    #[test]
    fn test_revoke_token() {
        let manager = JwtManager::new("test-secret", "test-issuer");
        let user = create_test_user();

        let token = manager.create_access_token(&user).unwrap();
        let result = manager.revoke_token(&token);

        assert!(result);

        // Invalid token should return false
        let result = manager.revoke_token("invalid.token.here");
        assert!(!result);
    }

    #[test]
    fn test_invalid_token() {
        let manager = JwtManager::new("test-secret", "test-issuer");

        let result = manager.validate_token("invalid.token.here");
        assert!(result.is_err());
    }

    #[test]
    fn test_wrong_secret() {
        let manager1 = JwtManager::new("secret-1", "test-issuer");
        let manager2 = JwtManager::new("secret-2", "test-issuer");
        let user = create_test_user();

        let token = manager1.create_access_token(&user).unwrap();
        let result = manager2.validate_token(&token);
        assert!(result.is_err());
    }
}
