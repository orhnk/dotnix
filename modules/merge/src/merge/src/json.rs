// mod json;
// mod macros;
// mod mg_compiler;

use crate::macros::{package_manager_function, package_manager_json};
use anyhow::{Context, Result};
use proc::{generate_single_package_manager_function, generate_single_package_manager_json_struct};
use serde::{Deserialize, Serialize};
use std::collections::HashMap;
use std::io::prelude::*;
use std::str::FromStr;
use std::{fs::File, io::BufReader};

pub mod files {
    pub const PACMAN: &str = "db/pacman.json";
    // pub const APT: &str = "db/apt.json";
    // pub const DNF: &str = "db/dnf.json";
    // pub const BREW: &str = "db/brew.json";
    // pub const CHOCO: &str = "db/choco.json";
    // pub const EMERGE: &str = "db/emerge.json";
    // pub const NIX: &str = "db/nix.json";
    // pub const PKG: &str = "db/pkg.json";
    // pub const PKGNG: &str = "db/pkgng.json";
    // pub const PORTAGE: &str = "db/portage.json";
    // pub const SNAP: &str = "db/snap.json";
    // pub const YUM: &str = "db/yum.json";
}

pub mod keywords {
    pub const PACKAGE_LIST: &str = "<package_list>";
    pub const SPACE: &str = " ";
    pub const NULL: &str = "";
    pub const NOT_SUPPORTED: &str = "<!>";
}

// package_manager_json!(pacman, apt, dnf, brew, choco, emerge, nix, pkg, pkgng, portage, snap, yum);
// package_manager_function!(pacman, apt, dnf, brew, choco, emerge, nix, pkg, pkgng, portage, snap, yum);

#[derive(Debug, Serialize, Deserialize)]
pub struct MirPmPair {
    pub name: String,
    pub mir_pm_pairs: HashMap<String, String>,
}

pub trait IntoMgMir {
    fn into_mir(&self, cmd: String) -> Result<String>;
}

pub trait IntoMgPm {
    fn into_pm(&self, cmd: String) -> Result<String>;
}

impl IntoMgMir for MirPmPair {
    fn into_mir(&self, cmd: String) -> Result<String> {
        let mut mg_mir = String::new();
        for (mir, pm) in self.mir_pm_pairs.iter() {
            mg_mir.push_str(&format!(
                "{} = {}{}{}",
                mir,
                pm,
                keywords::SPACE,
                keywords::PACKAGE_LIST
            ));
        }
        Ok(mg_mir)
    }
}

impl FromStr for MirPmPair {
    type Err = anyhow::Error;

    fn from_str(s: &str) -> std::prelude::v1::Result<Self, Self::Err> {
        let mut reader = BufReader::new(File::open(s)?);
        let mut contents = String::new();
        reader.read_to_string(&mut contents)?;
        let mir_pm_pair: MirPmPair = serde_json::from_str(&contents)?;
        Ok(mir_pm_pair)
    }
}

#[derive(Debug)]
struct MgSingleEmulator {
    mir: String,
    pm: String,
}

impl MgSingleEmulator {
    fn new(mir: String, pm: String) -> Self {
        MgSingleEmulator { mir, pm }
    }
}
