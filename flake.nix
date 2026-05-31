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
		# nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.11";
		# nur.url = "github:nix-community/NUR";
		# utils.url = "github:numtide/flake-utils";
		# naersk.url = "github:nix-community/naersk";
	};


	outputs = { self, nixpkgs, ... } @ inputs: 
	let
		lib = nixpkgs.lib;
		forAllSystems = lib.genAttrs lib.systems.flakeExposed;
	in {
		packages = forAllSystems (system:
		let
			pkgs = import nixpkgs { inherit system; };
		in {
			linuxPackages_r5c = import ./pkgs/linux-r5c { inherit pkgs; };
			tpconenatd = pkgs.callPackage ./pkgs/tpconenatd { };
			archlinux-repo = pkgs.callPackage ./pkgs/archlinux-repo { };
		});
	};
}
