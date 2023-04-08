#!/usr/bin/env bash

set -e

BASE_DIR=`dirname $0`

FORMAT="json"
TOKEN="26e4b536-d6fa-4a23-9358-7411f29c0985"
URL="https://script.google.com/macros/s/AKfycbxXcN-ECnPwE2gGgMZYBZwsRrITbf2hpJlLlTdPBKP7hPFC1__WyF6L_AhzIy0L2f6OPw/exec"

wget -O "${BASE_DIR}/../assets/i18n/en.json" "${URL}?locale=en&format=${FORMAT}&token=${TOKEN}"
wget -O "${BASE_DIR}/../assets/i18n/es.json" "${URL}?locale=es&format=${FORMAT}&token=${TOKEN}"

flutter pub upgrade
flutter pub pub run dalocale:dalocale.dart ./assets/i18n/ ./lib/utils/localizations.dart en ./lib
dart format lib