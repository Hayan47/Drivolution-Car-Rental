import 'package:flutter/material.dart';

/// App-wide typography styles
class AppTypography {
  // Private constructor to prevent instantiation
  AppTypography._();

  /// Font Family
  static const String headerFontFamily = 'Roboto';
  static const String bodyFontFamily = 'Karla';
  static const String titleFontFamily = 'Amiri';

  /// Font Weights
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight bold = FontWeight.w700;

  /// Title
  static TextStyle title = const TextStyle(
    fontFamily: titleFontFamily,
    fontSize: 32,
    fontWeight: bold,
    letterSpacing: -0.5,
  );

  // Headings
  static TextStyle h1 = const TextStyle(
    fontFamily: headerFontFamily,
    fontSize: 32,
    fontWeight: bold,
    letterSpacing: -0.5,
  );

  static TextStyle h2 = const TextStyle(
    fontFamily: headerFontFamily,
    fontSize: 24,
    fontWeight: bold,
    letterSpacing: -0.3,
  );

  static TextStyle h3 = const TextStyle(
    fontFamily: headerFontFamily,
    fontSize: 20,
    fontWeight: bold,
    letterSpacing: -0.2,
  );

  static TextStyle h4 = const TextStyle(
    fontFamily: headerFontFamily,
    fontSize: 18,
    fontWeight: medium,
    letterSpacing: -0.2,
  );

  /// Body Text
  static TextStyle bodyLarge = const TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 16,
    fontWeight: regular,
    letterSpacing: 0.1,
  );

  static TextStyle bodyMedium = const TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 14,
    fontWeight: regular,
    letterSpacing: 0.1,
  );

  static TextStyle bodySmall = const TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 12,
    fontWeight: regular,
    letterSpacing: 0.2,
  );

  /// Labels and Buttons
  static TextStyle labelLarge = const TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 16,
    fontWeight: medium,
    letterSpacing: 0.2,
  );

  static TextStyle labelMedium = const TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 14,
    fontWeight: medium,
    letterSpacing: 0.2,
  );

  static TextStyle labelSmall = const TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 12,
    fontWeight: medium,
    letterSpacing: 0.2,
  );

  /// Specialized Text Styles
  static TextStyle caption = const TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 12,
    fontWeight: regular,
    letterSpacing: 0.3,
  );

  static TextStyle overline = const TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 10,
    fontWeight: medium,
    letterSpacing: 0.5,
    textBaseline: TextBaseline.alphabetic,
  );

  static TextStyle button = const TextStyle(
    fontFamily: bodyFontFamily,
    fontSize: 14,
    fontWeight: medium,
    letterSpacing: 0.2,
  );

  /// Helper methods for common text style modifications
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }

  static TextStyle withWeight(TextStyle style, FontWeight weight) {
    return style.copyWith(fontWeight: weight);
  }

  static TextStyle withSize(TextStyle style, double size) {
    return style.copyWith(fontSize: size);
  }
}
