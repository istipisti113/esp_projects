{
  description = "ESP-IDF Rust environment with ldproxy";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    esp-dev.url = "github:mirrexagon/nixpkgs-esp-dev";
    esp-dev.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, esp-dev }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs { inherit system; };
      baseShell = esp-dev.devShells.${system}.esp-idf-full;
    in
    {
      devShells.${system}.default = pkgs.mkShell {
        inputsFrom = [ baseShell ];
        buildInputs = with pkgs; [
          ldproxy
        ];
        shellHook = ''
          # 1. Tell the dynamic linker where to find libstdc++.so.6
export LD_LIBRARY_PATH="$(nix eval --raw nixpkgs#stdenv.cc.cc.lib)/lib:$LD_LIBRARY_PATH"

# 2. Explicitly point bindgen to the Nix-provided libclang
export LIBCLANG_PATH="$(nix eval --raw nixpkgs#llvmPackages.libclang.lib)/lib"
        '';
      };
    };
}
