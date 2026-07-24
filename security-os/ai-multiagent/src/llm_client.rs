use async_trait::async_trait;
use serde::{Deserialize, Serialize};
use std::sync::atomic::{AtomicUsize, Ordering};

use crate::errors::AiAgentError;

#[async_trait]
pub trait LlmClient: Send + Sync {
    async fn complete(&self, prompt: &str, context: Option<&str>) -> Result<String, AiAgentError>;
    fn model_name(&self) -> &str;
    fn max_tokens(&self) -> u32;
}

#[derive(Debug, Serialize)]
struct ChatMessage {
    role: String,
    content: String,
}

#[derive(Debug, Serialize)]
struct ChatCompletionRequest {
    model: String,
    messages: Vec<ChatMessage>,
    temperature: f64,
    max_tokens: u32,
}

#[derive(Debug, Deserialize)]
struct ChatCompletionResponse {
    choices: Vec<ChatChoice>,
}

#[derive(Debug, Deserialize)]
struct ChatChoice {
    message: ChatChoiceMessage,
}

#[derive(Debug, Deserialize)]
struct ChatChoiceMessage {
    content: String,
}

pub struct OpenAiClient {
    api_key: String,
    model: String,
    client: reqwest::Client,
}

impl OpenAiClient {
    pub fn new(api_key: String, model: Option<String>) -> Self {
        let client = reqwest::Client::builder()
            .timeout(std::time::Duration::from_secs(120))
            .build()
            .expect("failed to build HTTP client");

        Self {
            api_key,
            model: model.unwrap_or_else(|| "gpt-4".to_string()),
            client,
        }
    }
}

#[async_trait]
impl LlmClient for OpenAiClient {
    async fn complete(&self, prompt: &str, context: Option<&str>) -> Result<String, AiAgentError> {
        let mut messages = Vec::new();

        if let Some(ctx) = context {
            messages.push(ChatMessage {
                role: "system".to_string(),
                content: ctx.to_string(),
            });
        }

        messages.push(ChatMessage {
            role: "user".to_string(),
            content: prompt.to_string(),
        });

        let request = ChatCompletionRequest {
            model: self.model.clone(),
            messages,
            temperature: 0.3,
            max_tokens: 4096,
        };

        let response = self
            .client
            .post("https://api.openai.com/v1/chat/completions")
            .header("Authorization", format!("Bearer {}", self.api_key))
            .json(&request)
            .send()
            .await
            .map_err(|e| AiAgentError::LlmError(format!("Request failed: {}", e)))?;

        if !response.status().is_success() {
            let status = response.status();
            let body = response.text().await.unwrap_or_default();
            return Err(AiAgentError::LlmError(format!(
                "API returned {}: {}",
                status, body
            )));
        }

        let llm_response: ChatCompletionResponse = response
            .json()
            .await
            .map_err(|e| AiAgentError::LlmError(format!("Parse failed: {}", e)))?;

        llm_response
            .choices
            .first()
            .map(|c| c.message.content.clone())
            .ok_or_else(|| AiAgentError::LlmError("No choices in response".to_string()))
    }

    fn model_name(&self) -> &str {
        &self.model
    }

    fn max_tokens(&self) -> u32 {
        4096
    }
}

pub struct MockLlmClient {
    pub responses: Vec<String>,
    pub call_count: AtomicUsize,
}

impl MockLlmClient {
    pub fn new(responses: Vec<String>) -> Self {
        Self {
            responses,
            call_count: AtomicUsize::new(0),
        }
    }
}

#[async_trait]
impl LlmClient for MockLlmClient {
    async fn complete(&self, _prompt: &str, _context: Option<&str>) -> Result<String, AiAgentError> {
        let idx = self.call_count.fetch_add(1, Ordering::Relaxed);
        Ok(self
            .responses
            .get(idx % self.responses.len())
            .cloned()
            .unwrap_or_default())
    }

    fn model_name(&self) -> &str {
        "mock-model"
    }

    fn max_tokens(&self) -> u32 {
        1024
    }
}
