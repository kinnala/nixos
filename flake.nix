{
  description = "NixOS configs";

  inputs = {
    nixpkgs = { url = "github:nixos/nixpkgs/nixos-22.05"; };
  };

  outputs = inputs:
  {
    nixosConfigurations = {

      tunkki = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./configuration.nix
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
