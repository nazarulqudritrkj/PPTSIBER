import 'package:flutter/material.dart';
import '../core/theme/ppt_colors.dart';
import '../core/theme/ppt_typography.dart';
import '../core/audio/tactical_audio_service.dart';
import 'slide_02_threat_landscape.dart' show sectionHeader;

class Slide09LiveShowcase extends StatefulWidget {
  const Slide09LiveShowcase({super.key});

  @override
  State<Slide09LiveShowcase> createState() => _Slide09LiveShowcaseState();
}

class _Slide09LiveShowcaseState extends State<Slide09LiveShowcase>
    with SingleTickerProviderStateMixin {
  late final AnimationController _glowCtrl;
  int _hoveredModule = -1;

  final List<_ModuleInfo> _modules = const [
    _ModuleInfo(
      icon: Icons.dashboard_customize_rounded,
      name: 'Dashboard Utama',
      desc: 'Pusat komando multi-panel: radar, satelit, AI log, dan metrik jaringan real-time dalam satu layar.',
      color: Color(0xFF1A3A28),
    ),
    _ModuleInfo(
      icon: Icons.psychology_rounded,
      name: 'AI Intelligence',
      desc: 'Inferensi ancaman 3.8ms · APT detection · DNS sinkhole otomatis · BERT-Military-v4 model.',
      color: Color(0xFF1565C0),
    ),
    _ModuleInfo(
      icon: Icons.radar_rounded,
      name: 'Radar Taktis',
      desc: 'TacticalRadarWidget 360° · 5 blip tracking · HF/VHF/SATCOM · RadarControlPanel real-time.',
      color: Color(0xFF00C853),
    ),
    _ModuleInfo(
      icon: Icons.link_rounded,
      name: 'Blockchain',
      desc: '48.285+ blok · Blake3 hash · PBFT 15 Kodam · BlockchainMetricsHeader + TacticalBlockList.',
      color: Color(0xFFD4AF37),
    ),
    _ModuleInfo(
      icon: Icons.satellite_alt_rounded,
      name: 'Orbit Satelit',
      desc: 'SatelliteOrbitWidget LEO 550km · inklinasi 97.4° · RealisticGlobeWidget dengan earth texture.',
      color: Color(0xFF6A1B9A),
    ),
    _ModuleInfo(
      icon: Icons.map_rounded,
      name: 'Regional Admin',
      desc: '15 Kodam interaktif: Hover detail · UserActivityMonitor · administrasi regional tersentralisasi.',
      color: Color(0xFFCC0001),
    ),
    _ModuleInfo(
      icon: Icons.terminal_rounded,
      name: 'C2 Console',
      desc: 'CyberCommandConsole · Tab autocomplete · CommandManualModal · 128 perintah taktis terdaftar.',
      color: Color(0xFF00838F),
    ),
    _ModuleInfo(
      icon: Icons.people_rounded,
      name: 'Field Operations',
      desc: 'Satgas Siber 01-04 · GPS tracking · Radio hopping 433.825 MHz · ECCM 50ms interval.',
      color: Color(0xFFF57F17),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _glowCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 2000))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _glowCtrl.dispose();
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
            'BAB 08 // VERIFIKASI & DEMONSTRASI LANGSUNG',
            PptColors.merahIndonesia,
            'Live Showcase — 8 Modul Operasional SI-CAKRAWALA',
            'Setiap modul di bawah ini dapat diakses langsung di nazarulqudritrkj.github.io/siber — tanpa instalasi, siap dioperasikan melalui browser standar dengan performa 60 FPS CanvasKit.',
          ),
          const SizedBox(height: 14),

          Expanded(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── GRID MODUL (8 cards) ─────────────────────────────────────
                Expanded(
                  flex: 7,
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 10,
                      childAspectRatio: 1.5,
                    ),
                    itemCount: _modules.length,
                    itemBuilder: (ctx, i) => MouseRegion(
                      onEnter: (_) => setState(() => _hoveredModule = i),
                      onExit: (_) => setState(() => _hoveredModule = -1),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        curve: Curves.easeOut,
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: _hoveredModule == i
                              ? _modules[i].color.withValues(alpha: 0.08)
                              : Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: _hoveredModule == i
                                ? _modules[i].color
                                : _modules[i].color.withValues(alpha: 0.25),
                            width: _hoveredModule == i ? 2 : 1.5,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _hoveredModule == i
                                  ? _modules[i].color.withValues(alpha: 0.15)
                                  : PptColors.shadowSoft,
                              blurRadius: _hoveredModule == i ? 20 : 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(_modules[i].icon, color: _modules[i].color, size: 20),
                                const SizedBox(width: 6),
                                Expanded(
                                  child: Text(
                                    _modules[i].name,
                                    style: PptTypography.cardHeader(color: _modules[i].color)
                                        .copyWith(fontSize: 11),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 6),
                            Expanded(
                              child: Text(
                                _modules[i].desc,
                                style: PptTypography.bodySmall(color: PptColors.textSecondary)
                                    .copyWith(fontSize: 9.5),
                                overflow: TextOverflow.fade,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // ── KANAN: URL Card + Status ──────────────────────────────────
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      // Live URL Card
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: PptColors.emasNanggroe.withValues(alpha: 0.5), width: 1.5),
                          boxShadow: [BoxShadow(color: PptColors.shadowSoft, blurRadius: 16, offset: const Offset(0, 4))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                AnimatedBuilder(
                                  animation: _glowCtrl,
                                  builder: (context, child) => Container(
                                    width: 10, height: 10,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color.lerp(PptColors.tniGreenNeon, Colors.green.shade300, _glowCtrl.value),
                                      boxShadow: [BoxShadow(color: PptColors.tniGreenNeon.withValues(alpha: 0.5), blurRadius: 6)],
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text('LIVE PRODUCTION', style: PptTypography.tacticalBadge(color: PptColors.tniGreenNeon)),
                              ],
                            ),
                            const SizedBox(height: 10),
                            Container(
                              width: double.infinity,
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: PptColors.backgroundCanvas,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: PptColors.glassBorderLight),
                              ),
                              child: Text(
                                'https://nazarulqudritrkj.github.io/siber/',
                                style: PptTypography.mono(fontSize: 10, color: PptColors.merahIndonesia),
                              ),
                            ),
                            const SizedBox(height: 10),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: TacticalAudioService.playClick,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: PptColors.merahIndonesia,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 10),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                ),
                                icon: const Icon(Icons.open_in_new_rounded, size: 14),
                                label: Text('BUKA DEMO SISTEM', style: PptTypography.tacticalBadge(color: Colors.white)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 10),
                      // Status Card
                      Container(
                        padding: const EdgeInsets.all(14),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(14),
                          border: Border.all(color: PptColors.glassBorderLight),
                          boxShadow: [BoxShadow(color: PptColors.shadowSoft, blurRadius: 12, offset: const Offset(0, 3))],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('PRODUCTION STATUS', style: PptTypography.cardHeader(color: PptColors.tniGreenDark)),
                            const SizedBox(height: 10),
                            _statusRow(Icons.speed_rounded, 'Engine', 'CanvasKit 60 FPS', PptColors.tniGreenNeon),
                            const SizedBox(height: 6),
                            _statusRow(Icons.cloud_done_rounded, 'Backend', 'Supabase Cloud', PptColors.cyberBlue),
                            const SizedBox(height: 6),
                            _statusRow(Icons.verified_rounded, 'Modul', '8 / 8 Aktif', PptColors.emasDeep),
                            const SizedBox(height: 6),
                            _statusRow(Icons.devices_rounded, 'Platform', 'Web Responsive', PptColors.merahIndonesia),
                            const SizedBox(height: 6),
                            _statusRow(Icons.lock_rounded, 'Keamanan', 'PQC + TLS 1.3', PptColors.tniGreenDark),
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

  Widget _statusRow(IconData icon, String label, String value, Color color) {
    return Row(
      children: [
        Icon(icon, color: color, size: 14),
        const SizedBox(width: 6),
        Text('$label: ', style: PptTypography.bodySmall(color: PptColors.textMuted)),
        Expanded(
          child: Text(value, style: PptTypography.tacticalBadge(color: color).copyWith(fontSize: 10)),
        ),
        const Icon(Icons.check_circle_rounded, size: 12, color: Color(0xFF00C853)),
      ],
    );
  }
}

class _ModuleInfo {
  final IconData icon;
  final String name;
  final String desc;
  final Color color;
  const _ModuleInfo({required this.icon, required this.name, required this.desc, required this.color});
}
