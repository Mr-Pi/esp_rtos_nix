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
  ];

  shellHook = ''
    ./install_rtos.sh

    export IDF_PATH="''${PWD}/ESP8266_RTOS_SDK"
    cd "$IDF_PATH"
    cd examples/get-started/hello_world
  '';
}
