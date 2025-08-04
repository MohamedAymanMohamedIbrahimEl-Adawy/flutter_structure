
# 📦 Flutter Project Architecture

This project follows a modular, scalable, and testable architecture using a combination of **feature-based** and **layered architecture** patterns.

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

## 💬 Need Help?

Feel free to ask for help with refactoring, testing setup, or adding documentation.

