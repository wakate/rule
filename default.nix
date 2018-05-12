{ pkgs ? import (fetchTarball https://github.com/NixOS/nixpkgs-channels/archive/nixos-18.03.tar.gz) {} }:

with pkgs;
stdenv.mkDerivation {
  name = "rule-builder";
  src = ./.;
  buildInputs = [
    pandoc
    (texlive.combine {
      inherit (texlive) platex collection-langjapanese;
    })
  ];
  installPhase = ''
    mkdir $out/
    cp rule.pdf $out/
  '';
}
