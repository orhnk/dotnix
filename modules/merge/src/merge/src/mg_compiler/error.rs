use thiserror::Error;

#[derive(Debug, Error)]
pub enum LexerErr {
    #[error("Unexpected Token: `{0}`")]
    UnexpectedToken(char),

    #[error("Unknown keyword: `{0}`")]
    UnknownKeyword(String),

    #[error("Unknown argument: `{0}`")]
    UnknownArgument(String),
}
