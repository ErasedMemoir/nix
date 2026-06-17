{
  inputs = {
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";

    preservation.url = "github:nix-community/preservation";
    import-tree.url = "github:vic/import-tree";
  };

  outputs = inputs: {
    nixosConfigurations.nixos-vm = inputs.nixpkgs.lib.nixosSystem {
      specialArgs = { inherit inputs; };
      system = "x86_64-linux";

      modules = [
        {
          imports = [
            inputs.preservation.nixosModules.preservation
            (inputs.import-tree [ ./modules ])
          ];

          system.stateVersion = "26.05";
          networking.hostName = "nixos-vm";
        }
      ];
    };

    packages.x86_64-linux.vm = inputs.self.nixosConfigurations.nixos-vm.config.system.build.vm;
  };
}
