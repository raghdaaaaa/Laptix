import 'dart:math';

import 'package:laptix/Core/Constants/app_strings.dart';
import 'package:laptix/data/requirements_data.dart';
import 'package:laptix/models/checker_result.dart';
import 'package:laptix/models/spec_status.dart';
import 'package:laptix/services/recommendation_engine.dart';

class LaptopCheckerService {
  // This service checks if a laptop's specs meet the requirements for various use cases.
  // Rules:
  // - A usage is suitable if: cpuLevel >= requiredCpuLevel AND ram >= requiredRam
  //   AND storage >= requiredStorage AND gpuLevel >= requiredGpuLevel
  // - Suitability level: high if all usages matched, moderate if >= half matched, limited otherwise.
  // - Reason texts based on selected spec tiers.
  // - Status (perfect/optimal/good):
  //   * CPU/GPU: compare level against max required level
  //   * RAM/Storage: compare actual GB values against max required GB

  CheckerResult check({
    required String cpu,
    required int ram,
    required int storage,
    required String gpu,
  }) {
    int matchedUsages = 0;
    int totalUsages = requirements.length;
    List<String> suitableFor = [];
    List<String> notSuitableFor = [];

    final cpuLevel = RecommendationEngine.cpuLevel(cpu);
    final gpuLevel = RecommendationEngine.gpuLevel(gpu);

    for (final entry in requirements.entries) {
      final usage = entry.key;
      final req = entry.value;

      final cpuOk = cpuLevel >= RecommendationEngine.cpuLevel(req.cpu);
      final ramOk = ram >= req.ram;
      final storageOk = storage >= req.storage;
      final gpuOk = gpuLevel >= RecommendationEngine.gpuLevel(req.gpu);

      if (cpuOk && ramOk && storageOk && gpuOk) {
        matchedUsages++;
        suitableFor.add(usage);
      } else {
        notSuitableFor.add(usage);
      }
    }

    final level = matchedUsages == totalUsages
        ? SuitabilityLevel.high
        : (matchedUsages >= totalUsages ~/ 2
              ? SuitabilityLevel.moderate
              : SuitabilityLevel.limited);

    int maxReqCpu = 1, maxReqRam = 0, maxReqStorage = 0, maxReqGpu = 1;
    for (final entry in requirements.entries) {
      final req = entry.value;
      maxReqCpu = max(maxReqCpu, RecommendationEngine.cpuLevel(req.cpu));
      maxReqRam = max(maxReqRam, req.ram);
      maxReqStorage = max(maxReqStorage, req.storage);
      maxReqGpu = max(maxReqGpu, RecommendationEngine.gpuLevel(req.gpu));
    }

    SpecStatus specStatusFn(int current, int required) {
      if (current > required) return SpecStatus.perfect;
      if (current == required) return SpecStatus.optimal;
      return SpecStatus.good;
    }

    return CheckerResult(
      level: level,
      matchedUsages: matchedUsages,
      totalUsages: totalUsages,
      suitableFor: suitableFor,
      notSuitableFor: notSuitableFor,
      cpuReason: _getCpuReason(cpu),
      ramReason: _getRamReason(ram),
      storageReason: _getStorageReason(storage),
      gpuReason: _getGpuReason(gpu),
      cpuStatus: specStatusFn(cpuLevel, maxReqCpu),
      ramStatus: specStatusFn(ram, maxReqRam),
      storageStatus: specStatusFn(storage, maxReqStorage),
      gpuStatus: specStatusFn(gpuLevel, maxReqGpu),
    );
  }

  String _getCpuReason(String cpu) {
    final level = RecommendationEngine.cpuLevel(cpu);
    if (level >= 3) return AppStrings.cpuReasonHigh;
    if (level >= 2) return AppStrings.cpuReasonMedium;
    return AppStrings.cpuReasonBasic;
  }

  String _getRamReason(int ram) {
    if (ram >= 32) return AppStrings.ramReasonHigh;
    if (ram >= 16) return AppStrings.ramReasonMedium;
    return AppStrings.ramReasonBasic;
  }

  String _getStorageReason(int storage) {
    if (storage >= 1024) return AppStrings.storageReasonHigh;
    if (storage >= 512) return AppStrings.storageReasonMedium;
    return AppStrings.storageReasonBasic;
  }

  String _getGpuReason(String gpu) {
    if (gpu == 'Dedicated') return AppStrings.gpuReasonHigh;
    if (gpu == 'Entry-level Dedicated') return AppStrings.gpuReasonMedium;
    return AppStrings.gpuReasonBasic;
  }
}
