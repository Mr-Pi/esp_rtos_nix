with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "env";
  nativeBuildInputs = [
    curl
    git
    wget
    gnutar
    findutils
    (python3.withPackages(ps: with ps; [
      pyserial
      future
      cryptography
      pyparsing
    ]))
    cacert
    flex
    bison
    gperf
    ncurses
  ];
  buildInputs = [
  ];

  shellHook = ''
    ./install_toolchain.sh
    ./install_rtos.sh

    export PATH="$PWD/xtensa-lx106-elf/bin:$PATH"
    export IDF_PATH="''${PWD}/ESP8266_RTOS_SDK"
    cd "$IDF_PATH"
  '';
}
