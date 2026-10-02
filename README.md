Laptix

A Flutter app that helps students choose the right laptop specs for their major, their daily usage, and their budget. It also includes a Laptop Checker that tells a student whether a specific laptop is good enough for common student workloads.

Everything runs locally. There is no backend and no account.

Features
1. Find My Laptop (3-step questionnaire)

Home → Major → Usage → Budget → Recommendation

Major: Computer Science, Engineering, Business, Design, Media, Other (single choice)
Usage: 9 options, select all that apply (Programming, Web Development, App Development, Gaming, Graphic Design, Video Editing, AI / ML, 3D / CAD, Study)
Budget: Under $800, $800 - $1,200, $1,200 - $1,800, $1,800+
Result: recommended CPU, RAM, storage, and GPU, with a short reason for each. If the budget is too low for the ideal specs, the app shows the best specs the budget allows and a "Budget Alert" that says what was lowered.
2. Laptop Checker

The student enters CPU, RAM, storage, and GPU. The app shows:

an overall verdict (Highly / Moderately / Limited Suitability)
a status for each spec (Perfect / Optimal / Good)
which usages the laptop is suitable for, and which it is not
How the recommendation works
final specs = min( max(major minimum, usage requirements), budget cap )
Major minimum: each major has a baseline (for example Business needs less than Design).
Usage requirements: for every selected usage, take the highest requirement per component (CPU, RAM, storage, GPU).
Budget cap: each budget has a maximum realistic spec. If the result is above the cap, it is lowered to the cap and the student is told what was lowered.

Example: Video Editing with a budget under $800 → ideal is High CPU / 32 GB / 1 TB / Dedicated GPU, but the budget cap gives Medium CPU / 16 GB / 512 GB / Integrated GPU, with a Budget Alert.

The data tables are in lib/data/requirements_data.dart. The logic is in lib/services/recommendation_engine.dart.

How the Laptop Checker works

A laptop is "suitable" for a usage only if all four specs (CPU, RAM, storage, GPU) meet that usage's requirements. The verdict depends on how many of the 10 use cases are supported: all = Highly Suitable, at least half = Moderately Suitable, otherwise Limited Suitability. The logic is in lib/services/laptop_checker_service.dart.

Project structure
lib/
├── Core/Constants/   colors, strings, routes, asset and icon paths
├── data/             requirements tables (usage, major, budget)
├── models/           StudentProfile, RecommendationResult, CheckerResult, SpecStatus, ...
├── screens/          Home, Major, Usage, Budget, Recommendation, Laptop Checker
├── services/         RecommendationEngine, LaptopCheckerService (all the logic)
└── widgets/          reusable UI pieces
test/                 unit tests for both services

Screens only show UI. All calculation lives in services/.

 
Known limits
The recommendation is based on general guidelines, not on live prices or specific laptop models.
The "Office / Browsing" usage is evaluated by the Laptop Checker, but is not an option in the questionnaire.
The bottom navigation has three items (Home, Checker, and a center button that restarts the questionnaire).