# 📱 Clean Architecture Mobile App

This project follows a modular, scalable, and testable architecture using a combination of **feature-based** and **layered architecture** patterns.

---

## 🚀 Features

- ✅ **Clean Architecture** (Core / Features / DI)
- 🔒 **Security Checks** (Root, VPN, Emulator, etc.)
- 🌐 **Robust Networking Layer** with Dio + Interceptors
- 🌍 **Multilingual Support** (Easy Localization)
- 🔁 **Automatic Token Refreshing**
- 📶 **Offline Handling** (Connectivity/Cache)
- 💉 **Dependency Injection** using `get_it`
- ⚠️ **Centralized Error Handling**
- 🧱 **State Management** using Bloc + Cubit
- 🔔 **Local & Push Notifications**
- 📅 **Calendar, Maintenance Modules**
- 🔐 **Biometric Login (Fingerprint / Face ID)**

---

## 🗂️ Project Structure

```
lib/
├── core/                      # Shared logic, services, and UI components
│   ├── component/             # Reusable UI widgets (e.g., buttons, carousels, loaders)
│   ├── data/                  # Shared data helpers (if any)
│   ├── extensions/            # Dart extension methods
│   ├── global/                # Global constants, themes, etc.
│   └── services/              # App-wide services (networking, auth, VPN, notifications, etc.)
│
├── features/                  # Feature-first modules (UI + Logic per screen or domain)
│   ├── home/                  # Home module
│   │   ├── data/
│   │   │   ├── model/         # Models like TeamMemberModel
│   │   │   └── repo/          # Repository implementation
│   │   ├── domain/
│   │   │   ├── repo/          # Abstract repository interface
│   │   │   └── usecase/       # Use case logic
│   │   └── presentation/
│   │       ├── view/
│   │       │   ├── screen/    # Desktop, mobile, web versions of the screen
│   │       │   └── widgets/   # UI components like team member cards
│   │       └── bloc/          # BLoC files
│   │
│   ├── calendar/              # Calendar module
│   │   ├── data/              # Calendar models and repo implementation
│   │   ├── domain/            # Use cases and repository interfaces
│   │   └── presentation/      # Screens and BLoC for calendar UI
│   │
│   ├── onboard/               # Onboarding screens and logic
│   │   ├── data/
│   │   ├── domain/
│   │   └── presentation/
│   │
│   ├── Splash/                # Splash screen and startup logic
│   │   └── presentation/
│   │       └── bloc/          # Splash BLoC and event
│   │
│   └── more/                  # Settings or 'More' screen
│       ├── data/              # Logout model and implementation
│       └── domain/            # Logout repository interface
│
├── di.dart                    # Dependency injection setup
├── main.dart                  # App entry point
├── myapp.dart                 # Root MaterialApp and app config
└── p_bloc_builder.dart        # Shared BLoC builder utility
```

---

## ✅ Highlights

- **Feature-based separation**: Each module contains `data`, `domain`, and `presentation` layers.
- **Clean Architecture**: Encourages separation of concerns, easy unit testing, and maintenance.
- **Reusable Components**: Centralized in `core/component` for efficiency and consistency.
- **Service Abstractions**: All core services are grouped and abstracted under `core/services/`.

---

## 📌 Recommended Practices

- Add unit tests that mirror the `features/` structure.
- Use `barrel files` for cleaner imports (e.g., `export 'bloc/home_bloc.dart';`).
- Separate `theme`, `constants`, and `utils` under a `shared/` folder if they grow.
- Remove `.DS_Store` files from macOS for cleanliness (they are non-functional).

---

## 📈 Scalability

This architecture allows you to:
- Easily add or remove features without affecting other modules.
- Maintain clear boundaries between business logic and UI.
- Plug in different services (auth, VPN, notifications) with minimal refactoring.

---

## 🧪 Testing Strategy

Each `domain/usecase` and `data/repo` is designed to be **easily mockable and testable**. BLoC logic should have corresponding unit tests to ensure robust behavior.

---

## 🧠 State Management

All business and UI logic is managed using **Bloc || Cubit**

---

## 📦 Main Dependencies

> ✅ Grouped by use-case and importance.

### 🧠 Core Logic & Architecture
- `flutter_bloc`, `equatable`, `get_it`, `dartz`

### 🌐 Network & Logging
- `dio`, `http`, `pretty_dio_logger`, `http_parser`

### 🧭 Routing
- `go_router`

### 📡 Connectivity
- `connectivity_plus`, `internet_connection_checker`

### 🌍 Localization
- `easy_localization`

### 🔐 Security & Permissions
- `flutter_security_checker`, `permission_handler`, `screen_protector`, `local_auth`, `flutter_secure_storage`

### 🗂️ State Persistence
- `shared_preferences`, `flutter_dotenv`

### 📸 Media Handling
- `image_picker`, `file_picker`, `open_filex`, `path`, `cached_network_image`

### 🗓️ UI Widgets & Animation
- `sizer`, `flash`, `flutter_spinkit`, `skeletonizer`, `animations`, `flutter_slidable`, `table_calendar`, `flutter_staggered_animations`, `flutter_widget_from_html`, `flutter_svg`, `badges`, `liquid_pull_to_refresh`

### 🔔 Notifications
- `flutter_local_notifications`, `firebase_messaging`

### 📦 Firebase
- `firebase_core`, `firebase_crashlytics`, `firebase_analytics`, `firebase_messaging`

### ⚙️ Utilities
- `package_info_plus`, `url_launcher`, `characters`, `encrypt`, `hijri`, `in_app_update`, `in_app_review`, `upgrader`, `share_plus`, `device_info_plus`, `location`, `flutter_map`

---

## 🛠️ Getting Started

### 🧾 Prerequisites

- **Flutter SDK ≥ 3.5.2**
- **Dart SDK ≥ 3.5.2**
- Emulator or physical device

### ⚙️ Setup & Run

```bash
flutter clean
flutter pub get
flutter run --flavor dev
# or
flutter run --flavor prod
```

---

## 📦 Building APK / AppBundle / iOS

```bash
flutter clean
flutter pub get

# Android APK
flutter build apk --release --flavor prod

# Android App Bundle
flutter build appbundle --flavor prod

# iOS Release
flutter build ios --release --flavor prod
```

---

## 🧪 Testing

> You can add tests under each `features/xyz/test` or `core/test` directory.

- Run all tests:
```bash
flutter test
```

---

## ✍️ Author

**Mohamed Adawy**

---


