import 'package:flutter/material.dart';

class AppColors {
  // Primary Theme Colors
  static const Color background = Color(0xFF030303);      // Obsidian Black
  static const Color surface = Color(0xFF09090B);         // Zinc Black
  static const Color surfaceCard = Color(0xFF18181B);     // Dark Gray surface
  
  // Accents & Gradients (Linear / Stripe style)
  static const Color primaryAccent = Color(0xFF6366F1);   // Indigo Accent
  static const Color secondaryAccent = Color(0xFF06B6D4); // Cyan Glow
  static const Color violetAccent = Color(0xFF8B5CF6);    // Violet Glow
  static const Color pinkAccent = Color(0xFFEC4899);      // Pink Glow
  static const Color orangeAccent = Color(0xFFF97316);    // Orange Glow
  static const Color greenAccent = Color(0xFF10B981);     // Emerald Glow
  static const Color redAccent = Color(0xFFEF4444);       // Red Glow
  
  // Neutral Text Colors
  static const Color textPrimary = Color(0xFFFAFAFA);     // Ice White
  static const Color textSecondary = Color(0xFFA1A1AA);   // Slate/Zinc Grey
  static const Color textMuted = Color(0xFF71717A);       // Darker Grey
  
  // Borders and Glassmorphism
  static const Color borderLight = Color(0x1AFFFFFF);     // 10% Opacity Border
  static const Color glassBg = Color(0x0CFFFFFF);         // 5% Frosted Glass Bg
  static const Color glassHighlight = Color(0x1F6366F1);  // Translucent Indigo

  // Gradients
  static const Gradient heroGradient = LinearGradient(
    colors: [primaryAccent, secondaryAccent],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient darkGradient = LinearGradient(
    colors: [background, surface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
