# Laptix

**Find the right laptop for your studies, or check whether the one you have is good enough.**

Laptix is a Flutter app for students who don't know what specs they actually need. Pick your major, what you'll use the laptop for, and your budget. Laptix recommends CPU, RAM, storage and GPU, explains each choice, and tells you honestly when your budget can't cover the ideal specs. Already have a laptop in mind? The Checker tells you which study and work tasks it can handle.

Everything runs offline on the device. There is no backend, no account and no tracking.

## Screenshots

<p align="center">
  <img src="docs/screenshots/01-home.png" width="150" alt="Home" />
  <img src="docs/screenshots/02-major.png" width="150" alt="Major" />
  <img src="docs/screenshots/03-usage.png" width="150" alt="Usage" />
  <img src="docs/screenshots/04-budget.png" width="150" alt="Budget" />
  <img src="docs/screenshots/05-result.png" width="150" alt="Result" />
  <img src="docs/screenshots/06-checker.png" width="150" alt="Checker" />
</p>

## Features

**Find My Laptop** is a three-step questionnaire (major, usage, budget) that produces recommended CPU, RAM, storage and GPU specs. Each spec comes with a reason. A Budget Alert appears when the chosen budget forces specs below the ideal level, listing which components were lowered and what the ideal would have been. Usage is multi-select, major is single-select.

**Laptop Checker** takes a laptop's CPU, RAM, storage and GPU and returns a verdict (Highly Suitable, Moderately Suitable, Limited Suitability), a per-spec status (Perfect, Optimal, Good), and lists of suitable and not suitable use cases.

## How the recommendation works

```
final = min( max(major minimum, usage requirements), budget cap )
```

1. Start from the major's minimum requirements.
2. Raise each spec to the maximum required by the selected usages.
3. Apply the budget cap. If the budget tier can't afford the ideal specs, lower the affected components and show a Budget Alert.

**Worked example** (Video Editing + Under $800):
- Ideal from usage: High CPU, 32 GB RAM, 1 TB storage, Dedicated GPU
- Budget cap: Medium CPU, 16 GB RAM, 512 GB storage, Integrated GPU
- Result: Medium / 16 GB / 512 GB / Integrated, with a Budget Alert listing CPU, RAM, Storage and GPU as lowered.

The requirement tables live in `lib/data/requirements_data.dart`.

## How the checker works

A laptop is suitable for a usage only if all four specs meet or exceed that usage's requirements.

| Verdict | Rule |
|---|---|
| Highly Suitable | all selected usages are suitable |
| Moderately Suitable | at least half are suitable |
| Limited Suitability | fewer than half are suitable |

Per-spec status compares each spec to the highest requirement among all usages: **Perfect** exceeds it, **Optimal** equals it, **Good** is below it.

## Tech

- Flutter / Dart, Material 3
- `flutter_svg` for icons
- Pure-Dart logic in `lib/services/`, covered by unit and widget tests
- Designed in Figma, implemented to match

## Project structure

```
lib/
  Core/Constants/   # colors, strings, assets, icons, routes
  data/             # requirement tables
  models/           # StudentProfile, RecommendationResult, CheckerResult...
  screens/          # Home, Major, Usage, Budget, Recommendation, LaptopChecker
  services/         # RecommendationEngine, LaptopCheckerService
  widgets/          # reusable UI components
test/               # unit and widget tests
```

## Run and test

```bash
flutter pub get
flutter run
flutter analyze
flutter test
flutter build apk --release
```

A prebuilt APK is available on the Releases page.

## Limitations

- Recommendations follow general spec guidelines, not live prices or specific laptop models.
- "Office / Browsing" is evaluated by the Checker but is not a questionnaire option.

## Roadmap

- Saving and sharing results
- A browsable catalog of example laptops
