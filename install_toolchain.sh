#!/usr/bin/env bash

set -e
set -o pipefail

source ./base.sh
function INSTALL_TOOLCHAIN {
	LOGIT "Download xtensa toolchain"
	[[ ! -f "$latest_toolchain_file" ]] || RUN_FG rm -v "$latest_toolchain_file"
	[[ ! -d "./xtensa-lx106-elf" ]] || RUN_FG rm -rv "./xtensa-lx106-elf"
	RUN_FG wget "$latest_toolchain_url"
	RUN_FG tar xvf "$latest_toolchain_file"
	touch "./xtensa-lx106-elf/$latest_toolchain_file.version.txt"
	RUN_FG rm -v "$latest_toolchain_file"
}

LOGIT "Install toolchain when needed"
latest_toolchain_url="$(curl https://raw.githubusercontent.com/espressif/ESP8266_RTOS_SDK/master/README.md 2>/dev/null | grep "https://dl.espressif.com/dl/xtensa-lx106-elf-${TOOLCHAIN_VERSION:=linux64}" | head -n 1 | sed 's/.*\(http[s]*:\/\/[-./%@0-9A-Za-z]\+\).*/\1/g')"
latest_toolchain_file="xtensa-lx106-elf-${latest_toolchain_url//*xtensa-lx106-elf-}"
[[ -f "./xtensa-lx106-elf/$latest_toolchain_file.version.txt" ]] || INSTALL_TOOLCHAIN
