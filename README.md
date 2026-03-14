# WifiShortcut

A minimal Android app that opens the device Wi-Fi settings screen when launched.

## Overview

`WifiShortcut` is a lightweight launcher shortcut app. It has no UI screens of its own.

When the app starts, it:
1. Launches Android Wi-Fi settings using `Settings.ACTION_WIFI_SETTINGS`
2. Closes immediately

This is useful if you want one-tap access to Wi-Fi settings from your home screen.

## Features

- Fast launch to Wi-Fi settings
- No extra permissions required
- Small, simple codebase

## Tech Stack

- Java (Android)
- Android SDK 33
- Minimum SDK 28 (Android 9)
- Target SDK 33
- Android Gradle Plugin 7.4.2
- Gradle Wrapper 8.10.2 (configured in this repo)

## Project Structure

```text
WifiShortcut/
├─ app/
│  ├─ src/main/java/com/example/wifishortcut/WifiShortcutActivity.java
│  ├─ src/main/AndroidManifest.xml
│  └─ build.gradle
├─ build.gradle
├─ settings.gradle
└─ gradlew
```

## How It Works

The launcher activity (`WifiShortcutActivity`) runs this intent:

```java
startActivity(new Intent(Settings.ACTION_WIFI_SETTINGS));
finish();
```

That immediately opens system Wi-Fi settings and then ends the app activity.

## Getting Started

### Prerequisites

- Android Studio (recent stable version)
- JDK compatible with your Android Gradle Plugin setup
- Android SDK platform 33 installed

### Build and Run (Android Studio)

1. Open this folder in Android Studio.
2. Let Gradle sync complete.
3. Connect an Android device or start an emulator (API 28+).
4. Click **Run**.

### Build from Command Line

```bash
./gradlew assembleDebug
```

Debug APK output path:

```text
app/build/outputs/apk/debug/app-debug.apk
```

### Build and Release with Makefile

Use the included `Makefile` to simplify build commands:

```bash
make debug
```

Build release APK:

```bash
make release
```

Build release APK with explicit version values:

```bash
make release VERSION=1.2.3 VERSION_CODE=12
```

Build release AAB (for Play Store upload workflows):

```bash
make bundle
```

Build release AAB with explicit version values:

```bash
make bundle VERSION=1.2.3 VERSION_CODE=12
```

Build all artifacts:

```bash
make all
```

Show expected artifact paths:

```bash
make artifacts
```

Create a GitHub Release with assets (requires GitHub CLI and auth):

```bash
make github-release TAG=v1.0.0
```

Build and publish a public GitHub Release in one command:

```bash
make public-release TAG=v1.0.0
```

Optionally target a specific repository:

```bash
make public-release TAG=v1.0.0 REPO=Baghdady92/WifiShortcut
```

The `github-release` target uses:
- `TAG` (for example `v1.2.3`) as app `versionName` (`1.2.3`)
- Git commit count as app `versionCode`

The `public-release` target:
- Builds release APK and AAB with version from tag
- Creates the tag if missing and pushes it to `origin`
- Publishes a non-draft GitHub Release with uploaded artifacts

Release artifacts:

```text
app/build/outputs/apk/release/app-release-unsigned.apk
app/build/outputs/bundle/release/app-release.aab
```

Note: the release APK is unsigned unless you configure a signing setup in the Gradle build.

## GitHub Releases

This repository includes a GitHub Actions workflow at `.github/workflows/release.yml`.

What it does:
- Runs on tag pushes matching `v*` (for example: `v1.0.0`)
- Builds release APK and AAB
- Creates a GitHub Release
- Uploads generated APK/AAB as release assets
- Sets app `versionName` from tag (for example `v1.2.3` -> `1.2.3`)
- Sets app `versionCode` from GitHub Actions run number

Create and push a version tag:

```bash
git tag v1.0.0
git push origin v1.0.0
```

After the workflow completes, the release appears in your repository's Releases page.

## Package Name

- `com.example.wifishortcut`

## Notes

- This app opens the standard Android Wi-Fi settings page.
- Behavior can vary slightly across device manufacturers and Android versions.

## License

No license file is currently included in this repository. Add a `LICENSE` file if you plan to share or distribute this project publicly.
