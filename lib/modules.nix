{
  importModules = modules: {
    imports = builtins.map (module: 
    if builtins.isPath module then
      module
    else if builtins.pathExists ../modules/${module}.nix then
      ../modules/${module}.nix
    else ../modules/${module}
      ) modules;
  };
}
