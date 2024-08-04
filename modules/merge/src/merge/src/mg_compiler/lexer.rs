// Licensed under MIT Open Source License

use strcursor::StrCursor;

use super::error::LexerErr;

#[derive(Debug)]
pub struct Lexer<'a> {
    content: &'a str,
    cursor: StrCursor<'a>,
}

impl<'a> Lexer<'a> {
    pub fn new(content: &'a str) -> Self {
        Self {
            content,
            cursor: StrCursor::new_at_start(content),
        }
    }

    // pub fn lex(&self) -> Result<String, LexerErr> {}

    // fn skip_whitespace(&self) {
    //     self.cursor
    // }
}
