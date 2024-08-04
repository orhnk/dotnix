lib: {
  enabled =
    lib.mkMerge [
      {
        enable = true;
      }
    ]
    // {
      __functor = self: attributes:
        self
        // {
          contents = self.contents ++ [attributes];
        };
    };

  disabled = {enable = lib.mkForce false;};

  normalUser = attributes:
    attributes
    // {
      isNormalUser = true;
    };

  graphicalUser = attributes:
    attributes
    // {
      extraGroups = ["graphical"] ++ (attributes.extraGroups or []);
      isNormalUser = true;
    };
}
