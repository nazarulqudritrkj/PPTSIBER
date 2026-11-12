import 'package:flutter/material.dart';

/// Palet Warna Resmi PPT SI-CAKRAWALA (Light Prestige Theme)
/// Mengusung identitas Merah Putih Indonesia, Emas Nanggroe Sumatera,
/// Hijau Taktis Komando TNI AD, dan Liquid White Glassmorphism.
class PptColors {
  // ── Warna Kebangsaan Merah Putih Indonesia ──────────────────────────────────
  static const Color merahIndonesia   = Color(0xFFCC0001); // Merah Sang Saka Berani
  static const Color merahVibrant     = Color(0xFFE8001A); // Merah Operasional
  static const Color merahSoft        = Color(0xFFFF3D5A); // Aksen Glow Merah
  static const Color merahDeep        = Color(0xFF8B0000); // Merah Marun Komando
  static const Color putihIndonesia   = Color(0xFFFFFFFF); // Putih Suci
  static const Color putihKristal     = Color(0xFFF8FAFC); // Cool Pearl White

  // ── Nuansa Warisan Sumatera & Emas Nanggroe ─────────────────────────────────
  static const Color emasNanggroe     = Color(0xFFD4AF37); // Emas Kesultanan Aceh/Sumatera
  static const Color emasVibrant      = Color(0xFFF59E0B); // Amber Emas Menyala
  static const Color emasDeep         = Color(0xFFB8860B); // Emas Perunggu Insignia
  static const Color emasGlow         = Color(0x33D4AF37); // Emas Transparan Glow

  // ── Hijau Taktis SATSIBER TNI AD ───────────────────────────────────────────
  static const Color tniGreenDark     = Color(0xFF1A3A28); // Hijau Komando Dalam
  static const Color tniGreenMid      = Color(0xFF2D6A4F); // Hijau Loreng Taktis
  static const Color tniGreenAccent   = Color(0xFF40916C); // Hijau Operasi
  static const Color tniGreenNeon     = Color(0xFF10B981); // Hijau Status Aktif

  // ── Cyber High-Tech Accents (Satelit & Telemetri) ──────────────────────────
  static const Color cyberBlue        = Color(0xFF0072FF);
  static const Color cyberCyan        = Color(0xFF00C6FF);
  static const Color cyberPurple      = Color(0xFF7C3AED);

  // ── Background & Surfaces (100% Light Theme) ───────────────────────────────
  static const Color backgroundCanvas = Color(0xFFF4F7FB); // Kanvas Terang Modern
  static const Color backgroundAlt    = Color(0xFFEBF1F8); // Alternatif Shading
  static const Color surfaceCard      = Color(0xFFFFFFFF); // Kartu Putih Bersih
  static const Color glassSurface     = Color(0xEBFFFFFF); // 92% White Liquid Glass
  static const Color glassSurfaceSoft = Color(0xB8FFFFFF); // 72% Translucent Glass

  // ── Glass Borders & Shadow ─────────────────────────────────────────────────
  static const Color glassBorderLight = Color(0x66CBD5E1); // Border Slate Tipis
  static const Color glassBorderRed   = Color(0x80CC0001); // Border Aksen Merah
  static const Color glassBorderGold  = Color(0x80D4AF37); // Border Aksen Emas
  static const Color glassBorderGreen = Color(0x802D6A4F); // Border Aksen TNI
  static const Color shadowSoft       = Color(0x140F172A); // Bayangan Halus
  static const Color shadowElevated   = Color(0x240F172A); // Bayangan Mengambang

  // ── Tipografi Kontras Tinggi (Readable Light Background) ───────────────────
  static const Color textPrimary      = Color(0xFF0F172A); // Slate 900 (Tajam & Elegan)
  static const Color textSecondary    = Color(0xFF334155); // Slate 700
  static const Color textMuted        = Color(0xFF64748B); // Slate 500
  static const Color textOnRed        = Color(0xFFFFFFFF);
  static const Color textOnGold       = Color(0xFF1E293B);

  // ── Presets Gradien Mewah (Light Luxury Gradients) ──────────────────────────
  static const LinearGradient merahPutihGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFE8001A), Color(0xFFCC0001), Color(0xFF990000)],
  );

  static const LinearGradient emasNanggroeGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFF59E0B), Color(0xFFD4AF37), Color(0xFFB8860B)],
  );

  static const LinearGradient tniGreenGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFF2D6A4F), Color(0xFF1A3A28)],
  );

  static const LinearGradient glassCardGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [Color(0xFFFFFFFF), Color(0xF5F8FCFF)],
  );
}

