import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pet_world_mobile/models/scheduling_list.dart';

import 'package:pet_world_mobile/utils/app_routes.dart';
import 'package:pet_world_mobile/theme/colors/app_colors.dart';
import 'package:pet_world_mobile/screens/schedules-screen.dart';
import 'package:pet_world_mobile/screens/scheduling_form_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final ThemeData theme = ThemeData();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SchedulingList()),
      ],
      child: MaterialApp(
        localizationsDelegates: const [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate
        ],
        title: 'MUNDO PET',
        theme: ThemeData(
          colorScheme: theme.colorScheme.copyWith(
            surface: AppColors.backgroundPrimary,
            error: AppColors.error,
            errorContainer: AppColors.error,
            // primary: AppColors.contentPrimary,
            // secondary: AppColors.contentSecondary,
            // tertiary: AppColors.contentTertiary,
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
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.error,
              ),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: const BorderSide(
                color: AppColors.error,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(color: AppColors.borderBrand),
              borderRadius: BorderRadius.circular(10),
            ),
            prefixIconColor: AppColors.contentBrand,
          ),
          filledButtonTheme: FilledButtonThemeData(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.backgroundBrand,
              foregroundColor: Colors.black,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          outlinedButtonTheme: OutlinedButtonThemeData(
            style: OutlinedButton.styleFrom(
              textStyle: const TextStyle(
                  color: AppColors.contentPrimary,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
          datePickerTheme: theme.datePickerTheme.copyWith(
            backgroundColor: AppColors.backgroundPrimary,
            dayStyle: const TextStyle(color: Colors.red),
            headerHelpStyle: const TextStyle(color: AppColors.contentBrand),
            dayForegroundColor:
                const WidgetStatePropertyAll<Color>(AppColors.contentSecondary),
            weekdayStyle: const TextStyle(color: AppColors.contentSecondary),
            headerForegroundColor: AppColors.contentPrimary,
            yearStyle: const TextStyle(color: AppColors.contentPrimary),
            yearForegroundColor:
                const WidgetStatePropertyAll<Color>(AppColors.contentSecondary),
            surfaceTintColor: AppColors.backgroundBrand,
          ),
          timePickerTheme: theme.timePickerTheme.copyWith(
            backgroundColor: AppColors.backgroundPrimary,
            dayPeriodColor: AppColors.contentBrand,
            hourMinuteColor: AppColors.backgroundTertiary,
            hourMinuteTextColor: AppColors.contentSecondary,
            dialBackgroundColor: AppColors.backgroundTertiary,
            dialTextColor: AppColors.contentPrimary,
            entryModeIconColor: AppColors.contentSecondary,
          ),
          useMaterial3: true,
        ),
        routes: {
          AppRoutes.HOME: (ctx) => const SchedulesScreen(),
          AppRoutes.SCHEDULING_FORM: (ctx) => const SchedulingFormScreen(),
        },
      ),
    );
  }
}
