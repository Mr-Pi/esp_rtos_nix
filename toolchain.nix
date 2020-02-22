{ stdenv, fetchurl, makeWrapper, buildFHSUserEnv }:

let
  fhsEnv = buildFHSUserEnv {
    name = "esp8266-toolchain-env";
    targetPkgs = pkgs: with pkgs; [ zlib ];
    runScript = "";
  };
in

stdenv.mkDerivation rec {
  pname = "esp8266-toolchain";
  version = (import ./toolchain-version.nix).version;

  src = fetchurl {
    inherit (import ./toolchain-version.nix) url sha256;
  };

  buildInputs = [ makeWrapper ];

  phases = [ "unpackPhase" "installPhase" ];

  installPhase = ''
    cp -r . $out
    for FILE in $(ls $out/bin); do
      FILE_PATH="$out/bin/$FILE"
      if [[ -x $FILE_PATH ]]; then
        mv $FILE_PATH $FILE_PATH-unwrapped
        makeWrapper ${fhsEnv}/bin/esp8266-toolchain-env $FILE_PATH --add-flags "$FILE_PATH-unwrapped"
      fi
    done
  '';
}
