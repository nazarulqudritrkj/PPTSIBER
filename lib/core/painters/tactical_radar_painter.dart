import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/ppt_colors.dart';

/// Tactical Radar Painter untuk tema terang (Light Glass Radar)
class TacticalRadarPainter extends CustomPainter {
  final double sweepAngle; // 0.0 s/d 2 * pi
  final List<Offset> blips;

  TacticalRadarPainter({
    required this.sweepAngle,
    this.blips = const [
      Offset(0.3, -0.4),
      Offset(-0.5, 0.2),
      Offset(0.6, 0.5),
      Offset(-0.2, -0.6),
    ],
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = math.min(size.width, size.height) / 2 - 8;

    if (radius <= 0) return;

    // 1. Lingkaran Luar & Grid Konsentris
    final gridPaint = Paint()
      ..color = PptColors.tniGreenAccent.withValues(alpha: 0.25)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 1; i <= 4; i++) {
      canvas.drawCircle(center, radius * (i / 4), gridPaint);
    }

    // 2. Garis Salib Kardinal
    final crossPaint = Paint()
      ..color = PptColors.tniGreenAccent.withValues(alpha: 0.3)
      ..strokeWidth = 1.0;
    canvas.drawLine(Offset(center.dx - radius, center.dy), Offset(center.dx + radius, center.dy), crossPaint);
    canvas.drawLine(Offset(center.dx, center.dy - radius), Offset(center.dx, center.dy + radius), crossPaint);

    // 3. Sapuan Sudut Radar (Sweep Beam with Gradient)
    final sweepPaint = Paint()
      ..shader = SweepGradient(
        center: FractionalOffset.center,
        startAngle: 0.0,
        endAngle: math.pi / 2,
        colors: [
          PptColors.tniGreenNeon.withValues(alpha: 0.45),
          PptColors.tniGreenNeon.withValues(alpha: 0.0),
        ],
        transform: GradientRotation(sweepAngle - math.pi / 2),
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.fill;

    canvas.drawCircle(center, radius, sweepPaint);

    // Garis ujung jarum sapuan
    final needleX = center.dx + radius * math.cos(sweepAngle);
    final needleY = center.dy + radius * math.sin(sweepAngle);
    final needlePaint = Paint()
      ..color = PptColors.tniGreenNeon
      ..strokeWidth = 2.0;
    canvas.drawLine(center, Offset(needleX, needleY), needlePaint);

    // 4. Blip Sasaran Radar
    final blipPaint = Paint()
      ..color = PptColors.merahVibrant
      ..style = PaintingStyle.fill;

    final blipGlow = Paint()
      ..color = PptColors.merahVibrant.withValues(alpha: 0.4)
      ..style = PaintingStyle.fill;

    for (final blip in blips) {
      final pos = Offset(center.dx + blip.dx * radius, center.dy + blip.dy * radius);
      canvas.drawCircle(pos, 6, blipGlow);
      canvas.drawCircle(pos, 3, blipPaint);
    }

    // Titik Tengah Komando
    canvas.drawCircle(center, 4, Paint()..color = PptColors.emasNanggroe);
  }

  @override
  bool shouldRepaint(covariant TacticalRadarPainter oldDelegate) {
    return oldDelegate.sweepAngle != sweepAngle;
  }
}

