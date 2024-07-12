{ pkgs, lib, stdenv, inputs }:
let
  inherit (stdenv.hostPlatform) system;

  plat = {
    x86_64-linux = "amd64";
    aarch64-linux = "aarch64";
  }.${system};
in
with pkgs;
inputs.naersk.buildPackage rec {
  pname = "archlinux-repo";
  version = "0.4.0";
  src = fetchTree {
    shallow = true;
	type = "git";
    url = "https://github.com/THMonster/archlinux-repo";
    ref = "main";
    rev = "2d6a6a4c4a8f5b1075df28c65db7a64616c91a94";
  };
  # cargoLock = {
  #   lockFile = ./Cargo.lock;
  # };
  nativeBuildInputs = [
    makeWrapper
  ];
  buildInputs = [ pacman ];
  postInstall = ''
    wrapProgram "$out/bin/archlinux-repo" --prefix PATH : ${lib.makeBinPath
      [ pacman ]}
  '';
  # postInstall = ''
   # '';
  # meta = {
  #   homepage = "https://a.com/";
  #   description = "aaa";
  #   license = with lib.licenses; [ mit ];
  # };
}
