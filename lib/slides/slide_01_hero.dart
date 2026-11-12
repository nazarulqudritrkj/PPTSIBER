import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/theme/ppt_colors.dart';
import '../core/theme/ppt_typography.dart';
import '../core/audio/tactical_audio_service.dart';

class Slide01Hero extends StatefulWidget {
  final VoidCallback onStart;
  const Slide01Hero({super.key, required this.onStart});

  @override
  State<Slide01Hero> createState() => _Slide01HeroState();
}

class _Slide01HeroState extends State<Slide01Hero>
    with TickerProviderStateMixin {
  late final AnimationController _spinController;
  late final AnimationController _pulseController;
  late final AnimationController _staggerController;

  late final Animation<double> _badgeFade;
  late final Animation<Offset> _badgeSlide;
  late final Animation<double> _titleFade;
  late final Animation<Offset> _titleSlide;
  late final Animation<double> _infoFade;
  late final Animation<double> _ctaFade;

  @override
  void initState() {
    super.initState();
    _spinController = AnimationController(
        vsync: this, duration: const Duration(seconds: 20))
      ..repeat();
    _pulseController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 2600))
      ..repeat(reverse: true);
    _staggerController = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 1600))
      ..forward();

    _badgeFade = CurvedAnimation(
        parent: _staggerController,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOut));
    _badgeSlide =
        Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
            .animate(_badgeFade);
    _titleFade = CurvedAnimation(
        parent: _staggerController,
        curve: const Interval(0.2, 0.65, curve: Curves.easeOut));
    _titleSlide =
        Tween<Offset>(begin: const Offset(0, 0.25), end: Offset.zero)
            .animate(_titleFade);
    _infoFade = CurvedAnimation(
        parent: _staggerController,
        curve: const Interval(0.5, 0.85, curve: Curves.easeOut));
    _ctaFade = CurvedAnimation(
        parent: _staggerController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut));
  }

  @override
  void dispose() {
    _spinController.dispose();
    _pulseController.dispose();
    _staggerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 60, 40, 55),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // ── KOLOM KIRI: Profil Pembuat + Deskripsi Karya ─────────────────
          Expanded(
            flex: 6,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Badge Pembuka: Staggered Slide Down
                FadeTransition(
                  opacity: _badgeFade,
                  child: SlideTransition(
                    position: _badgeSlide,
                    child: Wrap(
                      spacing: 8,
                      runSpacing: 6,
                      children: [
                        _badge('🛡️ DOKTRIN PERTAHANAN SIBER NASIONAL',
                            PptColors.merahIndonesia, Colors.white),
                        _badge('⭐ INDONESIA EMAS 2045',
                            PptColors.emasNanggroe.withValues(alpha: 0.15),
                            PptColors.emasDeep,
                            border: PptColors.emasNanggroe),
                        _badge('🔒 RAHASIA // TOP SECRET',
                            PptColors.tniGreenDark.withValues(alpha: 0.1),
                            PptColors.tniGreenDark,
                            border: PptColors.tniGreenDark.withValues(alpha: 0.4)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // Judul Utama Staggered
                FadeTransition(
                  opacity: _titleFade,
                  child: SlideTransition(
                    position: _titleSlide,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, child) => ShaderMask(
                            shaderCallback: (rect) => LinearGradient(
                              colors: [
                                PptColors.merahIndonesia,
                                Color.lerp(PptColors.merahIndonesia,
                                        PptColors.merahDeep, _pulseController.value) ??
                                    PptColors.merahIndonesia,
                              ],
                            ).createShader(rect),
                            child: Text(
                              'SI-CAKRAWALA',
                              style: PptTypography.titleHero(color: Colors.white),
                            ),
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          'NANGGROE CAKRAWALA SHIELD — TNI AD',
                          style: PptTypography.subtitleSlide(color: PptColors.tniGreenDark),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 10),

                // Profil Kartu Pembuat
                FadeTransition(
                  opacity: _infoFade,
                  child: Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.92),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(
                          color: PptColors.emasNanggroe.withValues(alpha: 0.4),
                          width: 1.5),
                      boxShadow: [
                        BoxShadow(
                          color: PptColors.emasNanggroe.withValues(alpha: 0.1),
                          blurRadius: 16,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Foto Profil
                        _buildProfileAvatar(),
                        const SizedBox(width: 14),

                        // Info Pembuat
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.person_rounded,
                                      size: 13,
                                      color: PptColors.emasDeep),
                                  const SizedBox(width: 4),
                                  Text('PEMBUAT KARYA',
                                      style: PptTypography.bodySmall(
                                          color: PptColors.textMuted)),
                                ],
                              ),
                              const SizedBox(height: 2),
                              Text(
                                'NAZARUL QUDRI',
                                style: PptTypography.cardHeader(
                                    color: PptColors.textPrimary),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                'Pusat Komando Operasional Siber Terpadu (Cyber Operation Command Center) TNI AD — Sistem pertahanan multi-domain berbasis Flutter Web dengan integrasi AI, Blockchain 15 Kodam, dan Kriptografi Pasca-Kuantum.',
                                style: PptTypography.bodySmall(
                                    color: PptColors.textSecondary),
                              ),
                              const SizedBox(height: 6),
                              Wrap(
                                spacing: 6,
                                children: [
                                  _infoChip(Icons.code_rounded,
                                      'Flutter 3.44 + Dart', PptColors.cyberBlue),
                                  _infoChip(Icons.storage_rounded,
                                      'Supabase Cloud', PptColors.tniGreenNeon),
                                  _infoChip(Icons.language_rounded,
                                      'Web Production', PptColors.merahIndonesia),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 14),

                // CTA Buttons
                FadeTransition(
                  opacity: _ctaFade,
                  child: Row(
                    children: [
                      _ctaButton(
                        '▶  MULAI PRESENTASI',
                        PptColors.merahPutihGradient,
                        Colors.white,
                        onTap: () {
                          TacticalAudioService.playClick();
                          widget.onStart();
                        },
                      ),
                      const SizedBox(width: 10),
                      _ctaButton(
                        '🌐  BUKA LIVE DEMO',
                        PptColors.emasNanggroeGradient,
                        PptColors.textOnGold,
                        onTap: () => TacticalAudioService.playClick(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(width: 24),

          // ── KOLOM KANAN: Logo SI-CAKRAWALA + Cincin Insignia ─────────────
          Expanded(
            flex: 4,
            child: Center(
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Cincin Luar Berputar Emas
                  AnimatedBuilder(
                    animation: _spinController,
                    builder: (context, child) => Transform.rotate(
                      angle: _spinController.value * 2 * math.pi,
                      child: SizedBox(
                        width: 280,
                        height: 280,
                        child: CustomPaint(
                          painter: _RingOrnamentPainter(
                              color: PptColors.emasNanggroe,
                              opacity: 0.45),
                        ),
                      ),
                    ),
                  ),

                  // Cincin Tengah Berlawanan Arah (Merah Soft)
                  AnimatedBuilder(
                    animation: _spinController,
                    builder: (context, child) => Transform.rotate(
                      angle: -_spinController.value * 2 * math.pi * 0.7,
                      child: SizedBox(
                        width: 230,
                        height: 230,
                        child: CustomPaint(
                          painter: _RingOrnamentPainter(
                              color: PptColors.merahIndonesia,
                              opacity: 0.25,
                              dashed: true),
                        ),
                      ),
                    ),
                  ),

                  // Cincin Dalam Hijau Taktis
                  AnimatedBuilder(
                    animation: _spinController,
                    builder: (context, child) => Transform.rotate(
                      angle: _spinController.value * 2 * math.pi * 0.4,
                      child: SizedBox(
                        width: 190,
                        height: 190,
                        child: CustomPaint(
                          painter: _RingOrnamentPainter(
                              color: PptColors.tniGreenAccent,
                              opacity: 0.3,
                              dashed: true),
                        ),
                      ),
                    ),
                  ),

                  // Halo Glow di belakang logo
                  AnimatedBuilder(
                    animation: _pulseController,
                    builder: (context, child) => Container(
                      width: 165,
                      height: 165,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(colors: [
                          PptColors.emasNanggroe.withValues(
                              alpha: 0.18 + _pulseController.value * 0.12),
                          Colors.transparent,
                        ]),
                      ),
                    ),
                  ),

                  // Logo Utama (Circular Clipped)
                  Container(
                    width: 155,
                    height: 155,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: PptColors.emasNanggroe.withValues(alpha: 0.3),
                          blurRadius: 24,
                          spreadRadius: 4,
                          offset: const Offset(0, 6),
                        ),
                        BoxShadow(
                          color: PptColors.merahIndonesia.withValues(alpha: 0.1),
                          blurRadius: 48,
                          spreadRadius: 2,
                        ),
                      ],
                      border: Border.all(
                          color: PptColors.emasNanggroe, width: 3),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: Image.asset(
                      'assets/sicakrawala_logo.jpg',
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        color: PptColors.backgroundCanvas,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.shield_rounded,
                                size: 40, color: PptColors.merahIndonesia),
                            Text('TNI AD',
                                style: PptTypography.tacticalBadge()),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Badge Version
                  Positioned(
                    bottom: 20,
                    right: 20,
                    child: AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) => Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                              color: PptColors.tniGreenNeon
                                  .withValues(alpha: 0.5 + _pulseController.value * 0.4)),
                          boxShadow: [
                            BoxShadow(
                              color: PptColors.tniGreenNeon.withValues(
                                  alpha: 0.1 + _pulseController.value * 0.1),
                              blurRadius: 12,
                            )
                          ],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 6,
                              height: 6,
                              decoration: BoxDecoration(
                                color: PptColors.tniGreenNeon.withValues(
                                    alpha: 0.5 + _pulseController.value * 0.5),
                                shape: BoxShape.circle,
                              ),
                            ),
                            const SizedBox(width: 5),
                            Text('v4.7.2-ALPHA LIVE',
                                style: PptTypography.mono(
                                    fontSize: 9.5,
                                    color: PptColors.tniGreenDark)),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileAvatar() {
    return Container(
      width: 64,
      height: 64,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [PptColors.merahIndonesia, PptColors.merahDeep],
        ),
        border: Border.all(color: PptColors.emasNanggroe, width: 2.5),
        boxShadow: [
          BoxShadow(
              color: PptColors.merahIndonesia.withValues(alpha: 0.3),
              blurRadius: 12,
              offset: const Offset(0, 4))
        ],
      ),
      child: ClipOval(
        child: Image.asset(
          'assets/fotoprofil.jpg',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('NQ',
                    style: PptTypography.cardHeader(
                        color: Colors.white)),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _badge(String label, Color bg, Color textColor, {Color? border}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(5),
        border:
            border != null ? Border.all(color: border, width: 1) : null,
      ),
      child: Text(label, style: PptTypography.tacticalBadge(color: textColor)),
    );
  }

  Widget _infoChip(IconData icon, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 10, color: color),
          const SizedBox(width: 3),
          Text(label,
              style: PptTypography.bodySmall(color: color)
                  .copyWith(fontSize: 10)),
        ],
      ),
    );
  }

  Widget _ctaButton(String label, Gradient gradient, Color textColor,
      {required VoidCallback onTap}) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(10),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 11),
          decoration: BoxDecoration(
            gradient: gradient,
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: PptColors.merahIndonesia.withValues(alpha: 0.3),
                blurRadius: 10,
                offset: const Offset(0, 4),
              )
            ],
          ),
          child: Text(label,
              style: PptTypography.tacticalBadge(color: textColor)),
        ),
      ),
    );
  }
}

// ── Ring Ornament Painter ───────────────────────────────────────────────────
class _RingOrnamentPainter extends CustomPainter {
  final Color color;
  final double opacity;
  final bool dashed;

  const _RingOrnamentPainter(
      {required this.color, required this.opacity, this.dashed = false});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2 - 4;

    final paint = Paint()
      ..color = color.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = dashed ? 1.0 : 2.0;

    if (!dashed) {
      canvas.drawCircle(center, radius, paint);
      // 8 ornament dots
      for (int i = 0; i < 8; i++) {
        final angle = i * math.pi / 4;
        final x = center.dx + radius * math.cos(angle);
        final y = center.dy + radius * math.sin(angle);
        canvas.drawCircle(
            Offset(x, y), 4, Paint()..color = color.withValues(alpha: opacity));
      }
    } else {
      // Dashed circle
      const dashCount = 36;
      for (int i = 0; i < dashCount; i++) {
        if (i % 3 == 2) continue; // Skip every 3rd for dash effect
        final startAngle = i * 2 * math.pi / dashCount;
        final sweepAngle = 2 * math.pi / dashCount * 0.6;
        canvas.drawArc(
          Rect.fromCircle(center: center, radius: radius),
          startAngle,
          sweepAngle,
          false,
          paint,
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant _RingOrnamentPainter oldDelegate) =>
      oldDelegate.opacity != opacity;
}
