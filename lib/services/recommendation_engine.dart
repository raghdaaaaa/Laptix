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

  static const Map<String, int> budgetLevels = {
    'Under \$800': 1,
    '\$800 - \$1,200': 2,
    '\$1,200 - \$1,800': 3,
    '\$1,800+': 4,
  };

  static int cpuLevel(String cpu) {
    return cpuLevels[cpu] ?? 1;
  }

  static int gpuLevel(String gpu) {
    return gpuLevels[gpu] ?? 1;
  }

  static int budgetLevel(String budget) {
    return budgetLevels[budget] ?? 1;
  }

  static int _requiredBudgetLevel(String cpu, int ram, int storage, String gpu) {
    int level = 1;

    if (cpuLevel(cpu) >= 3) {
      level = 3;
    } else if (cpuLevel(cpu) >= 2 && level < 2) {
      level = 2;
    }

    if (ram >= 32) {
      level = 4;
    } else if (ram >= 16 && level < 3) {
      level = 3;
    } else if (ram > 8 && level < 2) {
      level = 2;
    }

    if (storage >= 1024 && level < 3) {
      level = 3;
    } else if (storage > 256 && level < 2) {
      level = 2;
    }

    if (gpuLevel(gpu) >= 3 && level < 3) {
      level = 3;
    } else if (gpuLevel(gpu) >= 2 && level < 2) {
      level = 2;
    }

    return level;
  }

  RecommendationResult recommend({
    required List<String> usages,
    required String budget,
    String major = '',
  }) {
    var maxCpu = 1;
    var maxRam = 0;
    var maxStorage = 0;
    var maxGpu = 1;

    String cpuReason = '';
    String ramReason = '';
    String storageReason = '';
    String gpuReason = '';

    for (final usage in usages) {
      final requirement = requirements[usage];

      if (requirement == null) {
        continue;
      }

      final cpuLevel = cpuLevels[requirement.cpu]!;
      if (cpuLevel > maxCpu) {
        maxCpu = cpuLevel;
        cpuReason = '$usage requires a ${requirement.cpu}-level CPU.';
      }

      if (requirement.ram > maxRam) {
        maxRam = requirement.ram;
        ramReason = '$usage requires $maxRam GB of RAM.';
      }

      if (requirement.storage > maxStorage) {
        maxStorage = requirement.storage;
        storageReason =
            '$usage requires ${requirement.storage} GB of storage.';
      }

      final gpuLevel = gpuLevels[requirement.gpu]!;
      if (gpuLevel > maxGpu) {
        maxGpu = gpuLevel;
        gpuReason = '$usage requires a ${requirement.gpu} GPU.';
      }
    }

    final cpu = cpuLevels.entries
        .firstWhere((entry) => entry.value == maxCpu)
        .key;

    final gpu = gpuLevels.entries
        .firstWhere((entry) => entry.value == maxGpu)
        .key;

    if (cpuReason.isEmpty) {
      cpuReason = 'A Basic CPU is enough for the selected usages.';
    }

    if (ramReason.isEmpty) {
      ramReason = '8 GB of RAM is enough for the selected usages.';
      maxRam = 8;
    }

    if (storageReason.isEmpty) {
      storageReason =
          '256 GB of storage is enough for the selected usages.';
      maxStorage = 256;
    }

    if (gpuReason.isEmpty) {
      gpuReason =
          'An Integrated GPU is enough for the selected usages.';
    }

    final requiredBudgetLevel = _requiredBudgetLevel(cpu, maxRam, maxStorage, gpu);
    final userBudgetLevel = budgetLevel(budget);

    String? budgetWarning;
    if (userBudgetLevel < requiredBudgetLevel) {
      budgetWarning =
          'Your selected budget ($budget) may be lower than what your usage needs require. '
          'Consider increasing your budget for better performance.';
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