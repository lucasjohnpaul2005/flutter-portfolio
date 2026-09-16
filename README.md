# Flutter Portfolio & State Management

Master compilation app for laboratory activities. Built with Flutter + Provider.

## Getting started

```bash
flutter create . --project-name flutter_portfolio   # only if you need platform folders (android/ios/web)
flutter pub get
flutter run
```

Requires Flutter 3.x (Dart >=3.0). If you generated this folder without
`flutter create`, run that command first inside this directory to add the
platform-specific `android/`, `ios/`, `web/`, etc. folders — this repo only
ships the Dart source (`lib/`) and `pubspec.yaml`.

## Project structure (clean architecture, feature-light layering)

```
lib/
├── main.dart                    # App entry point, Provider + routes + theme
├── models/
│   └── activity_item.dart       # Plain data model (no logic)
├── providers/
│   └── app_state_provider.dart  # GLOBAL state: theme, profile name, progress
├── screens/
│   ├── home_screen.dart         # Dashboard / menu (StatelessWidget, responsive grid)
│   ├── activity_one_screen.dart # StatefulWidget: local counter + favorite toggle
│   ├── activity_two_screen.dart # StatefulWidget: form input example
│   └── settings_screen.dart     # Edits global theme + profile name
└── widgets/
    ├── activity_card.dart       # StatelessWidget: reusable card
    ├── custom_button.dart       # StatelessWidget: reusable button
    └── counter_widget.dart      # StatefulWidget: reusable local counter
```

### Why this split

- **`models/`** — dumb data holders, no Flutter widget code.
- **`providers/`** — the single source of truth for state that more than
  one screen cares about (dark/light theme, profile display name, activity
  completion count). Screens call `context.watch<AppStateProvider>()` to
  rebuild automatically when it changes, and `context.read<...>()` to fire
  one-off actions like `toggleTheme()`.
- **`screens/`** — one file per route/page. Each screen is only
  `StatefulWidget` when it has to be (local text fields, counters, toggles
  that nobody else needs to know about).
- **`widgets/`** — small, reusable, presentation-only pieces shared across
  screens (`StatelessWidget`), separated from screen-local interactive
  pieces (`StatefulWidget`, e.g. `CounterWidget`).

## Requirements checklist

- **Multi-screen navigation** — `MaterialApp.routes` in `main.dart` wires
  up `/home`, `/activity-one`, `/activity-two`, `/settings`; the Home
  Dashboard's grid cards navigate via `Navigator.pushNamed`.
- **Widget architecture** — `ActivityCard` / `CustomButton` are
  `StatelessWidget`; `ActivityOneScreen`, `ActivityTwoScreen`,
  `SettingsScreen`, and `CounterWidget` are `StatefulWidget` for their
  screen-local interactions.
- **Responsive layout** — `HomeScreen` uses `LayoutBuilder` to change the
  `GridView` column count by available width (2 / 3 / 4 columns); other
  screens use `Row` + `Expanded`/`Flexible` so nothing overflows on small
  screens.
- **Global state management** — `AppStateProvider` (via `provider` package)
  holds `themeMode` and `profileName`. Toggling dark mode or saving a new
  name on the Settings screen calls `notifyListeners()`, which instantly
  rebuilds the Home Dashboard's greeting and the app's `MaterialApp` theme
  everywhere, with no manual plumbing.

## Recording your demo

For the deliverable, record a short screen capture that:
1. Resizes/rotates the app (or runs it on two window sizes) to show the
   grid reflowing without overflow.
2. Opens **Settings**, toggles dark mode, and shows the Home Dashboard
   updating immediately.
3. Changes the profile name and shows the greeting on Home updating.
