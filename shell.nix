with import <nixpkgs> {};

stdenv.mkDerivation {
  name = "esp8266-env";
  nativeBuildInputs = [
    (python2.withPackages(ps: with ps; [
      pyserial
      future
      cryptography
      pyparsing
      setuptools
      click
      pyelftools
    ]))
    (callPackage ./toolchain.nix {})
    bison
    flex
    gperf
    ncurses
  ];

  shellHook = ''
    export IDF_PATH="''${PWD}/ESP8266_RTOS_SDK"
    export NIX_CFLAGS_LINK=-lncurses

    if ! [[ -d "$IDF_PATH" ]]; then
      git clone https://github.com/espressif/ESP8266_RTOS_SDK
    fi
    git -C "$IDF_PATH" pull

    mkdir -pv projects
    cd projects
  '';
}
