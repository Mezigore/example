#!/bin/sh

# Add certificates to keychain and allow codesign to access them
security import ./certs/development.p12 -P "" -T /usr/bin/codesign
security import ./certs/distribution.p12 -P "" -T /usr/bin/codesign

output=~/Library/MobileDevice/Provisioning\ Profiles

if [[ ! -e "$output" ]]; then
    mkdir -p "$output"
fi

cp -R  ./certs/Uzhin_Doma_Dev.mobileprovision "${output}"
cp -R  ./certs/Uzhin_Doma_Distr.mobileprovision "${output}"