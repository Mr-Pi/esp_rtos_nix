with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "env";
  nativeBuildInputs = [
    curl
    git
    wget
    gnutar
    findutils
    (python2.withPackages(ps: with ps; [
      pyserial
      future
      cryptography
      pyparsing
      setuptools
      click
      pyelftools
    ]))
    (python3.withPackages(ps: with ps; [
      pyserial
      future
      cryptography
      pyparsing
      setuptools
      click
      pyelftools
    ]))
    cacert
    flex
    bison
    gperf
    ncurses
    pkgconfig
  ];
  buildInputs = [
  ];

  shellHook = ''
    ./install_toolchain.sh
    ./install_rtos.sh

    export PATH="$PWD/xtensa-lx106-elf/bin:$PATH"
    export IDF_PATH="''${PWD}/ESP8266_RTOS_SDK"
    cd "$IDF_PATH"
    cd examples/get-started/hello_world
  '';
}
