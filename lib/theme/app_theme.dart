// lib/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppColors {
  // --- Core Palette (Refined for Beauty, Memory & Peace) ---
  static const Color primaryGreen = Color(0xFF66BB6A); // Soft, natural green
  static const Color accentGreen = Color(0xFF81C784); // Lighter, luminous green
  static const Color darkBlue = Color(0xFF1976D2); // Rich, deep blue
  static const Color primaryBlue = Color(0xFF42A5F5); // Serene blue
  static const Color teal = Color(0xFF4DB6AC); // Tranquil teal
  
  // --- Backgrounds & Surfaces ---
  static const Color lightBackground = Color(0xFFF0F4F8); // Gentle off-white
  static const Color cardBackground = Colors.white; // Pure white 
  static const Color darkBackground = darkBlue; 
  
  // --- Text Colors ---
  static const Color textDark = Color(0xFF263238); 
  static const Color textMuted = Color(0xFF78909C); 
  static const Color textLight = Colors.white; 
  
  // --- Gradients (Designed for 0.15 opacity shade effect in Hero) ---
  static final Gradient sereneGradient = LinearGradient(
    colors: [
      primaryBlue.withOpacity(0.15), // Reduced opacity
      teal.withOpacity(0.15),      // Reduced opacity
      accentGreen.withOpacity(0.15) // Reduced opacity
    ],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    stops: const [0.0, 0.5, 1.0],
  );

  static const Gradient gentleHighlightGradient = LinearGradient(
    colors: [Color(0xFF81C784), Color(0xFF80CBC4), Color(0xFF64B5F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const Gradient nightGradient = LinearGradient(
    colors: [darkBlue, Color(0xFF0D47A1)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

ThemeData getAppTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.lightBackground,
    textTheme: const TextTheme(
      displayLarge: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.bold),
      headlineMedium: TextStyle(color: AppColors.primaryBlue, fontWeight: FontWeight.w700),
      bodyLarge: TextStyle(color: AppColors.textDark),
      bodyMedium: TextStyle(color: AppColors.textMuted),
    ),
    useMaterial3: true,
  );
}
