use crate::cli::MergePackageManager;
use std::process::{Command, Stdio};
/**
 * This module is responsible for inferring your package managers from your system
 */
use strum::IntoEnumIterator;

/**
 * Checks if the system has the specified package manager.
 *
 * # Arguments
 *
 * * `package_manager` - The package manager to check.
 *
 * # Returns
 *
 * Returns `true` if the system has the specified package manager, otherwise `false`.
 */
pub fn system_has_package_manager(package_manager: &MergePackageManager) -> bool {
    dbg!(package_manager.to_string());
    Command::new(package_manager.to_string())
        .stdout(Stdio::null())
        .stderr(Stdio::null())
        .spawn()
        .is_ok()
}

/**
 * Infers the system's package manager.
 *
 * # Returns
 *
 * Returns an `Option<MergePackageManager>` representing the inferred package manager, or `None` if no package manager is found.
 */
pub fn infer_sys_package_manager() -> Option<MergePackageManager> {
    for package_manager in MergePackageManager::iter() {
        if system_has_package_manager(&package_manager) {
            return Some(package_manager);
        }
    }
    None
}
