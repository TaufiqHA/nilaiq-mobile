import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

/// Builds the [ThemeData] for both light and dark modes, matching the
/// NilaiQ website (brand blue, Instrument Sans, 12px base radius).
class AppTheme {
  const AppTheme._();

  static ThemeData get light => _build(AppPalette.light, Brightness.light);

  static ThemeData get dark => _build(AppPalette.dark, Brightness.dark);

  static ThemeData _build(AppPalette p, Brightness brightness) {
    final base = ThemeData(
      useMaterial3: true,
      brightness: brightness,
      scaffoldBackgroundColor: p.pageBg,
      colorScheme:
          ColorScheme.fromSeed(
            seedColor: p.brand,
            brightness: brightness,
          ).copyWith(
            primary: p.brand,
            onPrimary: Colors.white,
            surface: p.cardBg,
            onSurface: p.heading,
            error: p.danger,
          ),
    );

    // Single source of truth for the type scale. A tighter, more uniform
    // scale than the Material 3 defaults (which jump between 11 and 28px),
    // base 14px to match the website.
    final applied = base.textTheme.apply(
      fontFamily: GoogleFonts.instrumentSans().fontFamily,
      bodyColor: p.body,
      displayColor: p.heading,
    );
    final textTheme = applied.copyWith(
      headlineMedium: applied.headlineMedium?.copyWith(fontSize: 24),
      headlineSmall: applied.headlineSmall?.copyWith(fontSize: 19),
      titleLarge: applied.titleLarge?.copyWith(fontSize: 19),
      titleMedium: applied.titleMedium?.copyWith(fontSize: 15),
      bodyLarge: applied.bodyLarge?.copyWith(fontSize: 14),
    );

    return base.copyWith(
      textTheme: textTheme,
      dividerTheme: DividerThemeData(
        color: p.borderColor,
        thickness: 1,
        space: 1,
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: p.cardBg,
        foregroundColor: p.heading,
        elevation: 0,
        scrolledUnderElevation: 0,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        titleTextStyle: textTheme.titleLarge?.copyWith(
          fontWeight: FontWeight.w700,
          color: p.heading,
        ),
      ),
      cardTheme: CardThemeData(
        color: p.cardBg,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppPalette.radius),
          side: BorderSide(color: p.borderColor),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: p.secondarySoft,
        hintStyle: textTheme.bodyMedium?.copyWith(color: p.disabled),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 14,
        ),
        border: _inputBorder(p.borderColor),
        enabledBorder: _inputBorder(p.borderColor),
        focusedBorder: _inputBorder(p.brand, width: 1.5),
        errorBorder: _inputBorder(p.danger),
        focusedErrorBorder: _inputBorder(p.danger, width: 1.5),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: p.brand,
          foregroundColor: Colors.white,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPalette.radius),
          ),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: p.heading,
          side: BorderSide(color: p.borderColor),
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w700,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppPalette.radius),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: p.brand,
          textStyle: textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: p.heading,
        contentTextStyle: textTheme.bodyMedium?.copyWith(color: p.cardBg),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppPalette.radius),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: p.cardBg,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppPalette.radius),
        ),
      ),
      extensions: [p],
    );
  }

  static OutlineInputBorder _inputBorder(Color color, {double width = 1}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppPalette.radius),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
