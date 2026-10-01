import 'dart:io';

void main() {
  final assetsDir = Directory('assets/images/icons');
  final appAssetsPath = 'lib/Core/Constants/app_assets.dart';

  // Read all SVG files on disk
  final filesOnDisk = <String>[];
  void collectFiles(Directory dir, String prefix) {
    for (final entity in dir.listSync()) {
      if (entity is File && entity.path.endsWith('.svg')) {
        // Normalize path first, then extract relative path
        final normalizedPath = entity.path.replaceAll('\\', '/');
        final relPath = normalizedPath.replaceFirst('assets/images/icons/', '');
        filesOnDisk.add(relPath);
      } else if (entity is Directory) {
        collectFiles(entity, '');
      }
    }
  }
  collectFiles(assetsDir, '');

  // Read AppAssets constants - parse line by line
  final lines = File(appAssetsPath).readAsLinesSync();
  final assetConstants = <String, String>{};

  for (final line in lines) {
    final trimmed = line.trim();
    if (trimmed.startsWith('static const String ')) {
      final eqIndex = trimmed.indexOf('=');
      if (eqIndex > 0) {
        final left = trimmed.substring(0, eqIndex).trim();
        final right = trimmed.substring(eqIndex + 1).trim();
        final nameParts = left.split(' ');
        if (nameParts.length >= 4) {
          final name = nameParts[3];
          int startQuote = -1;
          int endQuote = -1;
          if (right.startsWith("'")) {
            startQuote = 0;
            endQuote = right.indexOf("'", 1);
          } else if (right.startsWith('"')) {
            startQuote = 0;
            endQuote = right.indexOf('"', 1);
          }
          if (startQuote >= 0 && endQuote > startQuote) {
            final path = right.substring(startQuote + 1, endQuote);
            assetConstants[name] = path;
          }
        }
      }
    }
  }

  // Resolve $_iconsPath and $_imagesPath to actual paths
  final resolvedConstants = <String, String>{};
  for (final entry in assetConstants.entries) {
    String resolvedPath = entry.value;
    resolvedPath = resolvedPath.replaceAll(r'$_iconsPath', 'assets/images/icons');
    resolvedPath = resolvedPath.replaceAll(r'$_imagesPath', 'assets/images');
    resolvedConstants[entry.key] = resolvedPath;
  }

  // Filter only icon paths (under icons/)
  final iconConstants = resolvedConstants.entries
      .where((e) => e.value.contains('/icons/'))
      .toList();

  print('=== VERIFICATION REPORT ===\n');

  // Check 1: Every AppAssets icon path exists on disk
  print('1. AppAssets constants -> File existence:');
  var missingCount = 0;
  for (final entry in iconConstants) {
    final relPath = entry.value.replaceFirst('assets/images/icons/', '');
    final exists = filesOnDisk.contains(relPath);
    final status = exists ? 'OK' : 'MISSING';
    if (!exists) missingCount++;
    print('  [$status] ${entry.key} -> $relPath');
  }
  print('  Missing files: $missingCount\n');

  // Check 2: Every file on disk is referenced
  print('2. Files on disk -> Referenced in AppAssets:');
  var orphanCount = 0;
  final referencedFiles = iconConstants
      .map((e) => e.value.replaceFirst('assets/images/icons/', ''))
      .toSet();
  for (final file in filesOnDisk) {
    final isReferenced = referencedFiles.contains(file);
    final status = isReferenced ? 'OK' : 'ORPHAN';
    if (!isReferenced) orphanCount++;
    print('  [$status] $file');
  }
  print('  Orphan files: $orphanCount\n');

  // Check 3: Missing icons (design needs but no file)
  print('3. KNOWN MISSING ICONS (design needs, no file on disk):');
  final missingIcons = [
    'nav/home_active.svg',
    'nav/checker_active.svg',
    'nav/explore_active.svg',
    'nav/profile_active.svg',
    'major/business.svg',
    'major/media.svg',
    'usage/android_dev.svg',
    'result/laptop_card.svg',
    'result/status_badge_huge.svg',
    'checker/status_warning.svg',
    'checker/bg_pattern.svg',
    'checker/info_dot.svg',
    'checker/result_badge.svg',
    'checker/spec_icon.svg',
  ];
  for (final m in missingIcons) {
    print('  [MISSING] $m');
  }
  print('');

  // Summary
  print('=== SUMMARY ===');
  print('Total files on disk: ${filesOnDisk.length}');
  print('Total AppAssets icon constants: ${iconConstants.length}');
  print('Missing files (referenced but not on disk): $missingCount');
  print('Orphan files (on disk but not referenced): $orphanCount');
  print('Known missing icons (design needs): ${missingIcons.length}');
}