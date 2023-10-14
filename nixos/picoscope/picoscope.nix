{ config, pkgs, lib, dpkg 
, scopes ? [
  "picocv"
  "ps2000"
  "ps2000a"
  "ps3000"
  "ps3000a"
  "ps4000"
  "ps4000a"
  "ps5000"
  "ps5000a"
  "ps6000"
  "ps6000a"
], ... }:
let
  inherit (pkgs)
  fetchurl
  stdenv 
    ;

  unstable = import (
    builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs/archive/ea05d48289b457fbd75e3b9ac43dda5212f3a7c1.tar.gz";
      sha256 = "1mpk2v4yri19bdv8bp04fk0yhjpj0x9zi3wfcgqncy4y3r153cpp";
    })

    { config = config.nixpkgs.config; };


  sources =
    (lib.importJSON ./sources.json).${stdenv.system} or { picoscope.version = "unknown"; };

    scopePkg = name:
    { url, version, sha256 }:
    stdenv.mkDerivation rec {
      pname = "lib${name}";
      inherit version;
      src = fetchurl { inherit url sha256; };
      # picoscope does a signature check, so we can't patchelf these
      nativeBuildInputs = [ dpkg ];
      sourceRoot = ".";
      unpackCmd = "dpkg-deb -x $src .";
      installPhase = ''
        runHook preInstall
        mkdir -p $out/lib
        cp -d opt/picoscope/lib/* $out/lib
         runHook postInstall
      '';
      meta = with lib;
      shared_meta lib // {
        description = "library for picotech oscilloscope ${name} series";
      };
    };

    scopePkgs = lib.mapAttrs scopePkg sources;
in
{
  environment.systemPackages = with pkgs; [
    picoscope
  ];

  nixpkgs.overlays = [
    (final: prev: {
      picoscope = prev.picoscope.overrideAttrs (prev: {
        src = fetchurl { inherit (sources.picoscope) url sha256; };
        scopeLibs = lib.attrVals (map (x: "lib${x}") scopes) scopePkgs;
      });
    })
  ];
}
