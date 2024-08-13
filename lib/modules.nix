lib: rec {
  importModules =
    let
      inherit (lib.lists) flatten forEach;
      importModule = module:
        if builtins.isPath module then module
        else if builtins.pathExists ../modules/${module}.nix then ../modules/${module}.nix
        else if builtins.pathExists ../modules/${module} then ../modules/${module}
        else throw "Invalid Module Expression Detected!";
    in
    modules: {
    imports = flatten (forEach modules (module:
      if builtins.isList module then # To easily show dependencies
        builtins.map importModule module
      else importModule module
    ));
  };
}
