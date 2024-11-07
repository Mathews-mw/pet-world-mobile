import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:pet_world_mobile/utils/app_routes.dart';
import 'package:pet_world_mobile/theme/colors/app_colors.dart';
import 'package:pet_world_mobile/screens/schedules-screen.dart';
import 'package:pet_world_mobile/screens/scheduling_form_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: theme.colorScheme.copyWith(
          surface: AppColors.backgroundPrimary,
          primary: AppColors.contentPrimary,
          secondary: AppColors.contentSecondary,
          tertiary: AppColors.contentTertiary,
        ),
        textTheme: theme.textTheme.copyWith(
          bodySmall: GoogleFonts.inter(
            color: AppColors.contentPrimary,
            fontSize: 12,
          ),
          bodyMedium: GoogleFonts.inter(
            color: AppColors.contentPrimary,
            fontSize: 14,
          ),
          labelSmall: GoogleFonts.inter(
            color: AppColors.contentPrimary,
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
          labelMedium: GoogleFonts.inter(
            color: AppColors.contentPrimary,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
          labelLarge: GoogleFonts.inter(
            color: AppColors.contentPrimary,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          titleLarge: GoogleFonts.interTight(
            color: AppColors.contentPrimary,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        dividerTheme: theme.dividerTheme.copyWith(
          color: AppColors.borderDivisor,
        ),
        appBarTheme: theme.appBarTheme.copyWith(
          backgroundColor: AppColors.backgroundTertiary,
          iconTheme: theme.iconTheme.copyWith(
            color: AppColors.contentSecondary,
          ),
          titleTextStyle: GoogleFonts.interTight(
            color: AppColors.contentPrimary,
            fontSize: 22,
            fontWeight: FontWeight.bold,
          ),
        ),
        drawerTheme: theme.drawerTheme.copyWith(
          backgroundColor: AppColors.backgroundSecondary,
        ),
        inputDecorationTheme: theme.inputDecorationTheme.copyWith(
          labelStyle: const TextStyle(
            color: AppColors.contentSecondary,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: AppColors.borderPrimary),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.borderBrand),
            borderRadius: BorderRadius.circular(10),
          ),
          prefixIconColor: AppColors.contentBrand,
        ),
        useMaterial3: true,
      ),
      routes: {
        AppRoutes.HOME: (ctx) => const SchedulesScreen(),
        AppRoutes.SCHEDULING_FORM: (ctx) => const SchedulingFormScreen(),
      },
    );
  }
}
