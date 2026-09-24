class RecommendationResult {
  final String cpu;
  final int ram;
  final int storage;
  final String gpu;

  final String cpuReason;
  final String ramReason;
  final String storageReason;
  final String gpuReason;

  RecommendationResult({
    required this.cpu,
    required this.ram,
    required this.storage,
    required this.gpu,
    required this.cpuReason,
    required this.ramReason,
    required this.storageReason,
    required this.gpuReason,
  });
}
