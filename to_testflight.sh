#!/bin/bash
flutter clean
#flutter pub get
#cd ios || exit
#pod install
#cd ..
flutter build ipa --flavor prod
cd ios || exit
fastlane beta