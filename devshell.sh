nix develop github:mirrexagon/nixpkgs-esp-dev#esp-idf-full

export LD_LIBRARY_PATH="$(nix eval --raw nixpkgs#stdenv.cc.cc.lib)/lib:$LD_LIBRARY_PATH"
export LIBCLANG_PATH="$(nix eval --raw nixpkgs#llvmPackages.libclang.lib)/lib"
