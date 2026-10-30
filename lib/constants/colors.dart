import 'package:flutter/material.dart';

class AppColors {
  // Primary Deep Blue & Sky Theme Colors
  static const Color background = Color(0xFF030816);      // Deep Midnight Sapphire
  static const Color surface = Color(0xFF07152E);         // Deep Navy Blue
  static const Color surfaceCard = Color(0xFF0D2240);     // Translucent Navy Card
  
  // Accents & Gradients
  static const Color primaryAccent = Color(0xFF38BDF8);   // Vibrant Sky Blue
  static const Color secondaryAccent = Color(0xFF0284C7); // Rich Ocean Blue
  static const Color royalBlue = Color(0xFF2563EB);        // Electric Royal Blue
  static const Color sapphireBlue = Color(0xFF1D4ED8);     // Deep Sapphire
  static const Color cyanAccent = Color(0xFF06B6D4);       // Electric Cyan
  static const Color violetAccent = Color(0xFF8B5CF6);    // Violet Glow
  static const Color pinkAccent = Color(0xFFEC4899);      // Pink Glow
  static const Color orangeAccent = Color(0xFFF97316);    // Orange Glow
  static const Color greenAccent = Color(0xFF10B981);     // Emerald Glow
  static const Color redAccent = Color(0xFFEF4444);       // Red Glow
  
  // Neutral Text Colors
  static const Color textPrimary = Color(0xFFFAFAFA);     // Ice White
  static const Color textSecondary = Color(0xFF94A3B8);   // Slate Sky Tint
  static const Color textMuted = Color(0xFF64748B);       // Darker Slate
  
  // Borders and Glassmorphism
  static const Color borderLight = Color(0x2438BDF8);     // 14% Sky Blue Border
  static const Color glassBg = Color(0x1407152E);         // Frosted Navy Glass
  static const Color glassHighlight = Color(0x2638BDF8);  // Translucent Sky Blue

  // Gradients
  static const Gradient heroGradient = LinearGradient(
    colors: [primaryAccent, royalBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient skyGradient = LinearGradient(
    colors: [Color(0xFF38BDF8), Color(0xFF0284C7), Color(0xFF1D4ED8)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const Gradient darkGradient = LinearGradient(
    colors: [background, surface],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );
}
