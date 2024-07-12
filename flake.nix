{
  nixConfig = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [ 
    ];
    extra-trusted-public-keys = [
    ];
  };

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-23.05";
    nur.url = "github:nix-community/NUR";
    utils.url = "github:numtide/flake-utils";
    naersk.url = "github:nix-community/naersk";
  };


  outputs = { self, nixpkgs, nixpkgs-stable, nur, ... } @ inputs: 
  let
    # nixpkgs_system = system:
    #   import nixpkgs {
    #     inherit system;
    #     config.allowUnfree = true;
    #   };
  in {
  } // inputs.utils.lib.eachDefaultSystem (system: 
  let
    pkgs = nixpkgs.legacyPackages.${system};
    linux_6_1_r5c = pkgs.callPackage ./pkgs/linux-r5c { };
    linux_6_8_r5c = pkgs.callPackage ./pkgs/linux-r5c-6-8 { };
    linux_6_6_r5c = pkgs.callPackage ./pkgs/linux-r5c-6-6 { };
  in
  {
    legacyPackages = {
    };
    packages = {
      inherit linux_6_1_r5c;
      inherit linux_6_8_r5c;
      inherit linux_6_6_r5c;
      linuxPackages_r5c = pkgs.linuxPackagesFor linux_6_1_r5c;
      linuxPackages_r5c_6_8 = pkgs.linuxPackagesFor linux_6_8_r5c;
      linuxPackages_r5c_6_6 = pkgs.linuxPackagesFor linux_6_6_r5c;
      tpconenatd = pkgs.callPackage ./pkgs/tpconenatd { };
      archlinux-repo = pkgs.callPackage ./pkgs/archlinux-repo { inherit inputs };
    };
  });
   
}
