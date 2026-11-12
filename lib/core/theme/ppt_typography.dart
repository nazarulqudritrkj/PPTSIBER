import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'ppt_colors.dart';

/// Tipografi Profesional PPT SI-CAKRAWALA
/// Menggabungkan Orbitron (Taktis Militer), Exo 2 (Korporat/Institusi), dan Fira Code (C2 Terminal).
class PptTypography {
  // ── Judul Utama & Headline ──────────────────────────────────────────────────
  static TextStyle titleHero({Color color = PptColors.textPrimary}) =>
      GoogleFonts.orbitron(
        fontSize: 34,
        fontWeight: FontWeight.w900,
        letterSpacing: 2.0,
        color: color,
        height: 1.15,
      );

  static TextStyle titleSlide({Color color = PptColors.textPrimary}) =>
      GoogleFonts.orbitron(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.5,
        color: color,
        height: 1.2,
      );

  static TextStyle subtitleSlide({Color color = PptColors.merahIndonesia}) =>
      GoogleFonts.orbitron(
        fontSize: 12,
        fontWeight: FontWeight.w700,
        letterSpacing: 3.0,
        color: color,
      );

  // ── Teks Isi / Konten Presentasi ───────────────────────────────────────────
  static TextStyle bodyLarge({Color color = PptColors.textPrimary}) =>
      GoogleFonts.exo2(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        height: 1.5,
        color: color,
      );

  static TextStyle bodyMedium({Color color = PptColors.textSecondary}) =>
      GoogleFonts.exo2(
        fontSize: 13.5,
        fontWeight: FontWeight.w400,
        height: 1.45,
        color: color,
      );

  static TextStyle bodySmall({Color color = PptColors.textMuted}) =>
      GoogleFonts.exo2(
        fontSize: 11.5,
        fontWeight: FontWeight.w400,
        height: 1.4,
        color: color,
      );

  // ── Label Taktis & Badge Militer ───────────────────────────────────────────
  static TextStyle tacticalBadge({Color color = PptColors.textPrimary}) =>
      GoogleFonts.orbitron(
        fontSize: 10,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.8,
        color: color,
      );

  static TextStyle cardHeader({Color color = PptColors.textPrimary}) =>
      GoogleFonts.orbitron(
        fontSize: 14,
        fontWeight: FontWeight.w800,
        letterSpacing: 1.0,
        color: color,
      );

  // ── Monospace (Terminal, Hash, Telemetri) ──────────────────────────────────
  static TextStyle mono({
    Color color = PptColors.textPrimary,
    double fontSize = 12,
    FontWeight fontWeight = FontWeight.w600,
  }) =>
      GoogleFonts.firaCode(
        fontSize: fontSize,
        fontWeight: fontWeight,
        color: color,
      );
}

