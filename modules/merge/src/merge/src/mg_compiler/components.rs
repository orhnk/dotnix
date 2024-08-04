/// Merge MIR Keywords
pub mod keywords {
    const PLUGIN_LIST: &str = r#"<plugin_list>"#;
    // const : &str = r#""#;
}

/// Merge MIR Options
pub mod opts {
    const INSTALL: &str = r#"install"#;
    const UPDATE: &str = r#"update"#;
    const SEARCH: &str = r#"search"#;
    const REMOVE: &str = r#"remove"#;
    // const : &str = r#""#;
}

/// Merge MIR Arguments
pub mod args {
    const __UPGRADE_PACKAGES: &str = r#"--upgrade-packages"#;
    // const __: &str = r#""#;
}

/// MgMIR Tokens
enum Token {
    // Keywords
    PluginList,

    // Options
    Install,
    // Arguments
}

enum TokenOpt {
    Intsall,
    Update,
    Search,
    Remove,
}

trait IsToken {
    fn is_token(&self) -> bool;
}
