import '../data/requirements_data.dart';
import '../models/recommendation_result.dart';

class RecommendationEngine {
  static const Map<String, int> cpuLevels = {
    'Basic': 1,
    'Medium': 2,
    'High': 3,
  };

  static const Map<String, int> gpuLevels = {
    'Integrated': 1,
    'Entry-level Dedicated': 2,
    'Dedicated': 3,
  };

  static int cpuLevel(String cpu) {
    return cpuLevels[cpu] ?? 1;
  }

  static int gpuLevel(String gpu) {
    return gpuLevels[gpu] ?? 1;
  }

  RecommendationResult recommend({
    required List<String> usages,
    required String budget,
    String major = '',
  }) {
    // Algorithm: final = min( max(major minimum, usage requirements), budget cap )

    // Step 1 — Start from the major minimum.
    var maxCpu = 1;
    var maxRam = 8;
    var maxStorage = 256;
    var maxGpu = 1;

    String cpuReason = '';
    String ramReason = '';
    String storageReason = '';
    String gpuReason = '';

    final majorReq = majorMinimums[major];
    if (majorReq != null) {
      maxCpu = cpuLevels[majorReq.cpu]!;
      maxRam = majorReq.ram;
      maxStorage = majorReq.storage;
      maxGpu = gpuLevels[majorReq.gpu]!;
      cpuReason = '$major students need at least a ${majorReq.cpu}-level CPU.';
      ramReason = '$major students need at least ${majorReq.ram} GB of RAM.';
      storageReason = '$major students need at least ${majorReq.storage} GB of storage.';
      gpuReason = '$major students need at least a ${majorReq.gpu} GPU.';
    }

    // Step 2 — Raise with usages.
    for (final usage in usages) {
      final requirement = requirements[usage];

      if (requirement == null) {
        continue;
      }

      final usageCpuLevel = cpuLevels[requirement.cpu]!;
      if (usageCpuLevel > maxCpu) {
        maxCpu = usageCpuLevel;
        cpuReason = '$usage requires a ${requirement.cpu}-level CPU.';
      }

      if (requirement.ram > maxRam) {
        maxRam = requirement.ram;
        ramReason = '$usage requires $maxRam GB of RAM.';
      }

      if (requirement.storage > maxStorage) {
        maxStorage = requirement.storage;
        storageReason = '$usage requires ${requirement.storage} GB of storage.';
      }

      final usageGpuLevel = gpuLevels[requirement.gpu]!;
      if (usageGpuLevel > maxGpu) {
        maxGpu = usageGpuLevel;
        gpuReason = '$usage requires a ${requirement.gpu} GPU.';
      }
    }

    // Step 3 — This result is the IDEAL specs.
    final idealCpu = maxCpu;
    final idealRam = maxRam;
    final idealStorage = maxStorage;
    final idealGpu = maxGpu;
    final idealCpuStr = cpuLevels.entries.firstWhere((e) => e.value == idealCpu).key;
    final idealGpuStr = gpuLevels.entries.firstWhere((e) => e.value == idealGpu).key;

    // Step 4 — Apply the budget cap.
    final budgetCap = budgetCaps[budget];
    var lowered = <String>[];
    if (budgetCap != null) {
      final capCpu = cpuLevels[budgetCap.cpu]!;
      if (capCpu < maxCpu) {
        maxCpu = capCpu;
        lowered.add('CPU');
      }
      if (budgetCap.ram < maxRam) {
        maxRam = budgetCap.ram;
        lowered.add('RAM');
      }
      if (budgetCap.storage < maxStorage) {
        maxStorage = budgetCap.storage;
        lowered.add('Storage');
      }
      final capGpu = gpuLevels[budgetCap.gpu]!;
      if (capGpu < maxGpu) {
        maxGpu = capGpu;
        lowered.add('GPU');
      }
    }

    final cpu = cpuLevels.entries.firstWhere((entry) => entry.value == maxCpu).key;
    final gpu = gpuLevels.entries.firstWhere((entry) => entry.value == maxGpu).key;

    // Step 5 — Budget note.
    String? budgetWarning;
    if (lowered.isNotEmpty) {
      budgetWarning =
          'Your budget ($budget) is below what ${usages.isNotEmpty ? usages.join(', ') : major} need. '
          'Lowered: ${lowered.join(', ')}. Ideal: $idealCpuStr CPU, ${idealRam}GB RAM, ${idealStorage}GB Storage, $idealGpuStr GPU.';
    }

    // If reasons were lowered, update them to reflect budget limitation
    if (lowered.contains('CPU')) {
      cpuReason = 'Limited by your budget ($budget). Ideal: $idealCpuStr CPU.';
    }
    if (lowered.contains('RAM')) {
      ramReason = 'Limited by your budget ($budget). Ideal: ${idealRam}GB RAM.';
    }
    if (lowered.contains('Storage')) {
      storageReason = 'Limited by your budget ($budget). Ideal: ${idealStorage}GB Storage.';
    }
    if (lowered.contains('GPU')) {
      gpuReason = 'Limited by your budget ($budget). Ideal: $idealGpuStr GPU.';
    }

    // Set default reasons if still empty
    if (cpuReason.isEmpty) {
      cpuReason = 'A Basic CPU is enough for the selected usages.';
    }
    if (ramReason.isEmpty) {
      ramReason = '8 GB of RAM is enough for the selected usages.';
    }
    if (storageReason.isEmpty) {
      storageReason = '256 GB of storage is enough for the selected usages.';
    }
    if (gpuReason.isEmpty) {
      gpuReason = 'An Integrated GPU is enough for the selected usages.';
    }

    return RecommendationResult(
      cpu: cpu,
      ram: maxRam,
      storage: maxStorage,
      gpu: gpu,
      cpuReason: cpuReason,
      ramReason: ramReason,
      storageReason: storageReason,
      gpuReason: gpuReason,
      budgetWarning: budgetWarning,
    );
  }
}