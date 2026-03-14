# Makefile for WifiShortcut Android project
# Uses the Gradle wrapper included in this repository.

GRADLEW := ./gradlew
DEBUG_APK := app/build/outputs/apk/debug/app-debug.apk
RELEASE_APK := app/build/outputs/apk/release/app-release-unsigned.apk
RELEASE_AAB := app/build/outputs/bundle/release/app-release.aab
VERSION ?= 1.0.0
VERSION_CODE ?= 1
GRADLE_VERSION_ARGS := -PVERSION_NAME=$(VERSION) -PVERSION_CODE=$(VERSION_CODE)

.PHONY: help clean debug release bundle all artifacts github-release

help:
	@echo "Available targets:"
	@echo "  make clean     - Clean build outputs"
	@echo "  make debug     - Build debug APK"
	@echo "  make release   - Build release APK (unsigned unless signing is configured)"
	@echo "  make bundle    - Build release AAB"
	@echo "  make all       - Build debug + release APK + release AAB"
	@echo "  make artifacts - Show expected artifact paths"
	@echo "  make release VERSION=1.2.3 VERSION_CODE=12 - Build release APK with version values"
	@echo "  make bundle VERSION=1.2.3 VERSION_CODE=12  - Build release AAB with version values"
	@echo "  make github-release TAG=vX.Y.Z - Build release assets and publish a GitHub Release"

clean:
	$(GRADLEW) clean

debug:
	$(GRADLEW) assembleDebug

release:
	$(GRADLEW) assembleRelease $(GRADLE_VERSION_ARGS)

bundle:
	$(GRADLEW) bundleRelease $(GRADLE_VERSION_ARGS)

all: debug release bundle

artifacts:
	@echo "Debug APK:   $(DEBUG_APK)"
	@echo "Release APK: $(RELEASE_APK)"
	@echo "Release AAB: $(RELEASE_AAB)"

github-release:
	@test -n "$(TAG)" || (echo "Error: TAG is required. Example: make github-release TAG=v1.0.0" && exit 1)
	@command -v gh >/dev/null 2>&1 || (echo "Error: GitHub CLI (gh) is required." && exit 1)
	@VERSION_FROM_TAG=$${TAG#v}; VERSION_CODE_FROM_GIT=$$(git rev-list --count HEAD); \
		$(GRADLEW) assembleRelease bundleRelease -PVERSION_NAME=$$VERSION_FROM_TAG -PVERSION_CODE=$$VERSION_CODE_FROM_GIT
	@gh release create "$(TAG)" "$(RELEASE_APK)" "$(RELEASE_AAB)" --generate-notes
