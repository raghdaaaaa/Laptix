# Laptix

Laptix is a student laptop recommendation app and a laptop compatibility checker.

## Screenshots

| Home | Major | Usage | Budget | Result | Checker |
|------|-------|-------|--------|--------|---------|
| ![Home](docs/screenshots/01-home.png) | ![Major](docs/screenshots/02-major.png) | ![Usage](docs/screenshots/03-usage.png) | ![Budget](docs/screenshots/04-budget.png) | ![Result](docs/screenshots/05-result.png) | ![Checker](docs/screenshots/06-checker.png) |

## Features

**Find My Laptop** — A three-step questionnaire (major, usage, budget) produces recommended CPU, RAM, storage, and GPU specs. Each spec includes a reason. A Budget Alert appears when the selected budget forces specs below the ideal level, listing which components were lowered and what the ideal specs would have been.

**Laptop Checker** — Enter a laptop's CPU, RAM, storage, and GPU to get a verdict (Highly Suitable, Moderately Suitable, Limited Suitability), per-spec status (Perfect, Optimal, Good), and lists of suitable and not suitable use cases.

## How the recommendation works

The engine computes the final specs with this formula:

```
final = min( max(major minimum, usage requirements), budget cap )
```

Three steps:

1. Start from the major's minimum requirements (if a major is selected).
2. Raise each spec to the maximum required by the selected usages.
3. Apply the budget cap: if the budget tier cannot afford the ideal specs, lower the affected components and show a Budget Alert.

**Worked example** — Video Editing + Under $800:
- Ideal (from usage): High CPU, 32 GB RAM, 1 TB Storage, Dedicated GPU
- Budget cap (Under $800): Medium CPU, 16 GB RAM, 512 GB Storage, Integrated GPU
- Result: Medium / 16 GB / 512 GB / Integrated, with a Budget Alert listing CPU, RAM, Storage, GPU as lowered.

The requirement tables live in `lib/data/requirements_data.dart`.

## How the checker works

A laptop is suitable for a usage only if all four of its specs meet or exceed that usage's requirements.

**Verdict thresholds:**
- Highly Suitable: all selected usages are suitable
- Moderately Suitable: at least half of usages are suitable
- Limited Suitability: fewer than half are suitable

**Per-spec status (Perfect / Optimal / Good)** compares each spec against the highest requirement among all selected usages:
- Perfect: exceeds the maximum required
- Optimal: equals the maximum required
- Good: below the maximum required

## Project structure

```
lib/
  Core/Constants/   # App colors, strings, assets, icons, routes
  data/             # Requirement tables (requirements_data.dart)
  models/           # Data classes (StudentProfile, RecommendationResult, CheckerResult, etc.)
  screens/          # UI screens (Home, Major, Usage, Budget, Recommendation, LaptopChecker)
  services/         # Calculation logic (RecommendationEngine, LaptopCheckerService)
  widgets/          # Reusable UI components
test/               # Unit and widget tests
```

Calculations live in `lib/services/`.

## Run and test

```bash
flutter pub get
flutter run
flutter analyze
flutter test
flutter build apk --release
```

## Limitations

- Recommendations follow general spec guidelines, not live prices or specific laptop models.
- Example prices are not shown in the app.
- "Office / Browsing" is evaluated by the Checker but is not a questionnaire option.
- The bottom navigation has Home, Checker, and a center restart button.

## Roadmap

- Saving and sharing results
- A browsable catalog of example laptops