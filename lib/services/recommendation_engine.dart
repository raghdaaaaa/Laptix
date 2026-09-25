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

  RecommendationResult recommend(List<String> usages) {
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
    }

    if (storageReason.isEmpty) {
      storageReason =
          '256 GB of storage is enough for the selected usages.';
    }

    if (gpuReason.isEmpty) {
      gpuReason =
          'An Integrated GPU is enough for the selected usages.';
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
    );
  }
}