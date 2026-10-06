# 💻 Laptix — Smart Laptop Recommendation & Checker Engine

A lightweight, fully local **Flutter application** designed to help university students make data-driven decisions when buying a laptop. 

Laptix addresses the confusion students face by offering a tailored **Specification Recommendation Engine** based on their academic major, daily usage, and budget — along with a **Laptop Suitability Checker** to evaluate existing devices against student workloads.

> 🔒 **100% Offline & Private:** Runs entirely locally on-device with zero backend dependencies or registration requirements.

---

## 🌟 Key Features

### 1. 🎯 Find My Laptop (3-Step Guided Questionnaire)
Guides students through a smart questionnaire to derive their ideal specs:
1. **Major Selection:** Computer Science, Engineering, Business, Design, Media, or Other.
2. **Daily Usage Selection:** Multi-select across 9 workloads (*Programming, Web Dev, App Dev, Gaming, Graphic Design, Video Editing, AI/ML, 3D/CAD, Study*).
3. **Budget Tier:** Under $800, $800–$1,200, $1,200–$1,800, or $1,800+.
4. **Instant Recommendation Result:** Recommends optimal CPU, RAM, Storage, and GPU with rationale. Includes a **Budget Alert** mechanism if the budget restricts ideal specs, explaining exactly what trade-offs were made.

### 2. 🔍 Laptop Checker
Allows students to evaluate any specific laptop configuration against 10 common workloads:
* **Overall Verdict:** Highly Suitable, Moderately Suitable, or Limited Suitability.
* **Component Specs Status:** Evaluates CPU, RAM, Storage, and GPU as *Perfect*, *Optimal*, or *Good*.
* **Workload Compatibility Breakdown:** Displays supported vs. unsupported use cases.

---

## ⚙️ How the Recommendation Engine Works

The core algorithm dynamically balances major baselines, user workloads, and financial constraints:

$$\text{Final Specs} = \min\Big(\max(\text{Major Minimum}, \text{Usage Requirements}), \text{Budget Cap}\Big)$$

* **Major Minimum:** Defines the functional baseline for each field of study.
* **Usage Requirements:** Evaluates selected workloads and picks the maximum requirement per component.
* **Budget Cap:** Restricts output to realistic market specs per budget tier. If ideal specs exceed the budget, the engine scales down components gracefully and triggers a transparent **Budget Alert**.

> **Example:** A student selecting *Video Editing* with a budget *Under $800* needs *High CPU / 32GB RAM / 1TB SSD / Dedicated GPU*. The engine caps this to *Medium CPU / 16GB RAM / 512GB SSD / Integrated GPU* and highlights the downgrade reasons.

---

## 🏗️ Architecture & Project Structure

The project strictly follows **Clean Architecture principles** by completely separating UI layers from business logic and evaluation rules.

```text
lib/
├── Core/Constants/      # Colors, strings, routes, asset and icon paths
├── data/                # Static requirements tables (usage, major, budget rules)
├── models/              # StudentProfile, RecommendationResult, CheckerResult, SpecStatus
├── screens/             # UI Views (Home, Major, Usage, Budget, Recommendation, Checker)
├── services/            # Pure Dart Logic Engine (RecommendationEngine, LaptopCheckerService)
└── widgets/             # Reusable UI components

test/                    # Comprehensive Unit Tests for evaluation services
Separation of Concerns: Views are strictly passive UI components; all calculations and evaluation algorithms live inside testable services/.

🛠️ Known Limitations & Current Scope
General Spec Guidelines: Recommendations are based on architectural spec tiers rather than real-time live market prices or specific vendor models.

UI/UX Extensions: The bottom navigation provides quick access to Home, Checker, and a central flow restart trigger.

🔮 Future Roadmap
[ ] 🤖 AI-Powered Assistant: Integrate an intelligent conversational AI model to understand natural language student queries and offer personalized laptop advice.

[ ] 🔍 Explore & Catalog Section: Add a dynamic market browser allowing students to filter real-world laptop models by major, budget, condition (New/Used/Outlet), and usage.

[ ] 📦 Advanced State Management: Refactor state handling using Provider or Bloc for scalable flow control.

[ ] 📄 Export Spec Sheets: Enable exporting recommended laptop specs as PDF or Image to save or share easily.

🧪 Running Tests
To run the unit tests for the recommendation engine and laptop checker service:

Bash
flutter test
