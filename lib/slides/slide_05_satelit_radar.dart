import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/theme/ppt_colors.dart';
import '../core/theme/ppt_typography.dart';
import 'slide_02_threat_landscape.dart' show sectionHeader;

class Slide05SatelitRadar extends StatefulWidget {
  const Slide05SatelitRadar({super.key});

  @override
  State<Slide05SatelitRadar> createState() => _Slide05SatelitRadarState();
}

class _Slide05SatelitRadarState extends State<Slide05SatelitRadar>
    with TickerProviderStateMixin {
  late final AnimationController _sweepCtrl;
  late final AnimationController _orbitCtrl;
  late final AnimationController _blipCtrl;
  late final AnimationController _pulseCtrl;

  final List<_BlipData> _blips = const [
    _BlipData(angle: 0.4, radius: 0.55, label: 'APT-29', color: Color(0xFFCC0001)),
    _BlipData(angle: 1.9, radius: 0.72, label: 'SAT-LEO', color: Color(0xFFD4AF37)),
    _BlipData(angle: 3.1, radius: 0.38, label: 'KODAM-I', color: Color(0xFF00C853)),
    _BlipData(angle: 4.6, radius: 0.65, label: 'INTEL', color: Color(0xFF1565C0)),
    _BlipData(angle: 5.8, radius: 0.82, label: 'JAMMING', color: Color(0xFFCC0001)),
  ];

  @override
  void initState() {
    super.initState();
    _sweepCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 4))..repeat();
    _orbitCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 12))..repeat();
    _blipCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat(reverse: true);
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _sweepCtrl.dispose();
    _orbitCtrl.dispose();
    _blipCtrl.dispose();
    _pulseCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 44, 40, 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionHeader(
            'BAB 04 // SISTEM PENGINDERAAN TINGKAT TINGGI',
            PptColors.tniGreenDark,
            'Sistem Radar Taktis & Orbit Satelit LEO',
            'SI-CAKRAWALA mengintegrasikan TacticalRadarWidget (360° sweep real-time) dan SatelliteOrbitWidget (LEO 550 km, inklinasi 97.4°) untuk situational awareness penuh 24/7.',
          ),
          const SizedBox(height: 14),

          Expanded(
            child: Row(
              children: [
                // ── RADAR PANEL ──────────────────────────────────────────────
                Expanded(
                  flex: 5,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: PptColors.tniGreenNeon.withValues(alpha: 0.4), width: 1.5),
                      boxShadow: [BoxShadow(color: PptColors.shadowSoft, blurRadius: 20, offset: const Offset(0, 6))],
                    ),
                    child: Column(
                      children: [
                        // Header
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                          decoration: const BoxDecoration(
                            color: PptColors.tniGreenDark,
                            borderRadius: BorderRadius.vertical(top: Radius.circular(14)),
                          ),
                          child: Row(
                            children: [
                              const Icon(Icons.radar_rounded, color: Colors.white, size: 18),
                              const SizedBox(width: 8),
                              Text('TacticalRadarWidget — CAKRAWALA-RADAR v3.2', style: PptTypography.tacticalBadge(color: Colors.white)),
                              const Spacer(),
                              AnimatedBuilder(
                                animation: _blipCtrl,
                                builder: (context, child) => Container(
                                  width: 8, height: 8,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: Color.lerp(PptColors.tniGreenNeon, Colors.white, _blipCtrl.value),
                                  ),
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text('LIVE', style: PptTypography.tacticalBadge(color: PptColors.tniGreenNeon)),
                            ],
                          ),
                        ),
                        // Radar Display
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: AnimatedBuilder(
                              animation: Listenable.merge([_sweepCtrl, _blipCtrl]),
                              builder: (context, child) => CustomPaint(
                                painter: _TacticalRadarCanvasPainter(
                                  sweepAngle: _sweepCtrl.value * 2 * math.pi,
                                  blipPulse: _blipCtrl.value,
                                  blips: _blips,
                                ),
                                child: const SizedBox.expand(),
                              ),
                            ),
                          ),
                        ),
                        // Freq Panel
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: const BoxDecoration(
                            color: PptColors.backgroundCanvas,
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(14)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              _freqChip('HF', '3–30 MHz', Icons.cell_tower_rounded),
                              _freqChip('VHF', '30–300 MHz', Icons.wifi_tethering_rounded),
                              _freqChip('SATCOM', 'L/S Band', Icons.satellite_alt_rounded),
                              _freqChip('JAMMING', 'AI-Block', Icons.block_rounded),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // ── KANAN: Orbit + Spesifikasi ───────────────────────────────
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      // Orbit Card
                      Expanded(
                        flex: 6,
                        child: Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: PptColors.emasNanggroe.withValues(alpha: 0.4), width: 1.5),
                            boxShadow: [BoxShadow(color: PptColors.shadowSoft, blurRadius: 16, offset: const Offset(0, 4))],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.satellite_alt_rounded, color: PptColors.emasDeep, size: 20),
                                  const SizedBox(width: 8),
                                  Text('SatelliteOrbitWidget — LEO Tracking', style: PptTypography.cardHeader(color: PptColors.emasDeep)),
                                ],
                              ),
                              const SizedBox(height: 10),
                              // Orbit Visualizer
                              Expanded(
                                child: AnimatedBuilder(
                                  animation: _orbitCtrl,
                                  builder: (context, child) => CustomPaint(
                                    painter: _OrbitPainter(progress: _orbitCtrl.value, pulse: _pulseCtrl.value),
                                    child: const SizedBox.expand(),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Spesifikasi Grid
                      Expanded(
                        flex: 4,
                        child: GridView.count(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          childAspectRatio: 2.8,
                          physics: const NeverScrollableScrollPhysics(),
                          children: [
                            _specTile('Altitude', '550 km LEO', PptColors.cyberBlue, Icons.height_rounded),
                            _specTile('Inklinasi', '97.4° Sun-Sync', PptColors.emasDeep, Icons.rotate_90_degrees_ccw_rounded),
                            _specTile('Revisit', '< 2 jam', PptColors.tniGreenNeon, Icons.refresh_rounded),
                            _specTile('Coverage', '15 Kodam Area', PptColors.merahIndonesia, Icons.map_rounded),
                            _specTile('Resolusi', '0.5m GSD SAR', PptColors.tniGreenDark, Icons.photo_size_select_large_rounded),
                            _specTile('Enkripsi', 'AES-256 + PQC', PptColors.merahDeep, Icons.lock_rounded),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _freqChip(String band, String range, IconData icon) {
    return Column(
      children: [
        Icon(icon, size: 14, color: PptColors.tniGreenDark),
        const SizedBox(height: 2),
        Text(band, style: PptTypography.tacticalBadge(color: PptColors.tniGreenDark)),
        Text(range, style: PptTypography.bodySmall(color: PptColors.textMuted).copyWith(fontSize: 9)),
      ],
    );
  }

  Widget _specTile(String label, String value, Color color, IconData icon) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value, style: PptTypography.tacticalBadge(color: color).copyWith(fontSize: 10)),
                Text(label, style: PptTypography.bodySmall(color: PptColors.textMuted).copyWith(fontSize: 9)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _BlipData {
  final double angle;
  final double radius;
  final String label;
  final Color color;
  const _BlipData({required this.angle, required this.radius, required this.label, required this.color});
}

class _TacticalRadarCanvasPainter extends CustomPainter {
  final double sweepAngle;
  final double blipPulse;
  final List<_BlipData> blips;

  const _TacticalRadarCanvasPainter({
    required this.sweepAngle,
    required this.blipPulse,
    required this.blips,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxR = math.min(size.width, size.height) / 2 - 8;

    // Background circle
    canvas.drawCircle(center, maxR, Paint()..color = const Color(0xFFF0F9F0));

    // Grid rings
    final ringPaint = Paint()
      ..color = const Color(0xFF1A3A28).withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;
    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(center, maxR * i / 4, ringPaint);
    }

    // Cross lines
    final crossPaint = Paint()
      ..color = const Color(0xFF1A3A28).withValues(alpha: 0.1)
      ..strokeWidth = 0.6;
    canvas.drawLine(Offset(center.dx - maxR, center.dy), Offset(center.dx + maxR, center.dy), crossPaint);
    canvas.drawLine(Offset(center.dx, center.dy - maxR), Offset(center.dx, center.dy + maxR), crossPaint);
    canvas.drawLine(Offset(center.dx - maxR * 0.707, center.dy - maxR * 0.707),
        Offset(center.dx + maxR * 0.707, center.dy + maxR * 0.707), crossPaint);
    canvas.drawLine(Offset(center.dx + maxR * 0.707, center.dy - maxR * 0.707),
        Offset(center.dx - maxR * 0.707, center.dy + maxR * 0.707), crossPaint);

    // Sweep sector
    final sweepPaint = Paint()
      ..shader = SweepGradient(
        startAngle: sweepAngle - 1.2,
        endAngle: sweepAngle,
        colors: [Colors.transparent, const Color(0xFF00C853).withValues(alpha: 0.5)],
      ).createShader(Rect.fromCircle(center: center, radius: maxR));
    canvas.drawArc(Rect.fromCircle(center: center, radius: maxR), sweepAngle - 1.2, 1.2, true, sweepPaint);

    // Sweep line
    canvas.drawLine(
      center,
      Offset(center.dx + maxR * math.cos(sweepAngle), center.dy + maxR * math.sin(sweepAngle)),
      Paint()..color = const Color(0xFF00C853)..strokeWidth = 1.5,
    );

    // Blips
    for (final blip in blips) {
      final bx = center.dx + maxR * blip.radius * math.cos(blip.angle);
      final by = center.dy + maxR * blip.radius * math.sin(blip.angle);
      final blipOffset = Offset(bx, by);

      // Pulse ring
      final diff = ((sweepAngle - blip.angle) % (2 * math.pi)).abs();
      final intensity = diff < 1.5 ? (1 - diff / 1.5) : 0.0;
      if (intensity > 0) {
        canvas.drawCircle(blipOffset, 10 + blipPulse * 8,
            Paint()..color = blip.color.withValues(alpha: intensity * 0.3)..style = PaintingStyle.stroke..strokeWidth = 1);
      }

      canvas.drawCircle(blipOffset, 4, Paint()..color = blip.color);

      // Label
      final tp = TextPainter(
        text: TextSpan(text: blip.label, style: TextStyle(color: blip.color, fontSize: 8, fontWeight: FontWeight.bold)),
        textDirection: TextDirection.ltr,
      )..layout();
      tp.paint(canvas, blipOffset.translate(6, -8));
    }

    // Center dot
    canvas.drawCircle(center, 5, Paint()..color = const Color(0xFF1A3A28));
    canvas.drawCircle(center, 3, Paint()..color = const Color(0xFF00C853));
  }

  @override
  bool shouldRepaint(covariant _TacticalRadarCanvasPainter oldDelegate) => true;
}

class _OrbitPainter extends CustomPainter {
  final double progress;
  final double pulse;
  const _OrbitPainter({required this.progress, required this.pulse});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;
    final rx = size.width * 0.42;
    final ry = size.height * 0.3;

    // Earth
    canvas.drawCircle(Offset(cx, cy), 28, Paint()
      ..shader = RadialGradient(colors: const [Color(0xFF1565C0), Color(0xFF0D47A1)])
          .createShader(Rect.fromCircle(center: Offset(cx, cy), radius: 28)));
    // Earth glow
    canvas.drawCircle(Offset(cx, cy), 32,
        Paint()..color = const Color(0xFF1565C0).withValues(alpha: 0.15)..style = PaintingStyle.stroke..strokeWidth = 4);

    // Orbit path
    final orbitPaint = Paint()
      ..color = const Color(0xFFD4AF37).withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, cy), width: rx * 2, height: ry * 2), orbitPaint);

    // Satellite position
    final angle = progress * 2 * math.pi;
    final sx = cx + rx * math.cos(angle);
    final sy = cy + ry * math.sin(angle);

    // Trail
    for (int i = 1; i <= 12; i++) {
      final ta = angle - i * 0.15;
      final tx = cx + rx * math.cos(ta);
      final ty = cy + ry * math.sin(ta);
      canvas.drawCircle(Offset(tx, ty), 1.5 * (1 - i / 12),
          Paint()..color = const Color(0xFFD4AF37).withValues(alpha: (1 - i / 12) * 0.6));
    }

    // Satellite body
    canvas.drawRect(
      Rect.fromCenter(center: Offset(sx, sy), width: 12, height: 6),
      Paint()..color = const Color(0xFFD4AF37),
    );
    // Solar panels
    canvas.drawRect(
      Rect.fromCenter(center: Offset(sx - 14, sy), width: 10, height: 3),
      Paint()..color = const Color(0xFF1565C0).withValues(alpha: 0.8),
    );
    canvas.drawRect(
      Rect.fromCenter(center: Offset(sx + 14, sy), width: 10, height: 3),
      Paint()..color = const Color(0xFF1565C0).withValues(alpha: 0.8),
    );

    // Signal cone (downward)
    final signalPath = Path()
      ..moveTo(sx, sy + 3)
      ..lineTo(cx - 15, cy - 20)
      ..lineTo(cx + 15, cy - 20)
      ..close();
    canvas.drawPath(signalPath, Paint()..color = const Color(0xFF00C853).withValues(alpha: 0.1 + pulse * 0.1));

    // Label
    final tp = TextPainter(
      text: const TextSpan(text: 'SAT-LEO\n550km', style: TextStyle(color: Color(0xFFD4AF37), fontSize: 8, fontWeight: FontWeight.bold)),
      textDirection: TextDirection.ltr,
    )..layout();
    tp.paint(canvas, Offset(sx + 8, sy - 16));
  }

  @override
  bool shouldRepaint(covariant _OrbitPainter oldDelegate) => true;
}
