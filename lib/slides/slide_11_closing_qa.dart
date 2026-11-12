import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../core/theme/ppt_colors.dart';
import '../core/theme/ppt_typography.dart';
import '../core/audio/tactical_audio_service.dart';
import 'slide_02_threat_landscape.dart' show sectionHeader;

class Slide11ClosingQa extends StatefulWidget {
  final VoidCallback onRestart;
  const Slide11ClosingQa({super.key, required this.onRestart});

  @override
  State<Slide11ClosingQa> createState() => _Slide11ClosingQaState();
}

class _Slide11ClosingQaState extends State<Slide11ClosingQa>
    with TickerProviderStateMixin {
  late final AnimationController _pulseCtrl;
  late final AnimationController _staggerCtrl;
  late final AnimationController _shieldCtrl;

  final List<_PillarData> _pillars = const [
    _PillarData('01', 'Radar 360°', 'TacticalRadarWidget\nreal-time 24/7', Icons.radar_rounded, Color(0xFF00C853)),
    _PillarData('02', 'Orbit Satelit', 'LEO 550km · SAR 0.5m\nSun-Sync 97.4°', Icons.satellite_alt_rounded, Color(0xFF6A1B9A)),
    _PillarData('03', 'AI Inferensi', 'BERT-Military 3.8ms\nAPT-29 Detection', Icons.psychology_rounded, Color(0xFF1565C0)),
    _PillarData('04', 'Blockchain', 'PBFT 15 Kodam\n48.285+ Blok Blake3', Icons.link_rounded, Color(0xFFD4AF37)),
    _PillarData('05', 'Kriptografi PQC', 'Kyber-1024 + Dilithium\nNIST Level 5', Icons.lock_rounded, Color(0xFFCC0001)),
    _PillarData('06', 'Field Terminal', 'Satgas 01-04 GPS\nRadio Hopping 50ms', Icons.terminal_rounded, Color(0xFF00838F)),
    _PillarData('07', 'Regional Admin', '15 Kodam Interaktif\nUserActivityMonitor', Icons.map_rounded, Color(0xFF1A3A28)),
    _PillarData('08', 'C2 Console', '128 Perintah Taktis\nCommandManualModal', Icons.dashboard_rounded, Color(0xFFF57F17)),
  ];

  @override
  void initState() {
    super.initState();
    _pulseCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2400))..repeat(reverse: true);
    _shieldCtrl = AnimationController(vsync: this, duration: const Duration(seconds: 25))..repeat();
    _staggerCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 1200))..forward();
  }

  @override
  void dispose() {
    _pulseCtrl.dispose();
    _staggerCtrl.dispose();
    _shieldCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 40, 40, 36),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          sectionHeader(
            'BAB 10 // KESIMPULAN STRATEGIS & TANYA JAWAB',
            PptColors.merahIndonesia,
            'Penutup — Kedaulatan Siber Republik Indonesia',
            'SI-CAKRAWALA: 8 Pilar Pertahanan Digital TNI AD — Siap Menjaga NKRI dari Ancaman Siber Generasi Ke-5.',
          ),
          const SizedBox(height: 10),

          Expanded(
            child: Row(
              children: [
                // ── 8 PILAR GRID ─────────────────────────────────────────────
                Expanded(
                  flex: 7,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 8,
                      crossAxisSpacing: 8,
                      childAspectRatio: 1.6,
                    ),
                    itemCount: _pillars.length,
                    itemBuilder: (ctx, i) {
                      final delay = i * 0.1;
                      final animInterval = CurvedAnimation(
                        parent: _staggerCtrl,
                        curve: Interval(delay, (delay + 0.4).clamp(0, 1), curve: Curves.easeOut),
                      );
                      return FadeTransition(
                        opacity: animInterval,
                        child: SlideTransition(
                          position: Tween<Offset>(begin: const Offset(0, 0.3), end: Offset.zero)
                              .animate(animInterval),
                          child: _PillarCard(pillar: _pillars[i]),
                        ),
                      );
                    },
                  ),
                ),

                const SizedBox(width: 16),

                // ── KANAN: Closing + Q&A ──────────────────────────────────────
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      // Shield visualizer
                      Expanded(
                        flex: 5,
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: PptColors.merahIndonesia.withValues(alpha: 0.3), width: 1.5),
                            boxShadow: [BoxShadow(color: PptColors.shadowSoft, blurRadius: 16, offset: const Offset(0, 4))],
                          ),
                          child: AnimatedBuilder(
                            animation: Listenable.merge([_shieldCtrl, _pulseCtrl]),
                            builder: (context, child) => CustomPaint(
                              painter: _ShieldClosingPainter(spin: _shieldCtrl.value, pulse: _pulseCtrl.value),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    const SizedBox(height: 60),
                                    Text('KEDAULATAN SIBER', style: PptTypography.tacticalBadge(color: PptColors.merahIndonesia)),
                                    Text('HARGA MATI', style: PptTypography.cardHeader(color: PptColors.merahIndonesia)),
                                    const SizedBox(height: 4),
                                    Text('INDONESIA EMAS 2045', style: PptTypography.bodySmall(color: PptColors.emasDeep)),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Terminal Quote
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                        decoration: BoxDecoration(
                          color: const Color(0xFF0A1628),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: PptColors.tniGreenNeon.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.terminal_rounded, color: PptColors.tniGreenNeon, size: 14),
                            const SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                r'$ echo "NKRI Harga Mati!"',
                                style: PptTypography.mono(fontSize: 10, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Q&A Box
                      Expanded(
                        flex: 4,
                        child: Container(
                          padding: const EdgeInsets.all(14),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(14),
                            border: Border.all(color: PptColors.emasNanggroe.withValues(alpha: 0.4), width: 1.5),
                            boxShadow: [BoxShadow(color: PptColors.shadowSoft, blurRadius: 12, offset: const Offset(0, 3))],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              AnimatedBuilder(
                                animation: _pulseCtrl,
                                builder: (context, child) => Container(
                                  width: 48, height: 48,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: PptColors.emasNanggroe.withValues(alpha: 0.1 + _pulseCtrl.value * 0.08),
                                  ),
                                  child: const Icon(Icons.question_answer_rounded, color: PptColors.emasDeep, size: 26),
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text('SESI TANYA JAWAB', style: PptTypography.cardHeader(color: PptColors.textPrimary)),
                              const SizedBox(height: 4),
                              Text(
                                'Dipersilakan kepada dewan juri untuk memberikan tanggapan & pertanyaan.',
                                textAlign: TextAlign.center,
                                style: PptTypography.bodySmall(color: PptColors.textSecondary),
                              ),
                              const SizedBox(height: 12),
                              ElevatedButton.icon(
                                onPressed: () {
                                  TacticalAudioService.playClick();
                                  widget.onRestart();
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: PptColors.merahIndonesia,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                icon: const Icon(Icons.replay_rounded, size: 14),
                                label: Text('ULANGI PRESENTASI', style: PptTypography.tacticalBadge(color: Colors.white)),
                              ),
                            ],
                          ),
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
}

class _PillarCard extends StatefulWidget {
  final _PillarData pillar;
  const _PillarCard({required this.pillar});

  @override
  State<_PillarCard> createState() => _PillarCardState();
}

class _PillarCardState extends State<_PillarCard> {
  bool _hovered = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovered = true),
      onExit: (_) => setState(() => _hovered = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: _hovered ? widget.pillar.color.withValues(alpha: 0.08) : Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _hovered ? widget.pillar.color : widget.pillar.color.withValues(alpha: 0.3),
            width: _hovered ? 2 : 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: _hovered ? widget.pillar.color.withValues(alpha: 0.2) : PptColors.shadowSoft,
              blurRadius: _hovered ? 16 : 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(widget.pillar.number,
                    style: PptTypography.mono(fontSize: 9, color: widget.pillar.color.withValues(alpha: 0.6))),
                const Spacer(),
                Icon(widget.pillar.icon, color: widget.pillar.color, size: 18),
              ],
            ),
            const SizedBox(height: 4),
            Text(widget.pillar.title, style: PptTypography.cardHeader(color: widget.pillar.color).copyWith(fontSize: 11)),
            const SizedBox(height: 2),
            Expanded(
              child: Text(
                widget.pillar.desc,
                style: PptTypography.bodySmall(color: PptColors.textSecondary).copyWith(fontSize: 9),
                overflow: TextOverflow.fade,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PillarData {
  final String number;
  final String title;
  final String desc;
  final IconData icon;
  final Color color;
  const _PillarData(this.number, this.title, this.desc, this.icon, this.color);
}

class _ShieldClosingPainter extends CustomPainter {
  final double spin;
  final double pulse;
  const _ShieldClosingPainter({required this.spin, required this.pulse});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final cy = size.height / 2;

    // Outer ring
    canvas.drawCircle(Offset(cx, cy), 50 + pulse * 4,
        Paint()..color = const Color(0xFFCC0001).withValues(alpha: 0.08 + pulse * 0.05)..style = PaintingStyle.stroke..strokeWidth = 2);

    // Rotating ring (gold)
    for (int i = 0; i < 8; i++) {
      final angle = spin * 2 * math.pi + i * math.pi / 4;
      final x = cx + 44 * math.cos(angle);
      final y = cy + 44 * math.sin(angle);
      canvas.drawCircle(Offset(x, y), 3, Paint()..color = const Color(0xFFD4AF37).withValues(alpha: 0.5));
    }

    // Inner shield icon
    final shieldPath = Path()
      ..moveTo(cx, cy - 36)
      ..lineTo(cx + 26, cy - 20)
      ..lineTo(cx + 26, cy + 10)
      ..quadraticBezierTo(cx + 26, cy + 36, cx, cy + 46)
      ..quadraticBezierTo(cx - 26, cy + 36, cx - 26, cy + 10)
      ..lineTo(cx - 26, cy - 20)
      ..close();
    canvas.drawPath(shieldPath, Paint()
      ..color = const Color(0xFFCC0001).withValues(alpha: 0.12 + pulse * 0.06)
      ..style = PaintingStyle.fill);
    canvas.drawPath(shieldPath, Paint()
      ..color = const Color(0xFFCC0001)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5);
  }

  @override
  bool shouldRepaint(covariant _ShieldClosingPainter oldDelegate) => true;
}
