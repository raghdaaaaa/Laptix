import 'package:flutter_test/flutter_test.dart';
import 'package:laptix/services/recommendation_engine.dart';

void main() {
  group('RecommendationEngine', () {
    late RecommendationEngine engine;

    setUp(() {
      engine = RecommendationEngine();
    });

    test('recommend returns correct defaults for empty usage list', () {
      final result = engine.recommend(
        usages: [],
        budget: 'Under \$800',
      );

      expect(result.cpu, 'Basic');
      expect(result.ram, 8);
      expect(result.storage, 256);
      expect(result.gpu, 'Integrated');
      expect(result.cpuReason, 'A Basic CPU is enough for the selected usages.');
      expect(result.ramReason, '8 GB of RAM is enough for the selected usages.');
      expect(result.storageReason, '256 GB of storage is enough for the selected usages.');
      expect(result.gpuReason, 'An Integrated GPU is enough for the selected usages.');
    });

    test('recommend returns correct max CPU for Study only', () {
      final result = engine.recommend(
        usages: ['Study'],
        budget: 'Under \$800',
      );

      expect(result.cpu, 'Basic');
      expect(result.ram, 8);
      expect(result.storage, 256);
      expect(result.gpu, 'Integrated');
    });

    test('recommend returns correct max CPU for Programming', () {
      final result = engine.recommend(
        usages: ['Programming'],
        budget: 'Under \$800',
      );

      expect(result.cpu, 'Medium');
      expect(result.ram, 16);
      expect(result.storage, 512);
      expect(result.gpu, 'Integrated');
    });

    test('recommend returns correct max for Android Development', () {
      final result = engine.recommend(
        usages: ['Android Development'],
        budget: '\$800 - \$1,200',
      );

      expect(result.cpu, 'High');
      expect(result.ram, 16);
      expect(result.storage, 512);
      expect(result.gpu, 'Integrated');
    });

    test('recommend returns correct max for Graphic Design', () {
      final result = engine.recommend(
        usages: ['Graphic Design'],
        budget: '\$1,200 - \$1,800',
      );

      expect(result.cpu, 'Medium');
      expect(result.ram, 16);
      expect(result.storage, 512);
      expect(result.gpu, 'Entry-level Dedicated');
    });

    test('recommend returns correct max for Video Editing', () {
      final result = engine.recommend(
        usages: ['Video Editing'],
        budget: '\$1,800+',
      );

      expect(result.cpu, 'High');
      expect(result.ram, 32);
      expect(result.storage, 1024);
      expect(result.gpu, 'Dedicated');
    });

    test('recommend returns correct max for Gaming', () {
      final result = engine.recommend(
        usages: ['Gaming'],
        budget: '\$1,200 - \$1,800',
      );

      expect(result.cpu, 'High');
      expect(result.ram, 16);
      expect(result.storage, 512);
      expect(result.gpu, 'Dedicated');
    });

    test('recommend returns correct max for 3D / CAD', () {
      final result = engine.recommend(
        usages: ['3D / CAD'],
        budget: '\$1,800+',
      );

      expect(result.cpu, 'High');
      expect(result.ram, 32);
      expect(result.storage, 1024);
      expect(result.gpu, 'Dedicated');
    });

    test('recommend takes maximum across multiple usages', () {
      final result = engine.recommend(
        usages: ['Study', 'Video Editing', 'Gaming'],
        budget: '\$1,800+',
      );

      expect(result.cpu, 'High');
      expect(result.ram, 32);
      expect(result.storage, 1024);
      expect(result.gpu, 'Dedicated');
    });

    test('recommend takes maximum RAM across usages', () {
      final result = engine.recommend(
        usages: ['Programming', 'Video Editing'],
        budget: '\$1,800+',
      );

      expect(result.ram, 32);
    });

    test('recommend takes maximum storage across usages', () {
      final result = engine.recommend(
        usages: ['Programming', 'Video Editing'],
        budget: '\$1,800+',
      );

      expect(result.storage, 1024);
    });

    test('recommend takes maximum GPU across usages', () {
      final result = engine.recommend(
        usages: ['Graphic Design', 'Video Editing'],
        budget: '\$1,800+',
      );

      expect(result.gpu, 'Dedicated');
    });

    test('recommend shows budget warning when budget is too low for needs', () {
      final result = engine.recommend(
        usages: ['Video Editing'],
        budget: 'Under \$800',
      );

      expect(result.budgetWarning, isNotNull);
      expect(result.budgetWarning, contains('Under \$800'));
      expect(result.budgetWarning, contains('lower than what your usage needs require'));
    });

    test('recommend shows no budget warning when budget matches needs', () {
      final result = engine.recommend(
        usages: ['Video Editing'],
        budget: '\$1,800+',
      );

      expect(result.budgetWarning, isNull);
    });

    test('recommend shows no budget warning for basic needs with low budget', () {
      final result = engine.recommend(
        usages: ['Study'],
        budget: 'Under \$800',
      );

      expect(result.budgetWarning, isNull);
    });

    test('recommend shows budget warning for Gaming with mid-range budget', () {
      final result = engine.recommend(
        usages: ['Gaming'],
        budget: '\$800 - \$1,200',
      );

      expect(result.budgetWarning, isNotNull);
    });

    test('recommend shows budget warning for 3D/CAD with mid-range budget', () {
      final result = engine.recommend(
        usages: ['3D / CAD'],
        budget: '\$1,200 - \$1,800',
      );

      expect(result.budgetWarning, isNotNull);
    });
  });
}