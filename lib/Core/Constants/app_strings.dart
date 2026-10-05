class AppStrings {
  AppStrings._();

  // App General
  static const String appName = 'Laptix';
  static const String logoLetter = 'L';

  // Welcome Screen
  static const String welcomeTitle = 'Find the right\nlaptop for\nyour needs.';
  static const String welcomeSubtitle = 'Personalized laptop\nrecommendations based on your\nmajor, usage, and budget.';

  // Questionnaire Common
  static const String btnShowRecommendations = 'Show Recommendations';

  // Step 1: Major
  static const String step1Title = 'What\'s your\nmajor?';
  static const String step1Subtitle = 'Select your field of study to help us\nunderstand your daily software needs.';
  static const String majorComputerScience = 'Computer Science';
  static const String majorEngineering = 'Engineering';
  static const String majorBusiness = 'Business';
  static const String majorDesign = 'Design';
  static const String majorMedia = 'Media';
  static const String majorOther = 'Other';

  // Step 2: Usage
  static const String step2Title = 'What will you use your\nlaptop for?';
  static const String step2Subtitle = 'Select all that apply.';
  static const String usageAndroidDev = 'Android Development';
  static const String usageGaming = 'Gaming';
  static const String usageGraphicDesign = 'Graphic Design';
  static const String usageVideoEditing = 'Video Editing';
  static const String usage3DCAD = '3D / CAD';
  static const String usageStudy = 'Study';
  static const String usageProgramming = 'Programming';
  static const String usageWebDev = 'Web Development';
  static const String usageAIML = 'AI / Machine Learning';

  // Step 3: Budget
  static const String step3Title = 'What\'s your\nbudget?';
  static const String step3Subtitle = 'We\'ll find the best performance for your\nprice range.';

  static const String budgetEntryLevelTitle = 'Entry Level';
  static const String budgetEntryLevelValue = 'Under \$800';

  static const String budgetMidRangeTitle = 'Mid-Range';
  static const String budgetMidRangeValue = '\$800 - \$1,200';
  static const String budgetMidRangeBadge = 'Most Popular';

  static const String budgetHighEndTitle = 'High-End';
  static const String budgetHighEndValue = '\$1,200 - \$1,800';

  static const String budgetProTitle = 'Pro Performance';
  static const String budgetProValue = '\$1,800+';

  // Recommendation Result
  static const String recResultSubtitle = 'We\'ve analyzed your needs and found\nyour ideal specs.';
  static const String recResultRecommendedSpecs = 'Recommended Specs';
  static const String specProcessor = 'Processor';
  static const String specMemory = 'Memory';
  static const String specStorage = 'Storage';
  static const String specGraphics = 'Graphics';

  // Navigation / Common Actions
  static const String navHome = 'Home';
  static const String navChecker = 'Checker';
  static const String btnCheckLaptop = 'Check a Laptop';

  // Laptop Checker
  static const String checkerLabelProcessor = 'Processor (CPU)';
  static const String checkerLabelMemory = 'Memory (RAM)';
  static const String checkerLabelGraphics = 'Graphics (GPU)';
  static const String checkerBtnCheck = 'Check Compatibility';
  static const String checkerAnalysisResult = 'Analysis Result';
  static const String checkerCalculationComplete = 'CALCULATION COMPLETE';
  static const String checkerHighlySuitable = 'Highly Suitable';
  static const String checkerTitle = 'Check a Laptop';
  static const String checkerSpecsHeader = 'Specifications';
  static const String checkerSuitableFor = 'Suitable for';
  static const String checkerNotSuitableFor = 'Not suitable for';

  // Home Screen
  static const String homeFindMyLaptop = 'Find My Laptop';

  // Budget warning
  static const String budgetWarningTitle = 'Budget Alert';

  // Status texts
  static const String statusModeratelySuitable = 'Moderately Suitable';
  static const String statusLimitedSuitability = 'Limited Suitability';

  // Spec reasons (defaults)
  static const String cpuReasonBasic = 'A Basic CPU is enough for the selected usages.';
  static const String cpuReasonMedium = 'Medium CPU suitable for most development tasks.';
  static const String cpuReasonHigh = 'High-performance CPU handles all workloads.';
  static const String ramReasonBasic = '8 GB of RAM is enough for the selected usages.';
  static const String ramReasonMedium = '16 GB recommended for development and design.';
  static const String ramReasonHigh = '32+ GB ideal for video editing, 3D, and AI.';
  static const String storageReasonBasic = '256 GB of storage is enough for the selected usages.';
  static const String storageReasonMedium = '512 GB recommended for development and media.';
  static const String storageReasonHigh = '1 TB+ ideal for video editing, 3D, and large datasets.';
  static const String gpuReasonBasic = 'Integrated graphics only for basic tasks.';
  static const String gpuReasonMedium = 'Entry-level GPU handles light creative work.';
  static const String gpuReasonHigh = 'Dedicated GPU required for gaming, 3D, and video editing.';
}