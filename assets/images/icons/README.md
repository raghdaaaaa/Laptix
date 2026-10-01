# Icon System Documentation (Laptix)

All icons in this application are direct SVG exports from the Figma design (`LAsaA4Cd5gtyPKypXt9Lvj`). No pre-built icon libraries or framework defaults are used.

## Icon Directory Structure

```
assets/images/icons/
├── common/     # Used across multiple screens (arrows, chevrons, close, search, checks, etc.)
├── nav/        # Bottom navigation bar icons (active and inactive states)
├── home/       # Home screen specific icons (menu, badges)
├── major/      # Step 1: Student major option icons
├── usage/      # Step 2: Laptop usage option icons
├── budget/     # Step 3: Budget tier option icons
├── result/     # Recommendation Result spec cards and status badges
└── checker/    # Laptop Checker dropdowns and compatibility indicators
```

## Icon Reference Table

| Screen | Icon Description | File Path | `AppAssets` Constant | `AppIcons` Method |
|--------|------------------|-----------|----------------------|-------------------|
| **Common** | Arrow Back | `common/arrow_back.svg` | `AppAssets.commonArrowBack` | `AppIcons.arrowBack()` |
| **Common** | Arrow Forward | `common/arrow_forward.svg` | `AppAssets.commonArrowForward` | `AppIcons.arrowForward()` |
| **Common** | Chevron Left | `common/chevron_left.svg` | `AppAssets.commonChevronLeft` | `AppIcons.chevronLeft()` |
| **Common** | Chevron Right | `common/chevron_right.svg` | `AppAssets.commonChevronRight` | `AppIcons.chevronRight()` |
| **Common** | Chevron Down | `common/chevron_down.svg` | `AppAssets.commonChevronDown` | `AppIcons.chevronDown()` |
| **Common** | Close | `common/close.svg` | `AppAssets.commonClose` | `AppIcons.close()` |
| **Common** | Search | `common/search.svg` | `AppAssets.commonSearch` | `AppIcons.search()` |
| **Common** | Checkmark | `common/check.svg` | `AppAssets.commonCheck` | `AppIcons.check()` |
| **Common** | Check Circle | `common/check_circle.svg` | `AppAssets.commonCheckCircle` | `AppIcons.checkCircle()` |
| **Common** | Warning | `common/warning.svg` | `AppAssets.commonWarning` | `AppIcons.warning()` |
| **Common** | Info | `common/info.svg` | `AppAssets.commonInfo` | `AppIcons.info()` |
| **Common** | Star | `common/star.svg` | `AppAssets.commonStar` | `AppIcons.star()` |
| **Common** | Verified | `common/verified.svg` | `AppAssets.commonVerified` | `AppIcons.verified()` |
| **Common** | Suitable Check | `common/suitable_check.svg` | `AppAssets.commonSuitableCheck` | `AppIcons.suitableCheck()` |
| **Nav** | Home (Inactive) | `nav/home.svg` | `AppAssets.navHome` | `AppIcons.navHome()` |
| **Nav** | Home (Active) | `nav/home_active.svg` | `AppAssets.navHomeActive` | `AppIcons.navHomeActive()` |
| **Nav** | Checker (Inactive) | `nav/checker.svg` | `AppAssets.navChecker` | `AppIcons.navChecker()` |
| **Nav** | Checker (Active) | `nav/checker_active.svg` | `AppAssets.navCheckerActive` | `AppIcons.navCheckerActive()` |
| **Nav** | Add Center | `nav/add.svg` | `AppAssets.navAdd` | `AppIcons.navAdd()` |
| **Nav** | Explore (Inactive) | `nav/explore.svg` | `AppAssets.navExplore` | `AppIcons.navExplore()` |
| **Nav** | Explore (Active) | `nav/explore_active.svg` | `AppAssets.navExploreActive` | `AppIcons.navExploreActive()` |
| **Nav** | Profile (Inactive) | `nav/profile.svg` | `AppAssets.navProfile` | `AppIcons.navProfile()` |
| **Nav** | Profile (Active) | `nav/profile_active.svg` | `AppAssets.navProfileActive` | `AppIcons.navProfileActive()` |
| **Home** | Menu | `home/menu.svg` | `AppAssets.homeMenu` | `AppIcons.menu()` |
| **Major** | Computer Science | `major/computer_science.svg` | `AppAssets.majorComputerScience` | `AppIcons.majorComputerScience()` |
| **Major** | Engineering | `major/engineering.svg` | `AppAssets.majorEngineering` | `AppIcons.majorEngineering()` |
| **Major** | Business | `major/business.svg` | `AppAssets.majorBusiness` | `AppIcons.majorBusiness()` |
| **Major** | Design | `major/design.svg` | `AppAssets.majorDesign` | `AppIcons.majorDesign()` |
| **Major** | Media | `major/media.svg` | `AppAssets.majorMedia` | `AppIcons.majorMedia()` |
| **Major** | Other | `major/other.svg` | `AppAssets.majorOther` | `AppIcons.majorOther()` |
| **Usage** | Programming | `usage/programming.svg` | `AppAssets.usageProgramming` | `AppIcons.usageProgramming()` |
| **Usage** | Web Dev | `usage/web_dev.svg` | `AppAssets.usageWebDev` | `AppIcons.usageWebDev()` |
| **Usage** | Android Dev | `usage/android_dev.svg` | `AppAssets.usageAndroidDev` | `AppIcons.usageAndroidDev()` |
| **Usage** | Gaming | `usage/gaming.svg` | `AppAssets.usageGaming` | `AppIcons.usageGaming()` |
| **Usage** | Graphic Design | `usage/graphic_design.svg` | `AppAssets.usageGraphicDesign` | `AppIcons.usageGraphicDesign()` |
| **Usage** | Video Editing | `usage/video_editing.svg` | `AppAssets.usageVideoEditing` | `AppIcons.usageVideoEditing()` |
| **Usage** | AI / ML | `usage/ai_ml.svg` | `AppAssets.usageAIML` | `AppIcons.usageAIML()` |
| **Usage** | 3D / CAD | `usage/3d_cad.svg` | `AppAssets.usage3DCAD` | `AppIcons.usage3DCAD()` |
| **Usage** | General Study | `usage/study.svg` | `AppAssets.usageStudy` | `AppIcons.usageStudy()` |
| **Budget** | Entry Level | `budget/entry.svg` | `AppAssets.budgetEntry` | `AppIcons.budgetEntry()` |
| **Budget** | Mid Range | `budget/mid.svg` | `AppAssets.budgetMid` | `AppIcons.budgetMid()` |
| **Budget** | High End | `budget/high.svg` | `AppAssets.budgetHigh` | `AppIcons.budgetHigh()` |
| **Budget** | Pro Workstation | `budget/pro.svg` | `AppAssets.budgetPro` | `AppIcons.budgetPro()` |
| **Result** | Processor Spec | `result/processor.svg` | `AppAssets.resultProcessor` | `AppIcons.specProcessor()` |
| **Result** | Memory Spec | `result/memory.svg` | `AppAssets.resultMemory` | `AppIcons.specMemory()` |
| **Result** | Storage Spec | `result/storage.svg` | `AppAssets.resultStorage` | `AppIcons.specStorage()` |
| **Result** | Graphics Spec | `result/graphics.svg` | `AppAssets.resultGraphics` | `AppIcons.specGraphics()` |
| **Checker** | Processor Selector | `checker/processor.svg` | `AppAssets.checkerProcessor` | `AppIcons.specProcessor()` |
| **Checker** | Memory Selector | `checker/memory.svg` | `AppAssets.checkerMemory` | `AppIcons.specMemory()` |
| **Checker** | Storage Selector | `checker/storage.svg` | `AppAssets.checkerStorage` | `AppIcons.specStorage()` |
| **Checker** | Graphics Selector | `checker/graphics.svg` | `AppAssets.checkerGraphics` | `AppIcons.specGraphics()` |
