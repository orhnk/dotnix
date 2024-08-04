mod cli;
mod cmd;
mod json;
mod macros;
mod pmsearch;
// mod mg_compiler;

use std::io::Read;
use std::os::unix::process::CommandExt;
use std::path::Path;
use std::{fs::File, process::Command};

use anyhow::{bail, Context as _};
use clap::Parser;
use cli::MergeArgs;
// use log::{debug, error, info, warn};
use serde::{Deserialize, Serialize};

use crate::json::{keywords, MirPmPair};

package_manager_json! { pacman }

fn main() -> anyhow::Result<()> {
    let args = dbg!(MergeArgs::parse());

    let system_pm = pmsearch::infer_sys_package_manager();

    if system_pm.is_none() {
        bail!("No package manager found on the system")
    }

    let system_pm = system_pm.unwrap();

    let mut merge_db = dirs::config_dir().context("Failed to get config dir")?;
    merge_db.push(Path::new("merge/db"));

    let system_db_path = {
        let mut db_path = merge_db.clone();
        db_path.push(Path::new(
            format!("{}.json", system_pm.to_string()).as_str(),
        ));
        db_path
    };

    let queried_db_path = {
        let mut db_path = merge_db.clone();
        db_path.push(Path::new(
            format!("{}.json", args.package_manager.to_string()).as_str(),
        ));
        db_path
    };

    dbg!(&system_db_path);
    dbg!(&queried_db_path);

    if system_pm == args.package_manager {
        // if the user called the package manager that is installed on the system
        // Don't do any conversion, just copy&paste user input to the shell

        Command::new(args.package_manager.to_string().as_str())
            .arg(&args.action)
            .args(&args.packages)
            .exec();
    } else {
        let mut queried_mir_pm_db = File::open(queried_db_path)
            .context("Package Manager used is not supported by merge database")?;
        let mut target_mir_pm_db = File::open(system_db_path)
            .context("Package Manager used is not supported by merge database")?;

        let mut queried_db_str_buf = String::new();
        let mut target_db_str_buf = String::new();

        queried_mir_pm_db.read_to_string(&mut queried_db_str_buf)?;
        target_mir_pm_db.read_to_string(&mut target_db_str_buf)?;

        let queried_mir_pm_db: MirPmPair = serde_json::from_str(&queried_db_str_buf)?;
        let target_mir_pm_db: MirPmPair = serde_json::from_str(&target_db_str_buf)?;

        dbg!(&queried_mir_pm_db);
        dbg!(&target_mir_pm_db);
        dbg!(&args.package_manager);
        dbg!(&args.action);

        let mir_query = if args.packages.is_empty() {
            vec![args.action]
        } else {
            vec![args.action, keywords::PACKAGE_LIST.to_string()]
        };

        let matched_mir = queried_mir_pm_db
            .mir_pm_pairs
            .iter()
            .find(|(_, pm)| {
                println!("{}", pm);
                let vectorized = pm.split(keywords::SPACE);
                vectorized.collect::<Vec<_>>() == mir_query
            })
            .ok_or_else(|| anyhow::anyhow!("No MIR found for the given package manager"))?
            .0; // get the MIR

        dbg!(matched_mir);

        let matching_args = target_mir_pm_db
            .mir_pm_pairs
            .get(matched_mir)
            .unwrap()
            .replace(
                keywords::PACKAGE_LIST,
                args.packages.join(keywords::SPACE).as_str(),
            );

        if matching_args == keywords::NOT_SUPPORTED {
            bail!("The given attribute is not supported by the given package manager")
        }

        // Target a package manager that is not installed on the system
        // Convert user input into MIR, then convert MIR into the target package manager
        println!(
            "Should convert from {} to {}",
            args.package_manager, system_pm
        );

        let mut final_cmd = target_mir_pm_db.name.to_string();
        final_cmd.push_str(&(keywords::SPACE.to_string() + matching_args.as_str()));

        eprintln!("INFERRED CMD: {}", final_cmd);

        Command::new(target_mir_pm_db.name.to_string())
            .args(matching_args.split(keywords::SPACE))
            .exec();
    }
    Ok(())
}
