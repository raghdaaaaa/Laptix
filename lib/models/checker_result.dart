import 'package:laptix/models/spec_status.dart';

enum SuitabilityLevel { high, moderate, limited }

class CheckerResult {
  const CheckerResult({
    required this.level,
    required this.matchedUsages,
    required this.totalUsages,
    required this.suitableFor,
    required this.notSuitableFor,
    required this.cpuReason,
    required this.ramReason,
    required this.storageReason,
    required this.gpuReason,
    required this.cpuStatus,
    required this.ramStatus,
    required this.storageStatus,
    required this.gpuStatus,
  });

  final SuitabilityLevel level;
  final int matchedUsages;
  final int totalUsages;
  final List<String> suitableFor;
  final List<String> notSuitableFor;
  final String cpuReason;
  final String ramReason;
  final String storageReason;
  final String gpuReason;
  final SpecStatus cpuStatus;
  final SpecStatus ramStatus;
  final SpecStatus storageStatus;
  final SpecStatus gpuStatus;
}