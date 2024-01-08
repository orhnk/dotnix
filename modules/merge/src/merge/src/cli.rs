use clap::{Parser, ValueEnum};
use strum_macros::{Display, EnumIter};

#[derive(Debug, Parser, Clone)]
#[command(author, version, about)]
pub struct MergeArgs {
    /// Package Manager Backend to get used
    pub package_manager: MergePackageManager,

    // NOTE: maybe a string here could be enough
    /// Actions to perform on packages
    #[arg(allow_hyphen_values = true)]
    pub action: String,

    // #[arg(last = true)]
    pub packages: Vec<String>,
    // #[arg(last(true))]
    // pub raw_args: Vec<String>,
}

// TODO: move this to a separate file
#[derive(ValueEnum, Debug, Clone, Display, PartialEq, Eq, EnumIter)]
#[strum(serialize_all = "lowercase")]
pub enum MergePackageManager {
    Pacman,
    Apt,
    Nix,
}
// Autocompleting proc-macro bodies!!!
// Eiy fiel da  pe-wah
