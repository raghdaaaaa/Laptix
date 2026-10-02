class AppAssets {
  AppAssets._();

  static const String _imagesPath = 'assets/images';
  static const String _iconsPath = '$_imagesPath/icons';

  // Images
  static const String laptopHero = '$_imagesPath/laptop_hero.png'; // Welcome Screen hero image

  // ==========================================
  // COMMON ICONS (Used across multiple screens)
  // ==========================================
  static const String commonArrowBack = '$_iconsPath/common/arrow_back.svg'; // Questionnaire & Checker AppBars
  static const String commonArrowForward = '$_iconsPath/common/arrow_forward.svg'; // Continue buttons & action links
  static const String commonChevronLeft = '$_iconsPath/common/chevron_left.svg'; // Back buttons
  static const String commonChevronRight = '$_iconsPath/common/chevron_right.svg'; // Primary button trailing icon
  static const String commonChevronDown = '$_iconsPath/common/chevron_down.svg'; // Dropdown selectors
  static const String commonClose = '$_iconsPath/common/close.svg'; // Step screen header close button
  static const String commonSearch = '$_iconsPath/common/search.svg'; // Find laptop / search action
  static const String commonCheck = '$_iconsPath/common/check.svg'; // Card selection checkmark
  static const String commonCheckCircle = '$_iconsPath/common/check_circle.svg'; // Big result success badge
  static const String commonWarning = '$_iconsPath/common/warning.svg'; // Budget warning & status alert
  static const String commonInfo = '$_iconsPath/common/info.svg'; // Info rows & tips
  static const String commonStar = '$_iconsPath/common/star.svg'; // Home performance badge & expert tip
  static const String commonVerified = '$_iconsPath/common/verified.svg'; // Home student life badge
  static const String commonSuitableCheck = '$_iconsPath/common/suitable_check.svg'; // Suitable status indicator

  // ==========================================
  // NAVIGATION ICONS (Bottom Navigation Bar)
  // ==========================================
  static const String navHome = '$_iconsPath/nav/home.svg'; // Bottom Nav: Home tab (inactive)
  static const String navChecker = '$_iconsPath/nav/checker.svg'; // Bottom Nav: Checker tab (inactive)
  static const String navAdd = '$_iconsPath/nav/add.svg'; // Bottom Nav: Center + button
  // NOTE: Active state icons (home_active, checker_active) are MISSING from disk

  // ==========================================
  // HOME SCREEN ICONS
  // ==========================================
  static const String homeMenu = '$_iconsPath/home/menu.svg'; // Home Screen: Appbar hamburger menu button
  static const String homeHero = '$_iconsPath/home/hero.svg'; // Home Screen: Background hero graphic (was hero_illustration)

  // ==========================================
  // STEP 1: MAJOR ICONS
  // ==========================================
  static const String majorCs = '$_iconsPath/major/cs.svg'; // Step 1: Computer Science major card (was computer_science)
  static const String majorEng = '$_iconsPath/major/eng.svg'; // Step 1: Engineering major card (was engineering)
  static const String majorBis = '$_iconsPath/major/bis.svg'; // Step 1: Business Info Systems major card (replaces business)
  static const String majorDesign = '$_iconsPath/major/design.svg'; // Step 1: Design major card
  static const String majorOther = '$_iconsPath/major/other.svg'; // Step 1: Other major card
  // NOTE: majorBusiness (business.svg) and majorMedia (media.svg) are MISSING from disk

  // ==========================================
  // STEP 2: USAGE ICONS
  // ==========================================
  static const String usageProgramming = '$_iconsPath/usage/programming.svg'; // Step 2: Programming card
  static const String usageWeb = '$_iconsPath/usage/web.svg'; // Step 2: Web Dev card (was web_dev)
  static const String usageApp = '$_iconsPath/usage/app.svg'; // Step 2: App Dev card (replaces android_dev)
  static const String usageGaming = '$_iconsPath/usage/gaming.svg'; // Step 2: Gaming card
  static const String usageGraphic = '$_iconsPath/usage/graphic.svg'; // Step 2: Graphic Design card (was graphic_design)
  static const String usageVideo = '$_iconsPath/usage/video.svg'; // Step 2: Video Editing card (was video_editing)
  static const String usageAi = '$_iconsPath/usage/ai.svg'; // Step 2: AI / ML card (was ai_ml)
  static const String usageCad = '$_iconsPath/usage/cad.svg'; // Step 2: 3D / CAD card (was 3d_cad)
  static const String usageStudy = '$_iconsPath/usage/study.svg'; // Step 2: General Study card
  // NOTE: usageAndroidDev (android_dev.svg) is MISSING from disk

  // ==========================================
  // STEP 3: BUDGET ICONS
  // ==========================================
  static const String budgetLow = '$_iconsPath/budget/low.svg'; // Step 3: Entry level budget card (was entry)
  static const String budgetMid = '$_iconsPath/budget/mid.svg'; // Step 3: Mid range budget card
  static const String budgetHigh = '$_iconsPath/budget/high.svg'; // Step 3: High end budget card
  static const String budgetPro = '$_iconsPath/budget/pro.svg'; // Step 3: Pro workstation budget card

  // ==========================================
  // RECOMMENDATION RESULT ICONS
  // ==========================================
  static const String resultCpu = '$_iconsPath/result/cpu.svg'; // Result: CPU spec card & status row (was processor)
  static const String resultMemory = '$_iconsPath/result/memory.svg'; // Result: RAM spec card & status row
  static const String resultSsd = '$_iconsPath/result/ssd.svg'; // Result: SSD spec card & status row (was storage)
  static const String resultGpu = '$_iconsPath/result/gpu.svg'; // Result: GPU spec card & status row (was graphics)
  // NOTE: resultLaptopCard (laptop_card.svg) and resultStatusBadgeHuge (status_badge_huge.svg) are MISSING from disk

  // ==========================================
  // LAPTOP CHECKER ICONS
  // ==========================================
  static const String checkerCpu = '$_iconsPath/checker/cpu.svg'; // Checker: CPU dropdown leading icon (was processor)
  static const String checkerRam = '$_iconsPath/checker/ram.svg'; // Checker: RAM dropdown leading icon (was memory)
  static const String checkerStorage = '$_iconsPath/checker/storage.svg'; // Checker: SSD dropdown leading icon
  static const String checkerGpu = '$_iconsPath/checker/gpu.svg'; // Checker: GPU dropdown leading icon (was graphics)
  // NOTE: checkerStatusWarning, checkerBgPattern, checkerInfoDot, checkerResultBadge, checkerSpecIcon are MISSING from disk

  // ==========================================
  // BACKWARD COMPATIBILITY ALIASES (still used)
  // ==========================================
  static String get iconAdd => navAdd;
}