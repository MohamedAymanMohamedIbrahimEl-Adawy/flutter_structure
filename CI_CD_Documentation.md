
## 🚀 Flutter CI/CD with Fastlane and GitHub Actions

This guide outlines the steps to set up a robust Continuous Integration and Continuous Deployment (CI/CD) pipeline for your Flutter project using GitHub Actions and Fastlane.

## 📁 1. Project Structure

First, create the necessary folder structure in your project's root directory:

```bash
.github/workflows/
```

Inside the `workflows` folder, create a new file named `dart.yml`.

## 🔒 2. Firebase Configuration

If you're using Firebase, you must base64 encode your Google service files to store them securely as GitHub Actions secrets.

### 🤖 For Android (`google-services.json`)

Run the following command to encode the Android `google-services.json` file.

```bash
base64 -i android/app/google-services.json > google-services.base64.txt
```

### 🍎 For iOS (`GoogleService-Info.plist`)

#### Without Flavors

Use this command if you have a single `GoogleService-Info.plist` file.

```bash
base64 -i ios/Runner/GoogleService-Info.plist > GoogleService-Info.base64.txt
```

#### With Flavors (dev, stage, prod)

If you use different Firebase projects for different flavors, encode each `.plist` file separately.

```bash
# dev flavor
base64 -i ios/Runner/firebase/dev/GoogleService-Info.plist > dev.base64.txt

# stage flavor
base64 -i ios/Runner/firebase/stage/GoogleService-Info.plist > stage.base64.txt

# prod flavor
base64 -i ios/Runner/firebase/prod/GoogleService-Info.plist > prod.base64.txt
```

## 🔐 3. Android Signing Key

To sign your Android app securely in the CI environment, follow these steps:

### Encode the Keystore File:

```bash
base64 -i android/app/key.jks > key_jks.base64.txt
```

### Store GitHub Secrets:

- `KEYSTORE`: Base64 content of `key_jks.base64.txt`
- `KEY_PROPERTIES`: Content of your `key.properties` file

## 🚀 4. Firebase App Distribution

If you plan to use Firebase App Distribution, store the App ID for each flavor as a GitHub secret:

- `FIREBASE_APP_ID_ANDROID_DEV`
- `FIREBASE_APP_ID_ANDROID_STAGE`
- `FIREBASE_APP_ID_ANDROID_PROD`

## 🍎 5. iOS Signing with Fastlane Match

### Step 1: Initialize Fastlane

```bash
cd android
fastlane init
cd ..

cd ios
fastlane init
cd ..
```

### Step 2: Create a Private Git Repo for Certificates

Create a private repository and store its URL as a GitHub secret: `MATCH_GIT_URL`

### Step 3: Generate and Add a Deploy SSH Key

In your local macos machine run the following: 

```bash
ssh-keygen -t rsa -b 4096 -C "fastlane-match-deploy-key" -f ~/.ssh/fastlane-match-deploy
pbcopy < ~/.ssh/fastlane-match-deploy.pub
```

Add the public key to the GitHub repo (Settings > Deploy keys > Add key, allow write access).

### Step 4: Store the Private Key as a GitHub Secret

In your local macos machine run the following: 

```bash
base64 -i ~/.ssh/fastlane-match-deploy | tr -d '\\n' | pbcopy
```

Save it as `MATCH_GIT_PRIVATE_KEY`.

### Step 5: Configure and Run Fastlane Match

In your local macos machine run the following: 

```bash
cd ios
fastlane match init
fastlane match appstore
```

Store the password used as a GitHub secret: `MATCH_PASSWORD`

## 🔑 6. App Store Connect API Key

### Generate the API Key:

Go to App Store Connect > Users and Access > Integrations > App Store Connect API.

### Encode the Key File:

```bash
base64 -i AuthKey_XXXXXXXX.p8 > auth.base64.txt
```

### Store API Key Info as GitHub Secrets:

- `APP_STORE_CONNECT_P8_KEY_BASE64`
- `APP_STORE_CONNECT_KEY_ID`
- `APP_STORE_CONNECT_ISSUER_ID`

## 📝 7. GitHub Actions Secrets Summary

| Secret Name                     | Description                                 |
|--------------------------------|----------------------------------------------|
| ANDROID_GOOGLE_SERVICE_JSON    | `google-services.json` file for Android      |
| APPLE_EMAIL                    | Apple ID email                               |
| APPLE_ITC_TEAM_ID              | App Store Connect Team ID                    |
| APPLE_TEAM_ID                  | Apple Developer Team ID                      |
| APP_STORE_CONNECT_ISSUER_ID    | Issuer ID for API key                        |
| APP_STORE_CONNECT_KEY_ID       | Key ID for API key                           |
| APP_STORE_CONNECT_P8_KEY_BASE64| Base64 `.p8` file                            |
| FIREBASE_APP_ID_ANDROID_DEV    | Firebase dev flavor App ID                   |
| FIREBASE_APP_ID_ANDROID_PROD   | Firebase prod flavor App ID                  |
| FIREBASE_APP_ID_ANDROID_STAGE  | Firebase stage flavor App ID                 |
| FIREBASE_DISTRIBUTION_SERVICE  | Firebase credentials                         |
| GOOGLE_PLAY_SERVICE_ACCOUNT    | Google Play service account JSON             |
| GOOGLE_SERVICE_PLIST_DEV       | `.plist` for dev                             |
| GOOGLE_SERVICE_PLIST_PROD      | `.plist` for prod                            |
| GOOGLE_SERVICE_PLIST_STAGE     | `.plist` for stage                           |
| KEYSTORE                       | Base64 of `key.jks`                          |
| KEY_PROPERTIES                 | Content of `key.properties`                  |
| MATCH_GIT_PRIVATE_KEY          | Private SSH key                              |
| MATCH_GIT_URL                  | Match repo URL                               |
| MATCH_PASSWORD                 | Match password                               |

---

## ⚙️ 8. Android Fastlane Setup

داخل مجلد `android/fastlane/Fastfile`، أضف المسارات المناسبة للبناء والتوزيع. مثال:

```ruby
default_platform(:android)

platform :android do
  # 🔧 1. DEV: Upload to Firebase App Distribution
  desc "📦 Upload DEV to Firebase App Distribution"
  lane :firebase_dev do
    firebase_app_distribution(
      app: ENV["FIREBASE_APP_ID_ANDROID_DEV"],
      apk_path: "../build/app/outputs/flutter-apk/app-dev-release.apk",
      service_credentials_file: "firebase-service-account.json",
      release_notes: "CI/CD DEV build ##{Time.now.to_i}",
      # groups: "Dev"
    )
  end

  # 🔧 2. STAGE: Upload to Firebase App Distribution
  desc "📦 Upload STAGE to Firebase App Distribution"
  lane :firebase_stage do
    firebase_app_distribution(
      app: ENV["FIREBASE_APP_ID_ANDROID_STAGE"],
      apk_path: "../build/app/outputs/flutter-apk/app-stage-release.apk",
      service_credentials_file: "firebase-service-account.json",
      release_notes: "CI/CD STAGE build ##{Time.now.to_i}",
      # groups: "Dev"
    )
  end

  # 🚀 3. STAGE: Upload to Google Play (internal testing)
  desc "🚀 Upload STAGE to Google Play internal testing"
  lane :release_stage do
    gradle(
      task: "bundle",
      build_type: "Release",
      flavor: "stage"
    )

    upload_to_play_store(
      track: "internal",
      release_status: "draft",
      aab: "../build/app/outputs/bundle/stageRelease/app-stage-release.aab",
      json_key: "google-play-service-account.json"
    )
  end

  # 🔧 4. PROD: Upload to Firebase App Distribution
  desc "📦 Upload PROD to Firebase App Distribution"
  lane :firebase_prod do
    firebase_app_distribution(
      app: ENV["FIREBASE_APP_ID_ANDROID_PROD"],
      apk_path: "../build/app/outputs/flutter-apk/app-prod-release.apk",
      service_credentials_file: "firebase-service-account.json",
      release_notes: "CI/CD PROD build ##{Time.now.to_i}",
      # groups: "Dev"
    )
  end

  # 🚀 5. PROD: Upload to Google Play (production)
  desc "🚀 Upload PROD to Google Play production track"
  lane :release_prod do
    gradle(
      task: "bundle",
      build_type: "Release",
      flavor: "prod"
    )

    upload_to_play_store(
      track: "production",
      release_status: "completed",
      aab: "../build/app/outputs/bundle/prodRelease/app-prod-release.aab",
      json_key: "google-play-service-account.json"
    )
  end
end

```

---

## ⚙️ 9. iOS Fastlane Setup

داخل مجلد `ios/fastlane/Fastfile`، أضف ما يلي:

```ruby


# Run fastlane ci cd on github

default_platform(:ios)

platform :ios do
  ############################################
  # 🔧 إعداد Xcode المطلوب (اختياري حسب CI)
  # This lane is a good practice to ensure a consistent Xcode version.
  ############################################
  private_lane :use_xcode do
    UI.header("🔧 Selecting Xcode 16.2")
    xcode_select("/Applications/Xcode_16.2.app")
  end

  ############################################
  # 🔐 Lane عام لتوقيع الشهادات
  # General lane to set up code signing using `match`.
  # This uses a dedicated CI keychain for security.
  ############################################
  private_lane :setup_code_signing do |options|
    UI.header("🔐 Setting up code signing for #{options[:app_identifier]}")

    # Use a temporary keychain specifically for the CI run.
    # This prevents issues with the default keychain on the runner.
    # إنشاء واستخدام keychain مؤقت خاص بالـ CI لتجنب مشاكل الصلاحيات.
    setup_ci

    # First, update the project team to ensure consistency.
    # This is a critical step to prevent signing errors.
    # خطوة حاسمة: تحديث فريق العمل في إعدادات المشروع.
    # We will let Fastlane automatically use the team_id from the Appfile.
    update_project_team(
      path: "Runner.xcodeproj"
    )

    # Run `match` to sync the certificates and provisioning profiles.
    # This will download and install the profile in the keychain.
    # تشغيل `match` لتنزيل الشهادات والبروفايل.
    match(
      type: options[:type] || "appstore",
      app_identifier: options[:app_identifier]
    )
    
    # We will now explicitly set the provisioning profile and code signing identity
    # for the `Runner` target to ensure there are no conflicts. This is the most
    # reliable way to address the "Push Notifications" error.
    # الآن سنقوم بتحديث إعدادات التوقيع بشكل صريح لضمان استخدام البروفايل الصحيح.
    # هذا يحل مشكلة خاصية "Push Notifications" بشكل مباشر.
    update_code_signing_settings(
      path: "Runner.xcodeproj",
      targets: ["Runner"],
      use_automatic_signing: false,
      profile_name: "match AppStore #{options[:app_identifier]}",
      code_sign_identity: "Apple Distribution"
    )
  end

  ############################################
  # 🔁 Lane عام لبناء أي flavor
  # General lane to build and upload any flavor.
  # This lane has been updated to use App Store Connect API keys
  # from environment variables, which is a more secure method
  # than storing them directly in the Fastfile.
  ############################################
  private_lane :build_and_upload do |options|
    flavor = options[:flavor]
    identifier = options[:app_identifier]

    # Ensure the correct Xcode version is used
    # التأكد من استخدام إصدار Xcode الصحيح.
    use_xcode

    # First, run `flutter pub get` to ensure all Dart packages and
    # the necessary `Generated.xcconfig` file are in place.
    # خطوة جديدة: تشغيل `flutter pub get` أولاً لتوليد ملفات الإعداد اللازمة.
    sh "flutter pub get"

    
    # Install CocoaPods dependencies. This is a crucial step to ensure
    # all native libraries are available for the build.
    # تثبيت CocoaPods. هذه خطوة حاسمة لضمان توفر جميع المكتبات الأصلية للبناء.
    cocoapods(
      clean_install: true
    )

    # Set up the code signing using match
    # إعداد التوقيع باستخدام `match`.
    setup_code_signing(
      type: "appstore",
      app_identifier: identifier
    )

    # We now dynamically set the `scheme` and `configuration` based on the flavor
    # you provided. This resolves the `Couldn't find specified scheme` error.
    # تم الآن تحديث `scheme` و `configuration` ديناميكيًا بناءً على الـ flavor.
    # هذا يحل مشكلة عدم العثور على الـ scheme.
    build_app(
      workspace: "Runner.xcworkspace",
      scheme: flavor, # Use the flavor name as the scheme
      configuration: "Release-#{flavor}", # Use the flavor-specific release configuration
      clean: true,
      # `export_method` must match the `type` used in `match`.
      # يجب أن يتطابق هذا مع `type` في `match`.
      export_method: "app-store",
      # Set explicit build path and output directory to prevent conflicts and ensure
      # a clean environment for each build.
      # تعيين مسار بناء صريح ودليل إخراج لمنع التعارضات.
      build_path: "build/ios",
      output_directory: "build/ios/ipa"
    )

    # To securely upload to TestFlight, you must use an App Store Connect API Key.
    # Set the following environment variables in your CI/CD settings:
    # - `APP_STORE_CONNECT_KEY_ID`: Your API Key ID
    # - `APP_STORE_CONNECT_ISSUER_ID`: Your API Key Issuer ID
    # - `APP_STORE_CONNECT_KEY_FILEPATH`: The path to your downloaded .p8 key file
    api_key = app_store_connect_api_key(
      key_id: ENV["APP_STORE_CONNECT_KEY_ID"],
      issuer_id: ENV["APP_STORE_CONNECT_ISSUER_ID"],
      key_filepath: ENV["APP_STORE_CONNECT_KEY_FILEPATH"]
    )

    # Upload to TestFlight. This will now work because `build_app`
    # has successfully created a signed IPA.
    # رفع التطبيق إلى TestFlight.
    upload_to_testflight(
      api_key: api_key,
      skip_waiting_for_build_processing: true
    )
  end

  ############################################
  # 🍎 Lane لتوزيع dev
  # Lane for dev distribution.
  ############################################
  lane :dev do
    build_and_upload(
      flavor: "dev",
      app_identifier: "com.flutter.structure.dev"
    )
  end

  ############################################
  # 🍎 Lane لتوزيع stage
  # Lane for stage distribution.
  ############################################
  lane :stage do
    build_and_upload(
      flavor: "stage",
      app_identifier: "com.flutter.structure.stage"
    )
  end

  ############################################
  # 🍎 Lane لتوزيع prod
  # Lane for prod distribution.
  ############################################
  lane :prod do
    build_and_upload(
      flavor: "prod",
      app_identifier: "com.flutter.structure"
    )
  end
end

```
داخل مجلد `ios/fastlane/matchfile`، أضف المسارات المناسبة للبناء والتوزيع. مثال:

```ruby

# The URL of your private Git repository that holds the certificates.
git_url(ENV["MATCH_GIT_URL"])

# 💾 تخزين الشهادات والبروفايلات باستخدام git (افتراضي)
storage_mode("git")

# 🛡️ استخدم كلمة مرور لتشفير الملفات
git_branch("master")


# The type of provisioning profile to create or use.
type(ENV["MATCH_TYPE"] || "appstore") # or "development" or "ad-hoc"

# 📦 لا حاجة لاستخدام readonly لأننا نرفع ونسحب من نفس الجهاز في GitHub Actions
readonly(false)


# 👤 Apple Developer Info
# The name of your Team, which is your Apple Developer Account's Team ID.
team_id(ENV["APPLE_TEAM_ID"])
# The Apple Developer Portal username, typically your Apple ID email.
username(ENV["APPLE_EMAIL"])

```

---
داخل مجلد `ios/fastlane/appfile`، أضف المسارات المناسبة للبناء والتوزيع. مثال:

```ruby
# This Appfile is configured to use environment variables for all sensitive information.
# This is the recommended practice for CI/CD pipelines to ensure secrets are not exposed.

# The Apple Developer Portal username, typically your Apple ID email.
# This should be set in your GitHub Actions as the `FASTLANE_USER` secret.
apple_id(ENV["APPLE_EMAIL"])

# The App Store Connect Team ID. This is your numeric App Store Connect team ID.
# This should be set in your GitHub Actions as the `FASTLANE_ITC_TEAM_ID` secret.
itc_team_id(ENV["APPLE_ITC_TEAM_ID"])

# The Developer Portal Team ID. This is the 10-character team ID.
# This should be set in your GitHub Actions as the `FASTLANE_TEAM_ID` secret.
team_id(ENV["APPLE_TEAM_ID"])

# The `app_identifier` is handled per lane in the Fastfile to support
# different app flavors (dev, stage, prod).
# For more information about the Appfile, see:
# https://docs.fastlane.tools/advanced/#appfile

```

---

## ⚙️ 10. Example GitHub Actions Workflow (dart.yml)

ضع هذا الملف داخل `.github/workflows/dart.yml`:

```yaml
# 🍎🤖 iOS and Android CI/CD Flutter

# ----------------------------------------
# 1. Workflow Triggers
# The workflow runs on a manual dispatch or a push to the master branch.
# ----------------------------------------
on:
  workflow_dispatch:
  push:
    branches:
      - master

# ----------------------------------------
# 2. Environment Variables
# These variables are accessible throughout the entire workflow.
# ----------------------------------------
env:
  FLUTTER_VERSION: "3.32.8"

# ----------------------------------------
# 3. Jobs Configuration
# This workflow contains two main jobs: one for iOS and one for Android.
# Each job uses a matrix strategy to handle different build flavors.
# ----------------------------------------
jobs:
  # ----------------------------------------
  # 🍎 iOS Build Job
  # Builds and uploads the iOS app to TestFlight for each flavor.
  # ----------------------------------------
  ios-build:
    name: 🍏 iOS Build (${{ matrix.flavor }})
    runs-on: macos-latest

    strategy:
      matrix:
        flavor: [dev, prod, stage]

    steps:
      - name: 1. 🔄 Checkout code
        uses: actions/checkout@v4

      - name: 2. 🧩 Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
      
      - name: 3. 🔢 Increment Flutter Version
        run: |
          # Read the current version from pubspec.yaml
          VERSION_NAME=$(grep 'version:' pubspec.yaml | sed 's/version: //')
          # Extract the version name (e.g., 1.0.0)
          VERSION_NAME_ONLY=$(echo $VERSION_NAME | cut -d'+' -f1)
          # Get the GitHub run number as the build number
          BUILD_NUMBER=${{ github.run_number }}
          # Create the new version string
          NEW_VERSION="$VERSION_NAME_ONLY+$BUILD_NUMBER"
          # Use sed to replace the version in pubspec.yaml
          sed -i '' "s/version: $VERSION_NAME/version: $NEW_VERSION/" pubspec.yaml
          echo "Updated version to $NEW_VERSION"


      - name: 4. 🚀 Activate FlutterFire CLI
        run: dart pub global activate flutterfire_cli
        
      - name: 5. 🔐 Setup SSH for Fastlane Match
        run: |
          mkdir -p ~/.ssh
          echo "${{ secrets.MATCH_GIT_PRIVATE_KEY }}" | base64 --decode > ~/.ssh/match_fastlane
          chmod 600 ~/.ssh/match_fastlane
          echo "Host github.com
            HostName github.com
            IdentityFile ~/.ssh/match_fastlane
            IdentitiesOnly yes" >> ~/.ssh/config

      - name: 6. 📥 Setup Ruby
        uses: ruby/setup-ruby@v1
        with:
          ruby-version: '3.1'

      - name: 7. 🚀 Install Fastlane
        run: gem install fastlane

      - name: 8. 🔐 Setup Firebase Config
        run: |
          mkdir -p ios/Runner/firebase/${{ matrix.flavor }}
          if [ "${{ matrix.flavor }}" = "dev" ]; then
            echo "${{ secrets.GOOGLE_SERVICE_PLIST_DEV }}" | base64 --decode > ios/Runner/firebase/dev/GoogleService-Info.plist
          elif [ "${{ matrix.flavor }}" = "stage" ]; then
            echo "${{ secrets.GOOGLE_SERVICE_PLIST_STAGE }}" | base64 --decode > ios/Runner/firebase/stage/GoogleService-Info.plist
          elif [ "${{ matrix.flavor }}" = "prod" ]; then
            echo "${{ secrets.GOOGLE_SERVICE_PLIST_PROD }}" | base64 --decode > ios/Runner/firebase/prod/GoogleService-Info.plist
          fi

      - name: 9. Set up App Store Connect API Key
        run: |
          echo "${{ secrets.APP_STORE_CONNECT_P8_KEY_BASE64 }}" | base64 --decode > AuthKey.p8
          echo "APP_STORE_CONNECT_KEY_FILEPATH=$GITHUB_WORKSPACE/AuthKey.p8" >> $GITHUB_ENV
        
      - name: 10. 🛠️ Run Fastlane for ${{ matrix.flavor }}
        run: fastlane ios ${{ matrix.flavor }}
        working-directory: ios
        env:
          MATCH_PASSWORD: ${{ secrets.MATCH_PASSWORD }}
          MATCH_GIT_URL: ${{ secrets.MATCH_GIT_URL }}
          MATCH_TYPE: appstore
          APP_STORE_CONNECT_KEY_ID: ${{ secrets.APP_STORE_CONNECT_KEY_ID }}
          APP_STORE_CONNECT_ISSUER_ID: ${{ secrets.APP_STORE_CONNECT_ISSUER_ID }}
          # Apple credentials
          APPLE_EMAIL: ${{ secrets.APPLE_EMAIL }}
          APPLE_TEAM_ID: ${{ secrets.APPLE_TEAM_ID }}
          APPLE_ITC_TEAM_ID: ${{ secrets.APPLE_ITC_TEAM_ID }}

  # ----------------------------------------
  # 🤖 Android Build Job
  # Builds and uploads the Android app to Firebase App Distribution for each flavor.
  # Also builds AAB for prod and uploads to Google Play.
  # ----------------------------------------
  android-build:
    name: 🤖 Android Build (${{ matrix.flavor }})
    runs-on: macos-latest

    strategy:
      matrix:
        flavor: [dev, stage, prod]

    steps:
      - name: 1. 🔄 Checkout code
        uses: actions/checkout@v4

      - name: 2. 🧩 Setup Flutter
        uses: subosito/flutter-action@v2
        with:
          flutter-version: ${{ env.FLUTTER_VERSION }}
    
      - name: 3. 🔢 Increment Flutter Version
        run: |
          # Read the current version from pubspec.yaml
          VERSION_NAME=$(grep 'version:' pubspec.yaml | sed 's/version: //')
          # Extract the version name (e.g., 1.0.0)
          VERSION_NAME_ONLY=$(echo $VERSION_NAME | cut -d'+' -f1)
          # Get the GitHub run number as the build number
          BUILD_NUMBER=${{ github.run_number }}
          # Create the new version string
          NEW_VERSION="$VERSION_NAME_ONLY+$BUILD_NUMBER"
          # Use sed to replace the version in pubspec.yaml
          sed -i '' "s/version: $VERSION_NAME/version: $NEW_VERSION/" pubspec.yaml
          echo "Updated version to $NEW_VERSION"

      - name: 4.📦 Install dependencies
        run: flutter pub get

      # Optional steps, uncomment to enable static analysis and unit tests.
      # - name: 🔍 Analyze code
      #   run: flutter analyze

      # - name: ✅ Run unit tests
      #   run: flutter test

      - name: 5. 🔐 Android Signing & Firebase Setup 
        run: |
          echo "${{ secrets.KEY_PROPERTIES }}" > android/key.properties
          echo "${{ secrets.KEYSTORE }}" | base64 --decode > android/app/key.jks
          echo "${{ secrets.ANDROID_GOOGLE_SERVICE_JSON }}" | base64 --decode > android/app/google-services.json
          echo "${{ secrets.FIREBASE_DISTRIBUTION_SERVICE }}" | base64 --decode > android/firebase-service-account.json
          echo "${{ secrets.GOOGLE_PLAY_SERVICE_ACCOUNT }}" | base64 --decode > android/google-play-service-account.json

      - name: 6. 🛠️ Build APK
        run: flutter build apk --release --flavor ${{ matrix.flavor }}

      - name: 7. 🧠 Install bundler & fastlane
        run: |
          gem install bundler
          bundle install
        working-directory: android

      - name: 8. 📤 Upload APK
        uses: actions/upload-artifact@v4
        with:
          name: release-${{ matrix.flavor }}-apk-${{ github.run_number }}
          path: build/app/outputs/flutter-apk/app-${{ matrix.flavor }}-release.apk

      # Now, the environment variable names here match the ones in your Fastfile.
      - name: 9. 🚀 Upload to Firebase App Distribution (dev)
        if: matrix.flavor == 'dev'
        run: bundle exec fastlane firebase_dev
        working-directory: android
        env:
          FIREBASE_APP_ID_ANDROID_DEV: ${{ secrets.FIREBASE_APP_ID_ANDROID_DEV }}
          GOOGLE_APPLICATION_CREDENTIALS: firebase-service-account.json

      - name: 10. 🚀 Upload to Firebase App Distribution (stage)
        if: matrix.flavor == 'stage'
        run: bundle exec fastlane firebase_stage
        working-directory: android
        env:
          FIREBASE_APP_ID_ANDROID_STAGE: ${{ secrets.FIREBASE_APP_ID_ANDROID_STAGE }}
          GOOGLE_APPLICATION_CREDENTIALS: firebase-service-account.json

      - name: 11. 🚀 Upload to Firebase App Distribution (prod)
        if: matrix.flavor == 'prod'
        run: bundle exec fastlane firebase_prod
        working-directory: android
        env:
          FIREBASE_APP_ID_ANDROID_PROD: ${{ secrets.FIREBASE_APP_ID_ANDROID_PROD }}
          GOOGLE_APPLICATION_CREDENTIALS: firebase-service-account.json

      - name: 12. 🛠️ Build AAB for Prod
        if: matrix.flavor == 'prod'
        run: flutter build appbundle --release --flavor prod

      - name: 13. 📤 Upload AAB for Prod
        if: matrix.flavor == 'prod'
        uses: actions/upload-artifact@v4
        with:
          name: release-prod-aab-${{ github.run_number }}
          path: build/app/outputs/bundle/release/app-prod-release.aab

      # This step is commented out to prevent accidental uploads to Google Play.
      # Uncomment and configure the `release_prod` Fastlane lane when ready.
      - name: 14. 📤 Upload to Google Play
        if: matrix.flavor == 'prod'
        run: bundle exec fastlane release_prod
        working-directory: android

```

---

## ✅ Final Tips

- تأكد أن جميع الـ secrets معرفة في GitHub Repository الخاص بك.
- اختبر كل `lane` بشكل منفصل باستخدام الأمر `fastlane ios dev` أو `fastlane android dev`.
- استخدم ملفات `main_dev.dart`, `main_stage.dart`, `main_prod.dart` لتحديد نكهات التطبيق.
- يفضل إنشاء مجلد `flavors` داخل `lib/` لتنظيم الأكواد الخاصة بكل نكهة.

---

## 🧠 References

- [Fastlane Docs](https://docs.fastlane.tools/)
- [Flutter CI/CD with GitHub Actions](https://docs.flutter.dev/)
- [Firebase App Distribution](https://firebase.google.com/docs/app-distribution)

---

🎉 **Congratulations!** You've set up a full CI/CD pipeline for your Flutter app using Fastlane and GitHub Actions.

---

## ✍️ Author

**Mohamed Adawy**

---


