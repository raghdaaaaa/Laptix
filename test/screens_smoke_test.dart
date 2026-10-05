import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:laptix/screens/home_screen.dart';
import 'package:laptix/screens/major_screen.dart';
import 'package:laptix/screens/usage_screen.dart';
import 'package:laptix/screens/budget_screen.dart';
import 'package:laptix/screens/recommendation_screen.dart';
import 'package:laptix/screens/laptop_checker_screen.dart';
import 'package:laptix/widgets/bottom_nav_bar.dart';
import 'package:laptix/widgets/primary_button.dart';
import 'package:laptix/models/student_profile.dart';

void main() {
  const Size testSize = Size(390, 844);

  Widget buildTestApp(Widget child) {
    return MaterialApp(
      home: MediaQuery(
        data: MediaQueryData(size: testSize, textScaler: TextScaler.linear(1.0)),
        child: child,
      ),
    );
  }

  StudentProfile createTestProfile() {
    return StudentProfile(
      major: 'Computer Science',
      usages: ['Programming', 'Study'],
      budget: '\$1,200 - \$1,800',
    );
  }

  testWidgets('Home screen renders without errors, nav at bottom', (tester) async {
    await tester.pumpWidget(buildTestApp(const HomeScreen()));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    // Check nav bar exists
    final navFinder = find.byType(CustomBottomNavBar);
    expect(navFinder, findsOneWidget);
    // Check body has visible content
    expect(find.textContaining('Find the right'), findsOneWidget);
  });

  testWidgets('Major screen renders without errors (questionnaire, no bottom nav)', (tester) async {
    await tester.pumpWidget(buildTestApp(const MajorScreen()));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    // Questionnaire screens don't have bottom nav
    expect(find.byType(CustomBottomNavBar), findsNothing);
    expect(find.textContaining('major'), findsOneWidget);
  });

  testWidgets('Usage screen renders without errors (questionnaire, no bottom nav)', (tester) async {
    final profile = StudentProfile(major: 'Computer Science', usages: [], budget: '');
    await tester.pumpWidget(buildTestApp(UsageScreen(profile: profile)));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.byType(CustomBottomNavBar), findsNothing);
    expect(find.textContaining('laptop for'), findsOneWidget);
  });

  testWidgets('Budget screen renders without errors, single button at bottom', (tester) async {
    final profile = StudentProfile(major: 'Computer Science', usages: ['Programming'], budget: '');
    await tester.pumpWidget(buildTestApp(BudgetScreen(profile: profile)));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    // Questionnaire screens don't have bottom nav
    expect(find.byType(CustomBottomNavBar), findsNothing);
    // Should have exactly one PrimaryButton (the scaffold's continue button)
    final buttons = find.byType(PrimaryButton);
    expect(buttons, findsOneWidget);
    expect(find.text('Show Recommendations'), findsOneWidget);
  });

  testWidgets('Recommendation screen renders without errors (no bottom nav)', (tester) async {
    await tester.pumpWidget(buildTestApp(RecommendationScreen(profile: createTestProfile())));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    // Recommendation screen doesn't have bottom nav
    expect(find.byType(CustomBottomNavBar), findsNothing);
    // Check body has visible content
    expect(find.textContaining('Match'), findsOneWidget);
  });

  testWidgets('Laptop Checker screen renders without errors, nav at bottom', (tester) async {
    await tester.pumpWidget(buildTestApp(const LaptopCheckerScreen()));
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    // Check nav bar exists
    final navFinder = find.byType(CustomBottomNavBar);
    expect(navFinder, findsOneWidget);
    // Check body has visible content
    expect(find.textContaining('Check a Laptop'), findsOneWidget);
  });
}