#!/usr/bin/env bash

set -e
set -o pipefail

source ./base.sh

LOGIT "Install RTOS"
[[ -d "./ESP8266_RTOS_SDK" ]] ||
	RUN_FG git clone https://github.com/espressif/ESP8266_RTOS_SDK
RUN_FG git -C "./ESP8266_RTOS_SDK" pull
