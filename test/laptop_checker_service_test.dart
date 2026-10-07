import 'package:flutter_test/flutter_test.dart';
import 'package:laptix/data/requirements_data.dart';
import 'package:laptix/models/checker_result.dart';
import 'package:laptix/models/spec_status.dart';
import 'package:laptix/services/laptop_checker_service.dart';

void main() {
  group('LaptopCheckerService', () {
    late LaptopCheckerService service;

    setUp(() {
      service = LaptopCheckerService();
    });

    test('CPU High / RAM 64 / Storage 256 / GPU Dedicated => limited, 2 suitable (Study, Office / Browsing)', () {
      final result = service.check(
        cpu: 'High',
        ram: 64,
        storage: 256,
        gpu: 'Dedicated',
      );

      expect(result.level, SuitabilityLevel.limited);
      expect(result.matchedUsages, 2);
      expect(result.totalUsages, requirements.length);
      expect(result.suitableFor, contains('Study'));
      expect(result.suitableFor, contains('Office / Browsing'));
      expect(result.suitableFor.length, 2);
    });

    test('CPU High / RAM 64 / Storage 1024 / GPU Dedicated => high, all usages suitable', () {
      final result = service.check(
        cpu: 'High',
        ram: 64,
        storage: 1024,
        gpu: 'Dedicated',
      );

      expect(result.level, SuitabilityLevel.high);
      expect(result.matchedUsages, result.totalUsages);
      expect(result.suitableFor.length, requirements.length);
      expect(result.notSuitableFor, isEmpty);
    });

    test('CPU Basic / RAM 8 / Storage 256 / GPU Integrated => only Study and Office / Browsing suitable', () {
      final result = service.check(
        cpu: 'Basic',
        ram: 8,
        storage: 256,
        gpu: 'Integrated',
      );

      expect(result.level, SuitabilityLevel.limited);
      expect(result.matchedUsages, 2);
      expect(result.suitableFor, contains('Study'));
      expect(result.suitableFor, contains('Office / Browsing'));
    });

    test('Storage matters: Programming needs 512GB, not 256GB', () {
      // With 256GB storage, Programming should NOT be suitable
      final result256 = service.check(
        cpu: 'High',
        ram: 16,
        storage: 256,
        gpu: 'Integrated',
      );

      // With 512GB storage, Programming SHOULD be suitable
      final result512 = service.check(
        cpu: 'High',
        ram: 16,
        storage: 512,
        gpu: 'Integrated',
      );

      expect(result256.suitableFor, isNot(contains('Programming')));
      expect(result512.suitableFor, contains('Programming'));
    });

    test('Moderate case: CPU High / RAM 32 / Storage 512 / GPU Dedicated => moderate, 7 matched', () {
      final result = service.check(
        cpu: 'High',
        ram: 32,
        storage: 512,
        gpu: 'Dedicated',
      );

      expect(result.level, SuitabilityLevel.moderate);
      expect(result.matchedUsages, 7);
      // Video Editing, AI/ML, 3D/CAD should not be suitable (need 1024 storage or 64 RAM)
      expect(result.notSuitableFor, contains('Video Editing'));
      expect(result.notSuitableFor, contains('AI / Machine Learning'));
      expect(result.notSuitableFor, contains('3D / CAD'));
    });

    test(
      'Reasons: RAM/Storage/CPU/GPU thresholds return correct AppStrings',
      () {
        // RAM
        final ram8 = service.check(
          cpu: 'Basic',
          ram: 8,
          storage: 256,
          gpu: 'Integrated',
        );
        expect(
          ram8.ramReason,
          '8 GB of RAM is enough for the selected usages.',
        );

        final ram16 = service.check(
          cpu: 'Basic',
          ram: 16,
          storage: 256,
          gpu: 'Integrated',
        );
        expect(
          ram16.ramReason,
          '16 GB recommended for development and design.',
        );

        final ram32 = service.check(
          cpu: 'Basic',
          ram: 32,
          storage: 256,
          gpu: 'Integrated',
        );
        expect(ram32.ramReason, '32+ GB ideal for video editing, 3D, and AI.');

        // Storage
        final stor256 = service.check(
          cpu: 'Basic',
          ram: 8,
          storage: 256,
          gpu: 'Integrated',
        );
        expect(
          stor256.storageReason,
          '256 GB of storage is enough for the selected usages.',
        );

        final stor512 = service.check(
          cpu: 'Basic',
          ram: 8,
          storage: 512,
          gpu: 'Integrated',
        );
        expect(
          stor512.storageReason,
          '512 GB recommended for development and media.',
        );

        final stor1024 = service.check(
          cpu: 'Basic',
          ram: 8,
          storage: 1024,
          gpu: 'Integrated',
        );
        expect(
          stor1024.storageReason,
          '1 TB+ ideal for video editing, 3D, and large datasets.',
        );

        // CPU
        final cpuBasic = service.check(
          cpu: 'Basic',
          ram: 8,
          storage: 256,
          gpu: 'Integrated',
        );
        expect(
          cpuBasic.cpuReason,
          'A Basic CPU is enough for the selected usages.',
        );

        final cpuMedium = service.check(
          cpu: 'Medium',
          ram: 8,
          storage: 256,
          gpu: 'Integrated',
        );
        expect(
          cpuMedium.cpuReason,
          'Medium CPU suitable for most development tasks.',
        );

        final cpuHigh = service.check(
          cpu: 'High',
          ram: 8,
          storage: 256,
          gpu: 'Integrated',
        );
        expect(
          cpuHigh.cpuReason,
          'High-performance CPU handles all workloads.',
        );

        // GPU
        final gpuIntegrated = service.check(
          cpu: 'Basic',
          ram: 8,
          storage: 256,
          gpu: 'Integrated',
        );
        expect(
          gpuIntegrated.gpuReason,
          'Integrated graphics are enough for the selected usages.',
        );

        final gpuEntry = service.check(
          cpu: 'Basic',
          ram: 8,
          storage: 256,
          gpu: 'Entry-level Dedicated',
        );
        expect(
          gpuEntry.gpuReason,
          'Entry-level Dedicated graphics handles light creative work.',
        );

        final gpuDedicated = service.check(
          cpu: 'Basic',
          ram: 8,
          storage: 256,
          gpu: 'Dedicated',
        );
        expect(
          gpuDedicated.gpuReason,
          'Dedicated graphics required for gaming, 3D, and video editing.',
        );
      },
    );

    test('Status: CPU High and GPU Dedicated are optimal (equal max required), CPU Basic is good', () {
      // CPU High matches max required (High is the max across all requirements)
      // GPU Dedicated matches max required (Dedicated is the max across all requirements)
      // RAM 32 == max required (32) -> optimal
      // Storage 512 < max required (1024) -> good
      final result = service.check(
        cpu: 'High',
        ram: 32,
        storage: 512,
        gpu: 'Dedicated',
      );

      expect(result.cpuStatus, SpecStatus.optimal);
      expect(result.gpuStatus, SpecStatus.optimal);
      expect(result.ramStatus, SpecStatus.optimal); // 32 == max required (32)
      expect(
        result.storageStatus,
        SpecStatus.good,
      ); // 512 < max required (1024)

      // CPU Basic should be good (below max)
      final resultBasic = service.check(
        cpu: 'Basic',
        ram: 8,
        storage: 256,
        gpu: 'Integrated',
      );

      expect(resultBasic.cpuStatus, SpecStatus.good);
      expect(resultBasic.gpuStatus, SpecStatus.good);
    });

    // New tests for updated RAM/Storage status logic (real value comparison)
    test('RAM 64 -> ramStatus perfect (exceeds max 32)', () {
      final result = service.check(
        cpu: 'High',
        ram: 64,
        storage: 1024,
        gpu: 'Dedicated',
      );
      expect(result.ramStatus, SpecStatus.perfect);
    });

    test('RAM 32 -> ramStatus optimal (equals max 32)', () {
      final result = service.check(
        cpu: 'High',
        ram: 32,
        storage: 1024,
        gpu: 'Dedicated',
      );
      expect(result.ramStatus, SpecStatus.optimal);
    });

    test('RAM 16 -> ramStatus good (below max 32)', () {
      final result = service.check(
        cpu: 'High',
        ram: 16,
        storage: 1024,
        gpu: 'Dedicated',
      );
      expect(result.ramStatus, SpecStatus.good);
    });

    test('Storage 1024 -> optimal (equals max)', () {
      final result = service.check(
        cpu: 'High',
        ram: 64,
        storage: 1024,
        gpu: 'Dedicated',
      );
      expect(result.storageStatus, SpecStatus.optimal);
    });

    test('Storage 512 -> good (below max 1024)', () {
      final result = service.check(
        cpu: 'High',
        ram: 64,
        storage: 512,
        gpu: 'Dedicated',
      );
      expect(result.storageStatus, SpecStatus.good);
    });

    test('Storage 256 -> good (below max 1024)', () {
      final result = service.check(
        cpu: 'High',
        ram: 64,
        storage: 256,
        gpu: 'Dedicated',
      );
      expect(result.storageStatus, SpecStatus.good);
    });

    test(
      'CPU High -> optimal (unchanged), GPU Dedicated -> optimal (unchanged)',
      () {
        final result = service.check(
          cpu: 'High',
          ram: 64,
          storage: 1024,
          gpu: 'Dedicated',
        );
        expect(result.cpuStatus, SpecStatus.optimal);
        expect(result.gpuStatus, SpecStatus.optimal);
      },
    );

    test('Cases a/b/e unchanged: limited 2/10, high 10/10, moderate 7/10', () {
      // Case a: limited, 2 suitable
      final a = service.check(
        cpu: 'High',
        ram: 64,
        storage: 256,
        gpu: 'Dedicated',
      );
      expect(a.level, SuitabilityLevel.limited);
      expect(a.matchedUsages, 2);

      // Case b: high, all suitable
      final b = service.check(
        cpu: 'High',
        ram: 64,
        storage: 1024,
        gpu: 'Dedicated',
      );
      expect(b.level, SuitabilityLevel.high);
      expect(b.matchedUsages, b.totalUsages);

      // Case e: moderate, 7 matched
      final e = service.check(
        cpu: 'High',
        ram: 32,
        storage: 512,
        gpu: 'Dedicated',
      );
      expect(e.level, SuitabilityLevel.moderate);
      expect(e.matchedUsages, 7);
    });
  });
}
