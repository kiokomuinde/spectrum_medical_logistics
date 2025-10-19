// lib/theme/app_theme.dart
import 'package:flutter/material.dart';

class AppColors {
  // --- Core Palette (REVERTED TO YOUR ORIGINAL COLORS) ---
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
  
  // --- Gradients (Reverted to Original) ---
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

  static const LinearGradient gentleHighlightGradient = LinearGradient(
    colors: [Color(0xFF81C784), Color(0xFF80CBC4), Color(0xFF64B5F6)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
  
  static const LinearGradient nightGradient = LinearGradient(
    colors: [darkBlue, Color(0xFF0D47A1)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}

ThemeData getAppTheme() {
  return ThemeData(
    primaryColor: AppColors.primaryBlue,
    scaffoldBackgroundColor: AppColors.lightBackground,
    
    // ... Text Theme ...
    textTheme: const TextTheme(
        displayLarge: TextStyle(fontSize: 48, fontWeight: FontWeight.bold, color: AppColors.textDark),
        displayMedium: TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: AppColors.textDark),
        
        headlineLarge: TextStyle(fontSize: 32, fontWeight: FontWeight.w400, color: AppColors.textDark),
        headlineMedium: TextStyle(fontSize: 28, fontWeight: FontWeight.w500, color: AppColors.textDark),
        headlineSmall: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, color: AppColors.textDark),

        titleLarge: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: AppColors.textDark),
        titleMedium: TextStyle(fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.textDark),
        titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textDark),

        bodyLarge: TextStyle(fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.textDark),
        bodyMedium: TextStyle(fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.textDark),
        bodySmall: TextStyle(fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.textDark),
      ),
      
      // ... ElevatedButton Theme ...
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: AppColors.textLight, 
          backgroundColor: AppColors.primaryGreen, 
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      
      // ... OutlinedButton Theme ...
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryBlue,
          side: const BorderSide(color: AppColors.primaryBlue, width: 2),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
          textStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      ),
      
      // 🔥 FIX: Corrected the type to CardThemeData to resolve the compilation error.
      cardTheme: CardThemeData( 
        elevation: 4.0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
        color: AppColors.cardBackground,
      ),
      
      // ... Icon Theme ...
      iconTheme: const IconThemeData(
        color: AppColors.primaryBlue,
        size: 24,
      ),
  );
}