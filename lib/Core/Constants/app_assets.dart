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
  static const String commonStar = '$_iconsPath/common/star.svg'; // Home performance badge (legacy) & expert tip
  static const String commonVerified = '$_iconsPath/common/verified.svg'; // Legacy student life badge
  static const String commonSuitableCheck = '$_iconsPath/common/suitable_check.svg'; // Suitable status indicator
  static const String commonLightningBolt = '$_iconsPath/common/lightning_bolt.svg'; // Home performance badge & checker expert tip decoration
  static const String commonGraduationCap = '$_iconsPath/common/graduation_cap.svg'; // Home student life badge
  static const String commonSparkleWand = '$_iconsPath/common/sparkle_wand.svg'; // Budget show recommendations & checker check button
  static const String commonCheckMark = '$_iconsPath/common/check_mark.svg'; // Result top success badge (plain check)
  static const String commonWandSparkles = '$_iconsPath/common/wand_sparkles.svg'; // Result why-card leading icon

  // ==========================================
  // NAVIGATION ICONS (Bottom Navigation Bar)
  // ==========================================
  static const String navHome = '$_iconsPath/nav/home.svg'; // Bottom Nav: Home tab (inactive)
  static const String navChecker = '$_iconsPath/nav/checker.svg'; // Bottom Nav: Checker tab (inactive)
  static const String navAdd = '$_iconsPath/nav/add.svg'; // Bottom Nav: Center + button
  static const String navHomeActive = '$_iconsPath/nav/home_active.svg'; // Bottom Nav: Home tab (active)
  static const String navCheckerActive = '$_iconsPath/nav/checker_active.svg'; // Bottom Nav: Checker tab (active)
  static const String navExplore = '$_iconsPath/nav/explore.svg'; // Bottom Nav: Explore tab
  static const String navProfile = '$_iconsPath/nav/profile.svg'; // Bottom Nav: Profile tab

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
  static const String majorBusiness = '$_iconsPath/major/business.svg'; // Step 1: Business major card
  static const String majorMedia = '$_iconsPath/major/media.svg'; // Step 1: Media major card (clapperboard)

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
  static const String usageAndroidDev = '$_iconsPath/usage/android_dev.svg'; // Step 2: Android Development card

  // ==========================================
  // STEP 3: BUDGET ICONS
  // ==========================================
  static const String budgetLow = '$_iconsPath/budget/low.svg'; // Step 3: Entry level budget card (was entry)
  static const String budgetMid = '$_iconsPath/budget/mid.svg'; // Step 3: Mid range budget card
  static const String budgetHigh = '$_iconsPath/budget/high.svg'; // Step 3: High end budget card
  static const String budgetPro = '$_iconsPath/budget/pro.svg'; // Step 3: Pro workstation budget card
  static const String budgetWallet = '$_iconsPath/budget/wallet.svg'; // Step 3: Decorative wallet illustration (grey, opacity)

  // ==========================================
  // RECOMMENDATION RESULT ICONS
  // ==========================================
  static const String resultCpu = '$_iconsPath/result/cpu.svg'; // Result: CPU spec card & status row (was processor)
  static const String resultMemory = '$_iconsPath/result/memory.svg'; // Result: RAM spec card & status row
  static const String resultSsd = '$_iconsPath/result/ssd.svg'; // Result: SSD spec card & status row (was storage)
  static const String resultGpu = '$_iconsPath/result/gpu.svg'; // Result: GPU spec card & status row (was graphics)
  static const String resultLaptopCard = '$_iconsPath/result/laptop_card.svg'; // Result: Laptop illustration in card
  static const String resultFadedWand = '$_iconsPath/result/faded_wand.svg'; // Result: Why-card top-right decorative (faded wand)
  // NOTE: resultStatusBadgeHuge (status_badge_huge.svg) is MISSING from disk

  // ==========================================
  // LAPTOP CHECKER ICONS
  // ==========================================
  static const String checkerCpu = '$_iconsPath/checker/cpu.svg'; // Checker: CPU dropdown leading icon (was processor)
  static const String checkerRam = '$_iconsPath/checker/ram.svg'; // Checker: RAM dropdown leading icon (was memory)
  static const String checkerStorage = '$_iconsPath/checker/storage.svg'; // Checker: SSD dropdown leading icon
  static const String checkerGpu = '$_iconsPath/checker/gpu.svg'; // Checker: GPU dropdown leading icon (was graphics)
  static const String checkerTips = '$_iconsPath/checker/tips.svg'; // Checker: Expert tip light-bulb icon (legacy)
  static const String checkerDoubleCheck = '$_iconsPath/checker/double_check.svg'; // Checker: Success verdict badge (double check)
  static const String checkerInfoCircle = '$_iconsPath/checker/info_circle.svg'; // Checker: Expert tip leading icon (info circle)
  static const String checkerFadedLightning = '$_iconsPath/checker/faded_lightning.svg'; // Checker: Expert tip top-right decoration (faded lightning)
  static const String checkerSparkleWandButton = '$_iconsPath/checker/sparkle_wand_button.svg'; // Checker: Check Compatibility button trailing icon
  // NOTE: checkerStatusWarning, checkerBgPattern, checkerInfoDot, checkerResultBadge, checkerSpecIcon are MISSING from disk

  // ==========================================
  // BACKWARD COMPATIBILITY ALIASES (still used)
  // ==========================================
  static String get iconAdd => navAdd;
}