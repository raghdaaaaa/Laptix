# Laptix

A Flutter app that recommends laptop specifications for students based on their major, intended usage, and budget. Also includes a "Laptop Checker" feature to verify if specific laptop specs meet your needs.

## Features

- **Questionnaire Flow**: 3-step wizard (Major → Usage → Budget) to collect student preferences
- **Smart Recommendations**: Analyzes usage requirements and recommends optimal CPU, RAM, storage, and GPU specs
- **Budget Awareness**: Warns if selected budget may be insufficient for the required specs
- **Laptop Checker**: Input specific laptop specs to check compatibility against various workloads
- **Fully Local**: No backend, no cloud services required

## How to Run

```bash
flutter pub get
flutter run
```

## Project Structure

- `lib/models/` - Data models (StudentProfile, LaptopRequirements, RecommendationResult)
- `lib/services/` - Business logic (RecommendationEngine)
- `lib/screens/` - UI screens (Home, Major, Usage, Budget, Recommendation, Laptop Checker)
- `lib/widgets/` - Reusable UI components
- `lib/data/` - Static requirement data
- `lib/Core/Constants/` - App-wide constants (colors, strings, icons, routes, assets)