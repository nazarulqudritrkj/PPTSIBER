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
  late final AnimationController _globeCtrl;
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
    _orbitCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 14))..repeat();
    _globeCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 36))..repeat();
    _blipCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 900))..repeat(reverse: true);
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _sweepCtrl.dispose();
    _orbitCtrl.dispose();
    _globeCtrl.dispose();
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
            'Integrasi TacticalRadarWidget (360° sweep real-time) dan SatelliteOrbitWidget dengan rendering 3D Earth fotorealistik, tracking orbit LEO 550 km (inklinasi 97.4°), dan telemetri langsung ke kepulauan Nusantara.',
          ),
          const SizedBox(height: 12),

          Expanded(
            child: Row(
              children: [
                // ── RADAR PANEL (KIRI) ───────────────────────────────────────
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
                        // Header Radar
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
                        // Radar Display Canvas
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

                // ── 3D REALISTIC EARTH ORBIT WIDGET & METADATA (KANAN) ────────
                Expanded(
                  flex: 5,
                  child: Column(
                    children: [
                      // 3D Realistic Earth & Orbit Container
                      Expanded(
                        flex: 6,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: PptColors.emasNanggroe.withValues(alpha: 0.4), width: 1.5),
                            boxShadow: [BoxShadow(color: PptColors.shadowSoft, blurRadius: 16, offset: const Offset(0, 4))],
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              // Card Header
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 9),
                                decoration: BoxDecoration(
                                  color: PptColors.backgroundCanvas,
                                  borderRadius: const BorderRadius.vertical(top: Radius.circular(15)),
                                  border: Border(bottom: BorderSide(color: PptColors.glassBorderLight)),
                                ),
                                child: Row(
                                  children: [
                                    const Icon(Icons.public_rounded, color: PptColors.emasDeep, size: 18),
                                    const SizedBox(width: 8),
                                    Text('SatelliteOrbitWidget — 3D LEO Orbital Mechanics',
                                        style: PptTypography.cardHeader(color: PptColors.textPrimary).copyWith(fontSize: 11)),
                                    const Spacer(),
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                      decoration: BoxDecoration(
                                        color: PptColors.cyberBlue.withValues(alpha: 0.12),
                                        borderRadius: BorderRadius.circular(4),
                                        border: Border.all(color: PptColors.cyberBlue.withValues(alpha: 0.3)),
                                      ),
                                      child: Text('FRESNEL GLOW 3D',
                                          style: PptTypography.tacticalBadge(color: PptColors.cyberBlue).copyWith(fontSize: 8.5)),
                                    ),
                                  ],
                                ),
                              ),

                              // Viewport Canvas 3D Earth
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    gradient: const RadialGradient(
                                      center: Alignment(0.0, -0.2),
                                      radius: 1.2,
                                      colors: [
                                        Color(0xFF071933), // Deep aerospace navy
                                        Color(0xFF030D1B),
                                        Color(0xFF01060E),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.25)),
                                    boxShadow: const [
                                      BoxShadow(color: Color(0x3300E5FF), blurRadius: 12, spreadRadius: 1),
                                    ],
                                  ),
                                  child: Stack(
                                    children: [
                                      // 3D Earth + Orbit Canvas
                                      Positioned.fill(
                                        child: AnimatedBuilder(
                                          animation: Listenable.merge([_orbitCtrl, _globeCtrl, _pulseCtrl]),
                                          builder: (context, _) => CustomPaint(
                                            painter: _Realistic3DEarthOrbitPainter(
                                              orbitProgress: _orbitCtrl.value,
                                              globeRotation: _globeCtrl.value,
                                              pulseValue: _pulseCtrl.value,
                                            ),
                                          ),
                                        ),
                                      ),

                                      // Telemetry Floating HUD Top-Left
                                      Positioned(
                                        top: 8,
                                        left: 10,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF051329).withValues(alpha: 0.85),
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: const Color(0xFF00E5FF).withValues(alpha: 0.35)),
                                          ),
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  Container(width: 5, height: 5, decoration: const BoxDecoration(shape: BoxShape.circle, color: Color(0xFF00E5FF))),
                                                  const SizedBox(width: 4),
                                                  Text('CAKRAWALA-3A [LEO]', style: PptTypography.mono(fontSize: 8.5, color: const Color(0xFF00E5FF))),
                                                ],
                                              ),
                                              Text('ALT: 550.2 KM | INC: 97.4°', style: PptTypography.mono(fontSize: 8, color: Colors.white70)),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Downlink Status Top-Right
                                      Positioned(
                                        top: 8,
                                        right: 10,
                                        child: Container(
                                          padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 4),
                                          decoration: BoxDecoration(
                                            color: const Color(0xFF051329).withValues(alpha: 0.85),
                                            borderRadius: BorderRadius.circular(6),
                                            border: Border.all(color: PptColors.tniGreenNeon.withValues(alpha: 0.4)),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              const Icon(Icons.sensors_rounded, color: PptColors.tniGreenNeon, size: 10),
                                              const SizedBox(width: 4),
                                              Text('DOWNLINK: 1.2 Gbps', style: PptTypography.mono(fontSize: 8, color: PptColors.tniGreenNeon)),
                                            ],
                                          ),
                                        ),
                                      ),

                                      // Target Lock Footprint Bottom-Left
                                      Positioned(
                                        bottom: 8,
                                        left: 10,
                                        child: Text(
                                          'TARGET: SEKTOR NUSANTARA & LAUT NATUNA',
                                          style: PptTypography.mono(fontSize: 7.5, color: const Color(0xFFD4AF37)),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      const SizedBox(height: 10),

                      // Spesifikasi Grid 6 Kotak
                      Expanded(
                        flex: 4,
                        child: GridView.count(
                          crossAxisCount: 3,
                          mainAxisSpacing: 6,
                          crossAxisSpacing: 6,
                          childAspectRatio: 2.2,
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
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 5),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value, style: PptTypography.tacticalBadge(color: color).copyWith(fontSize: 9.5), overflow: TextOverflow.ellipsis),
                Text(label, style: PptTypography.bodySmall(color: PptColors.textMuted).copyWith(fontSize: 8.5)),
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

// ── 3D REALISTIC EARTH ORBIT PAINTER ─────────────────────────────────────────
class _Realistic3DEarthOrbitPainter extends CustomPainter {
  final double orbitProgress;
  final double globeRotation;
  final double pulseValue;

  _Realistic3DEarthOrbitPainter({
    required this.orbitProgress,
    required this.globeRotation,
    required this.pulseValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width * 0.48, size.height * 0.52);
    final earthRadius = math.min(size.width, size.height) * 0.32;

    // 1. STARFIELD PARTICLES
    _drawStarfield(canvas, size);

    // 2. ATMOSPHERE FRESNEL GLOW (Rayleigh Scattering Rim)
    _drawAtmosphereGlow(canvas, center, earthRadius);

    // 3. 3D SPHERICAL EARTH BODY WITH DAY/NIGHT SHADING
    _drawEarthSphere(canvas, center, earthRadius);

    // 4. ROTATING HOLOGRAPHIC GRATICULE (Equator & Meridians)
    _drawGraticule(canvas, center, earthRadius);

    // 5. ROTATING RECOGNIZABLE CONTINENTS (Nusantara Front & Center)
    _drawContinents(canvas, center, earthRadius);

    // 6. NIGHT-SIDE TACTICAL CITY LIGHTS
    _drawCityLights(canvas, center, earthRadius);

    // 7. DYNAMIC SUN-SYNCHRONOUS LEO ORBIT (Inclination 97.4°)
    _drawOrbitalMechanics(canvas, center, earthRadius);

    // 8. SATELLITE VEHICLE & REAL-TIME TELEMETRY SCAN CONE
    _drawSatelliteVehicle(canvas, center, earthRadius);
  }

  void _drawStarfield(Canvas canvas, Size size) {
    final starRandom = math.Random(101);
    for (int i = 0; i < 48; i++) {
      final sx = starRandom.nextDouble() * size.width;
      final sy = starRandom.nextDouble() * size.height;
      final r = 0.6 + starRandom.nextDouble() * 1.4;
      final twinkle = 0.4 + 0.6 * math.sin(i + orbitProgress * 2 * math.pi);
      canvas.drawCircle(
        Offset(sx, sy),
        r,
        Paint()..color = Colors.white.withValues(alpha: (twinkle * 0.7).clamp(0.1, 0.8)),
      );
    }
  }

  void _drawAtmosphereGlow(Canvas canvas, Offset center, double radius) {
    // Outer Rayleigh Scattering Halo
    final outerGlow = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.22 + pulseValue * 0.08)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 22);
    canvas.drawCircle(center, radius + 12, outerGlow);

    // Secondary Cyan Ionosphere Glow
    final ionoGlow = Paint()
      ..color = const Color(0xFF0072FF).withValues(alpha: 0.35)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawCircle(center, radius + 4, ionoGlow);

    // Thin Crisp Limb Ring (Fresnel Edge)
    final limbPaint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.8
      ..shader = const SweepGradient(
        colors: [
          Color(0xFF80D8FF),
          Color(0xFF00E5FF),
          Color(0x330072FF),
          Color(0xFF80D8FF),
        ],
      ).createShader(Rect.fromCircle(center: center, radius: radius + 1));
    canvas.drawCircle(center, radius + 1, limbPaint);
  }

  void _drawEarthSphere(Canvas canvas, Offset center, double radius) {
    final sphereRect = Rect.fromCircle(center: center, radius: radius);

    // 3D Spherical Shader: Top-left sunlight to bottom-right deep oceanic night
    final oceanShader = RadialGradient(
      center: const Alignment(-0.4, -0.45),
      radius: 0.95,
      colors: const [
        Color(0xFF1E88E5), // Sunlit azure ocean
        Color(0xFF0D47A1), // Deep maritime navy
        Color(0xFF06234B),
        Color(0xFF020E22), // Deep shadow night side
      ],
      stops: const [0.0, 0.40, 0.75, 1.0],
    ).createShader(sphereRect);

    canvas.drawCircle(center, radius, Paint()..shader = oceanShader);
  }

  void _drawGraticule(Canvas canvas, Offset center, double radius) {
    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: radius)));

    // Latitudes (Horizontal Rings)
    final latPaint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.15)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 0.8;

    final equatorPaint = Paint()
      ..color = const Color(0xFF00E5FF).withValues(alpha: 0.38)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    for (double lat = -60; lat <= 60; lat += 20) {
      final rad = lat * math.pi / 180;
      final yOff = radius * math.sin(rad);
      final rAtLat = radius * math.cos(rad);

      final rect = Rect.fromCenter(
        center: Offset(center.dx, center.dy + yOff),
        width: rAtLat * 2,
        height: rAtLat * 0.40,
      );
      canvas.drawOval(rect, lat == 0 ? equatorPaint : latPaint);
    }

    // Longitudes (Rotating Meridians)
    for (int i = 0; i < 8; i++) {
      final baseAngle = (i * math.pi / 4) + (globeRotation * 2 * math.pi);
      final normAngle = baseAngle % (2 * math.pi);
      final cosVal = math.cos(normAngle);
      final isFront = math.sin(normAngle) >= 0;

      final meridianPaint = Paint()
        ..color = const Color(0xFF00E5FF).withValues(alpha: isFront ? 0.20 : 0.06)
        ..style = PaintingStyle.stroke
        ..strokeWidth = isFront ? 0.9 : 0.5;

      final rect = Rect.fromCenter(
        center: center,
        width: (radius * 2 * cosVal.abs()).clamp(1.0, radius * 2),
        height: radius * 2,
      );
      canvas.drawOval(rect, meridianPaint);
    }

    canvas.restore();
  }

  void _drawContinents(Canvas canvas, Offset center, double radius) {
    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: radius)));

    final rotOffset = globeRotation * 2 * math.pi;

    final landmasses = [
      // (Longitude Fraction, Latitude Y Fraction, Width Fraction, Height Fraction, Name)
      _LandData(0.24, -0.05, 0.46, 0.18, 'NUSANTARA'),  // Indonesia (Sumatra/Java/Kal/Sul/Papua)
      _LandData(0.38, -0.42, 0.35, 0.26, 'AUSTRALIA'),  // Australia
      _LandData(0.18, 0.36, 0.55, 0.34, 'EAST ASIA'),   // Asia mainland
      _LandData(0.06, 0.18, 0.28, 0.22, 'INDIA'),       // Indian subcontinent
      _LandData(0.86, 0.35, 0.45, 0.28, 'EUROPE'),      // Europe
      _LandData(0.78, -0.08, 0.38, 0.42, 'AFRICA'),     // Africa
      _LandData(0.58, 0.32, 0.42, 0.35, 'N.AMERICA'),   // North America
      _LandData(0.64, -0.25, 0.32, 0.42, 'S.AMERICA'),  // South America
    ];

    for (final land in landmasses) {
      final angle = land.lon * 2 * math.pi + rotOffset;
      final xOffset = radius * math.sin(angle);
      final cosVal = math.cos(angle);
      final isFront = cosVal > -0.25;

      if (!isFront) continue; // culled on back side of globe

      final pos = Offset(center.dx + xOffset, center.dy + land.lat * radius);
      final w = land.w * radius * (cosVal.abs() * 0.6 + 0.4);
      final h = land.h * radius;

      // Realistic Emerald/Forest Green Continent Tone
      final isNusantara = land.name == 'NUSANTARA';
      final fillPaint = Paint()
        ..color = (isNusantara ? const Color(0xFF2E7D32) : const Color(0xFF1B5E20))
            .withValues(alpha: isNusantara ? 0.75 : 0.55)
        ..style = PaintingStyle.fill;

      final strokePaint = Paint()
        ..color = (isNusantara ? const Color(0xFF69F0AE) : const Color(0xFF4CAF50))
            .withValues(alpha: isNusantara ? 0.90 : 0.65)
        ..style = PaintingStyle.stroke
        ..strokeWidth = isNusantara ? 1.4 : 0.9;

      final rect = Rect.fromCenter(center: pos, width: w, height: h);
      canvas.drawOval(rect, fillPaint);
      canvas.drawOval(rect, strokePaint);

      // If Nusantara: draw extra islands cluster for recognizable archipelago detail
      if (isNusantara) {
        final islandPaint = Paint()..color = const Color(0xFF81C784)..style = PaintingStyle.fill;
        // Sumatra
        canvas.drawOval(Rect.fromCenter(center: Offset(pos.dx - w * 0.32, pos.dy + h * 0.1), width: w * 0.28, height: h * 0.45), islandPaint);
        // Java
        canvas.drawOval(Rect.fromCenter(center: Offset(pos.dx - w * 0.05, pos.dy + h * 0.28), width: w * 0.35, height: h * 0.25), islandPaint);
        // Kalimantan
        canvas.drawOval(Rect.fromCenter(center: Offset(pos.dx - w * 0.05, pos.dy - h * 0.12), width: w * 0.26, height: h * 0.35), islandPaint);
        // Sulawesi
        canvas.drawOval(Rect.fromCenter(center: Offset(pos.dx + w * 0.18, pos.dy - h * 0.05), width: w * 0.18, height: h * 0.32), islandPaint);
        // Papua
        canvas.drawOval(Rect.fromCenter(center: Offset(pos.dx + w * 0.36, pos.dy + h * 0.02), width: w * 0.28, height: h * 0.30), islandPaint);

        // Tactical Target Marker on Nusantara
        canvas.drawCircle(pos, 3, Paint()..color = const Color(0xFFCC0001));
        canvas.drawCircle(pos, 6, Paint()..color = const Color(0xFFD4AF37)..style = PaintingStyle.stroke..strokeWidth = 0.8);
      }
    }

    canvas.restore();
  }

  void _drawCityLights(Canvas canvas, Offset center, double radius) {
    canvas.save();
    canvas.clipPath(Path()..addOval(Rect.fromCircle(center: center, radius: radius)));

    // Golden clusters on the dark shadow side (right hemisphere)
    final cities = [
      const Offset(0.35, -0.05), // Jakarta/Singapore cluster
      const Offset(0.42, 0.25),  // Tokyo cluster
      const Offset(0.50, -0.35), // Sydney cluster
    ];

    for (final c in cities) {
      final pos = Offset(center.dx + c.dx * radius, center.dy + c.dy * radius);
      canvas.drawCircle(pos, 1.8, Paint()..color = const Color(0xFFFFD54F).withValues(alpha: 0.85));
      canvas.drawCircle(
        pos,
        4.0,
        Paint()..color = const Color(0xFFFFB300).withValues(alpha: 0.35)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 3),
      );
    }

    canvas.restore();
  }

  void _drawOrbitalMechanics(Canvas canvas, Offset center, double radius) {
    // 1. Primary LEO Sun-Synchronous Orbit (Inclination 97.4° ~ 1.70 rad)
    final semiMajor = radius * 1.55;
    final semiMinor = radius * 0.65;
    const inclination = 1.70; // 97.4 degrees

    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(inclination);

    final orbitRect = Rect.fromCenter(center: Offset.zero, width: semiMajor * 2, height: semiMinor * 2);

    // Subtle golden outer glow
    canvas.drawOval(
      orbitRect,
      Paint()
        ..color = PptColors.emasNanggroe.withValues(alpha: 0.20)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 3.5
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 5),
    );

    // Golden crisp orbital trajectory line
    canvas.drawOval(
      orbitRect,
      Paint()
        ..color = PptColors.emasNanggroe.withValues(alpha: 0.70)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2,
    );

    canvas.restore();

    // 2. Secondary Equatorial/Inclined Orbit (SAT-RECON)
    canvas.save();
    canvas.translate(center.dx, center.dy);
    canvas.rotate(-0.45);
    final secRect = Rect.fromCenter(center: Offset.zero, width: radius * 1.38 * 2, height: radius * 0.50 * 2);
    canvas.drawOval(
      secRect,
      Paint()
        ..color = const Color(0xFF00E5FF).withValues(alpha: 0.35)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 0.9,
    );
    canvas.restore();
  }

  void _drawSatelliteVehicle(Canvas canvas, Offset center, double radius) {
    final semiMajor = radius * 1.55;
    final semiMinor = radius * 0.65;
    const inclination = 1.70;

    final angle = orbitProgress * 2 * math.pi;

    // Position calculation on rotated ellipse
    final x0 = semiMajor * math.cos(angle);
    final y0 = semiMinor * math.sin(angle);
    final satX = center.dx + (x0 * math.cos(inclination) - y0 * math.sin(inclination));
    final satY = center.dy + (x0 * math.sin(inclination) + y0 * math.cos(inclination));
    final satPos = Offset(satX, satY);

    // Front/Back depth check
    final isFront = math.sin(angle) >= -0.25;

    // 1. Dynamic Downlink Telemetry Cone to Earth (pointing toward Nusantara)
    if (isFront) {
      final targetGround = Offset(center.dx - 12, center.dy + 8);

      final beamPath = Path()
        ..moveTo(satPos.dx, satPos.dy)
        ..lineTo(targetGround.dx - 18, targetGround.dy - 6)
        ..lineTo(targetGround.dx + 18, targetGround.dy + 6)
        ..close();

      final beamShader = LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          const Color(0xFF00E5FF).withValues(alpha: 0.40),
          const Color(0xFF00C853).withValues(alpha: 0.08),
        ],
      ).createShader(Rect.fromPoints(satPos, targetGround));

      canvas.drawPath(beamPath, Paint()..shader = beamShader);

      // Ground Scan Target Footprint Ring on Earth
      canvas.drawOval(
        Rect.fromCenter(center: targetGround, width: 36, height: 16),
        Paint()
          ..color = const Color(0xFF00E5FF).withValues(alpha: 0.70)
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1.2,
      );
    }

    // 2. Pulse Ring
    final pulseScale = (orbitProgress * 3) % 1.0;
    canvas.drawCircle(
      satPos,
      8 + pulseScale * 14,
      Paint()
        ..color = const Color(0xFF00E5FF).withValues(alpha: (1.0 - pulseScale).clamp(0.0, 0.6))
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // 3. Satellite Core & Solar Panel Wings
    final wingPaint = Paint()..color = const Color(0xFF00E5FF)..style = PaintingStyle.fill;
    final bodyPaint = Paint()..color = Colors.white..style = PaintingStyle.fill;

    // Left & Right Wings
    canvas.drawRect(Rect.fromCenter(center: Offset(satPos.dx - 9, satPos.dy), width: 8, height: 4), wingPaint);
    canvas.drawRect(Rect.fromCenter(center: Offset(satPos.dx + 9, satPos.dy), width: 8, height: 4), wingPaint);

    // Core body
    canvas.drawCircle(satPos, 4.5, bodyPaint);
    canvas.drawCircle(
      satPos,
      6.0,
      Paint()..color = const Color(0xFFD4AF37).withValues(alpha: 0.7)..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );

    // 4. Tactical Callout Label
    final tp = TextPainter(
      text: const TextSpan(
        text: 'CAKRAWALA-3A\nLEO-550km [ACTIVE]',
        style: TextStyle(
          fontSize: 8.5,
          fontWeight: FontWeight.bold,
          color: Color(0xFF00E5FF),
          fontFamily: 'monospace',
          shadows: [Shadow(color: Colors.black, blurRadius: 4)],
        ),
      ),
      textDirection: TextDirection.ltr,
    )..layout();

    tp.paint(canvas, Offset(satPos.dx + 12, satPos.dy - 10));
  }

  @override
  bool shouldRepaint(covariant _Realistic3DEarthOrbitPainter old) => true;
}

class _LandData {
  final double lon;
  final double lat;
  final double w;
  final double h;
  final String name;
  const _LandData(this.lon, this.lat, this.w, this.h, this.name);
}

// ── TACTICAL RADAR CANVAS PAINTER ───────────────────────────────────────────
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
