import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/ppt_colors.dart';

/// CustomPainter untuk Ornamen Geometris Sumatera / Pintu Aceh & Songket Taktis
/// Menghadirkan identitas visual Nanggroe yang agung dan elegan pada tema terang.
class SumateraOrnamentPainter extends CustomPainter {
  final Color primaryColor;
  final Color secondaryColor;
  final double opacity;
  final double animationValue;

  const SumateraOrnamentPainter({
    this.primaryColor = PptColors.emasNanggroe,
    this.secondaryColor = PptColors.merahIndonesia,
    this.opacity = 0.08,
    this.animationValue = 0.0,
  });

  @override
  void paint(Canvas canvas, Size size) {
    if (size.width <= 0 || size.height <= 0) return;

    final paintGold = Paint()
      ..color = primaryColor.withValues(alpha: opacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2
      ..isAntiAlias = true;

    final paintRed = Paint()
      ..color = secondaryColor.withValues(alpha: opacity * 0.8)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0
      ..isAntiAlias = true;

    // 1. Ornamen Pintu Aceh di Pojok Kiri Atas
    _drawPintuAcehCorner(canvas, const Offset(60, 60), 45, paintGold, paintRed);

    // 2. Ornamen Pintu Aceh di Pojok Kanan Bawah
    _drawPintuAcehCorner(
      canvas,
      Offset(size.width - 60, size.height - 60),
      45,
      paintGold,
      paintRed,
      rotation: math.pi,
    );

    // 3. Grid Garis Fraktal Songket Taktis Tipis di Latar Belakang
    _drawSongketTacticalGrid(canvas, size, paintGold);
  }

  void _drawPintuAcehCorner(
    Canvas canvas,
    Offset center,
    double radius,
    Paint pGold,
    Paint pRed, {
    double rotation = 0,
  }) {
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(rotation + (animationValue * math.pi * 0.05));

    // Kubah Lengkung Pintu Aceh
    final pathDome = Path();
    pathDome.moveTo(-radius, radius);
    pathDome.lineTo(-radius, 0);
    pathDome.cubicTo(-radius, -radius * 0.8, -radius * 0.3, -radius * 1.2, 0, -radius * 1.3);
    pathDome.cubicTo(radius * 0.3, -radius * 1.2, radius, -radius * 0.8, radius, 0);
    pathDome.lineTo(radius, radius);
    pathDome.close();
    canvas.drawPath(pathDome, pGold);

    // Bintang Segi Delapan di Pusat
    _draw8PointStar(canvas, Offset.zero, radius * 0.45, pRed);

    // Rombus / Belah Ketupat Luar
    final pathDiamond = Path();
    pathDiamond.moveTo(0, -radius * 1.4);
    pathDiamond.lineTo(radius * 1.2, 0);
    pathDiamond.lineTo(0, radius * 1.4);
    pathDiamond.lineTo(-radius * 1.2, 0);
    pathDiamond.close();
    canvas.drawPath(pathDiamond, pGold);

    canvas.restore();
  }

  void _draw8PointStar(Canvas canvas, Offset center, double r, Paint paint) {
    final path = Path();
    for (int i = 0; i < 8; i++) {
      final double angle = i * math.pi / 4;
      final double x = center.dx + r * math.cos(angle);
      final double y = center.dy + r * math.sin(angle);

      final double midAngle = angle + math.pi / 8;
      final double midX = center.dx + (r * 0.5) * math.cos(midAngle);
      final double midY = center.dy + (r * 0.5) * math.sin(midAngle);

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
      path.lineTo(midX, midY);
    }
    path.close();
    canvas.drawPath(path, paint);
  }

  void _drawSongketTacticalGrid(Canvas canvas, Size size, Paint paint) {
    // Garis diagonal chevron tipis di tepi atas dan bawah
    const double step = 36.0;
    final pathTop = Path();
    for (double x = 0; x < size.width; x += step) {
      pathTop.moveTo(x, 0);
      pathTop.lineTo(x + step / 2, 10);
      pathTop.lineTo(x + step, 0);
    }
    canvas.drawPath(pathTop, paint);

    final pathBottom = Path();
    for (double x = 0; x < size.width; x += step) {
      pathBottom.moveTo(x, size.height);
      pathBottom.lineTo(x + step / 2, size.height - 10);
      pathBottom.lineTo(x + step, size.height);
    }
    canvas.drawPath(pathBottom, paint);
  }

  @override
  bool shouldRepaint(covariant SumateraOrnamentPainter oldDelegate) {
    return oldDelegate.animationValue != animationValue ||
        oldDelegate.opacity != opacity ||
        oldDelegate.primaryColor != primaryColor;
  }
}

