{ lib, stdenv, pkgs }:
let
  inherit (stdenv.hostPlatform) system;

  plat = {
    x86_64-linux = "amd64";
    aarch64-linux = "aarch64";
  }.${system};
in
with pkgs;
stdenv.mkDerivation rec {
  pname = "tpconenatd";
  version = "1.0.0";
  src = fetchTree {
    shallow = true;
	type = "git";
    url = "https://github.com/claw6148/TPConeNATd";
    ref = "master";
    rev = "999a02391605629943361120f15183c363f31b71";
  };
  nativeBuildInputs = [
    cmake
  ];
  buildInputs = [ p7zip ];

  cmakeFlags = [ "-DWITH_STATIC=OFF"  "-DCMAKE_BUILD_WITH_INSTALL_NAME_DIR=ON"
    # RPATH of binary /nix/store/.../bin/... contains a forbidden reference to /build/
    "-DCMAKE_SKIP_BUILD_RPATH=ON"
  ];

  installPhase = ''
    install -Dm755 ./TPConeNATd -t $out/bin
  '';

  meta = {
    homepage = "https://a.com/";
    description = "aaa";
    license = with lib.licenses; [ mit ];
  };
}
