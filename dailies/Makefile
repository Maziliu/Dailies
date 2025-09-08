dependencies:
	flutter clean
	flutter pub get

generate:
	flutter pub run build_runner build

build_install_apk:
	flutter build apk --release
	adb install build/app/outputs/flutter-apk/app-release.apk