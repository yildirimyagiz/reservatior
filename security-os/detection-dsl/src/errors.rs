use std::path::PathBuf;

#[derive(Debug, thiserror::Error)]
pub enum DslError {
    #[error("Parse error at position {position}: {message}")]
    ParseError { position: usize, message: String },

    #[error("Compile error: {0}")]
    CompileError(String),

    #[error("Execution error: {0}")]
    ExecutionError(String),

    #[error("I/O error: {0}")]
    IoError(#[from] std::io::Error),

    #[error("Hot reload error for {path}: {message}")]
    HotReload { path: PathBuf, message: String },

    #[error("Regex compilation error: {0}")]
    RegexError(String),
}
