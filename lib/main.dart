import 'package:flutter/material.dart';
import 'package:laptix/screens/home_screen.dart';
import 'package:laptix/screens/major_screen.dart';
import 'package:laptix/screens/usage_screen.dart';
import 'package:laptix/screens/budget_screen.dart';
import 'package:laptix/screens/recommendation_screen.dart';
import 'package:laptix/screens/laptop_checker_screen.dart';
import 'package:laptix/Core/Constants/app_routes.dart';
import 'package:laptix/models/student_profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: AppRoutes.home,
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case AppRoutes.home:
            return MaterialPageRoute(builder: (_) => const HomeScreen());
          case AppRoutes.major:
            return MaterialPageRoute(builder: (_) => const MajorScreen());
          case AppRoutes.usage:
            final profile = settings.arguments as StudentProfile?;
            return MaterialPageRoute(
              builder: (_) => UsageScreen(profile: profile!),
            );
          case AppRoutes.budget:
            final profile = settings.arguments as StudentProfile?;
            return MaterialPageRoute(
              builder: (_) => BudgetScreen(profile: profile!),
            );
          case AppRoutes.recommendation:
            final profile = settings.arguments as StudentProfile?;
            return MaterialPageRoute(
              builder: (_) => RecommendationScreen(profile: profile!),
            );
          case AppRoutes.laptopChecker:
            return MaterialPageRoute(builder: (_) => const LaptopCheckerScreen());
          default:
            return null;
        }
      },
    );
  }
}