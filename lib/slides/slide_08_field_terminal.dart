import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/ppt_colors.dart';
import '../core/theme/ppt_typography.dart';
import '../core/audio/tactical_audio_service.dart';
import 'slide_02_threat_landscape.dart' show sectionHeader;

class Slide08FieldTerminal extends StatefulWidget {
  const Slide08FieldTerminal({super.key});

  @override
  State<Slide08FieldTerminal> createState() => _Slide08FieldTerminalState();
}

class _Slide08FieldTerminalState extends State<Slide08FieldTerminal>
    with SingleTickerProviderStateMixin {
  final TextEditingController _inputCtrl = TextEditingController();
  final ScrollController _scrollCtrl = ScrollController();
  final FocusNode _focusNode = FocusNode();
  late final AnimationController _cursorCtrl;

  final List<_TermLine> _lines = [
    const _TermLine(text: 'CAKRAWALA C2-CONSOLE v3.7 — FieldOperationsView Ready', type: _LineType.system),
    const _TermLine(text: 'Satgas Siber Unit Connected: Satgas-01 (Aceh), Satgas-02 (Medan), Satgas-03 (Pekanbaru)', type: _LineType.system),
    const _TermLine(text: 'Radio Freq: 433.825 MHz | Hopping Interval: 50ms | ECCM: ACTIVE', type: _LineType.info),
    const _TermLine(text: 'CyberCommandConsole ONLINE — Tab Autocomplete: ENABLED', type: _LineType.info),
    const _TermLine(text: 'Ketik "help" untuk daftar perintah C2 taktis.', type: _LineType.muted),
  ];

  final Map<String, List<_TermLine>> _commands = const {
    'help': [
      _TermLine(text: 'PERINTAH TERSEDIA:', type: _LineType.system),
      _TermLine(text: '  status   — Status semua Satgas aktif', type: _LineType.info),
      _TermLine(text: '  nodes    — Daftar 15 node Kodam dalam mesh P2P', type: _LineType.info),
      _TermLine(text: '  ai       — Laporan inferensi AI terakhir (3.8ms)', type: _LineType.info),
      _TermLine(text: '  scan     — Aktifkan radar sweep manual', type: _LineType.info),
      _TermLine(text: '  crypto   — Status enkripsi PQC Kyber-1024', type: _LineType.info),
      _TermLine(text: '  satgas   — Detail posisi Satgas Siber lapangan', type: _LineType.info),
      _TermLine(text: '  manual   — Buka CommandManualModal (PDF taktis)', type: _LineType.info),
      _TermLine(text: '  clear    — Bersihkan konsol', type: _LineType.muted),
    ],
    'status': [
      _TermLine(text: '[OK] SATGAS SIBER-01 / ACEH  — POS: 5.548°N 95.323°E — ONLINE ✓', type: _LineType.success),
      _TermLine(text: '[OK] SATGAS SIBER-02 / MEDAN — POS: 3.595°N 98.672°E — ONLINE ✓', type: _LineType.success),
      _TermLine(text: '[OK] SATGAS SIBER-03 / PEKANBARU — POS: 0.507°N 101.448°E — ONLINE ✓', type: _LineType.success),
      _TermLine(text: '[!!] SATGAS SIBER-04 / PALEMBANG — HEARTBEAT LEMAH — WASPADA', type: _LineType.warning),
      _TermLine(text: 'Uptime Jaringan: 99.97% | Paket Hilang: 0.03%', type: _LineType.info),
    ],
    'nodes': [
      _TermLine(text: 'MESH BLOCKCHAIN 15-NODE P2P:', type: _LineType.system),
      _TermLine(text: '  Kodam I/BB  Kodam II/Swj  Kodam III/Slw  Kodam IV/Dip  Kodam V/Brw', type: _LineType.info),
      _TermLine(text: '  Kodam VI/Mlw  Kodam VII/Wrb  Kodam IX/Udk  Kodam XII/Tpr  Kodam XIII/Mdk', type: _LineType.info),
      _TermLine(text: '  Kodam XIV/Hsn  Kodam XVI/Ptm  Kodam XVII/Cen  Kodam XVIII/Ksr  Kodam Jaya', type: _LineType.info),
      _TermLine(text: 'Toleransi PBFT: f < n/3 = 5 | Konsensus: SOLID', type: _LineType.success),
    ],
    'ai': [
      _TermLine(text: '[AI-ENGINE v2.3] — Inferensi Terakhir:', type: _LineType.system),
      _TermLine(text: '  Anomali: 185.220.101.4 | Confidence: 94.2% | APT-29 TTP Match', type: _LineType.warning),
      _TermLine(text: '  Action: Firewall Kodam VI/Mlw AUTO-BLOCK | DNS Sinkhole Laut Natuna', type: _LineType.success),
      _TermLine(text: '  Latency Inferensi: 3.8ms | Model: BERT-Military-v4', type: _LineType.info),
      _TermLine(text: '  Log terakhir tersimpan di AiIntelligenceView → Supabase Realtime', type: _LineType.muted),
    ],
    'scan': [
      _TermLine(text: 'INITIATING RADAR SWEEP — TacticalRadarWidget...', type: _LineType.system),
      _TermLine(text: '  Freq: HF 3-30MHz + VHF 30-300MHz + SATCOM L/S-Band', type: _LineType.info),
      _TermLine(text: '  Blip Lock: 5 target terdeteksi | ECCM jamming: ACTIVE', type: _LineType.warning),
      _TermLine(text: '  Blip #1: APT-29 — Range 240km — Bearing 047°', type: _LineType.error),
      _TermLine(text: '  Blip #2-5: Friendly — KODAM nodes authenticated', type: _LineType.success),
      _TermLine(text: 'SWEEP COMPLETE — RadarControlPanel updated.', type: _LineType.success),
    ],
    'crypto': [
      _TermLine(text: 'STATUS KRIPTOGRAFI PASCA-KUANTUM:', type: _LineType.system),
      _TermLine(text: '  KEM    : Kyber-1024 (NIST Level 5) — AKTIF', type: _LineType.success),
      _TermLine(text: '  SIG    : Dilithium-5 (NIST Level 5) — AKTIF', type: _LineType.success),
      _TermLine(text: '  HASH   : Blake3 (256-bit) — AKTIF', type: _LineType.success),
      _TermLine(text: '  TLS    : v1.3 + X25519 Hybrid — AKTIF', type: _LineType.success),
      _TermLine(text: 'AuthBlockchainService: Semua sesi terenkripsi end-to-end.', type: _LineType.info),
    ],
    'satgas': [
      _TermLine(text: 'FIELD OPERATIONS — SATGAS SIBER UNIT DETAIL:', type: _LineType.system),
      _TermLine(text: '  Satgas-01 Aceh    : 3 personil | Ops: RECON | Radio: 433.825 MHz', type: _LineType.info),
      _TermLine(text: '  Satgas-02 Medan   : 4 personil | Ops: PATROL | Radio: 433.875 MHz', type: _LineType.info),
      _TermLine(text: '  Satgas-03 Pekanbaru: 3 personil | Ops: STANDBY | Radio: 433.925 MHz', type: _LineType.info),
      _TermLine(text: '  Interval Hopping: 50ms ECCM | FieldOperationsView: ACTIVE', type: _LineType.success),
    ],
    'manual': [
      _TermLine(text: '[CommandManualModal] — Membuka dokumen PDF taktis...', type: _LineType.system),
      _TermLine(text: '  Manual C2: 847 halaman | Versi: 2024-REV3 | Klasifikasi: RAHASIA', type: _LineType.info),
      _TermLine(text: '  Tab autocomplete tersedia untuk 128 perintah terdaftar.', type: _LineType.muted),
      _TermLine(text: '  [UI] Modal terbuka di atas CyberCommandConsole — tekan ESC untuk tutup.', type: _LineType.muted),
    ],
  };

  void _executeCommand(String input) {
    final cmd = input.trim().toLowerCase();
    if (cmd.isEmpty) return;

    setState(() {
      _lines.add(_TermLine(text: 'cakrawala@c2:~\$ $input', type: _LineType.prompt));
      if (cmd == 'clear') {
        _lines.clear();
        _lines.add(const _TermLine(text: 'Konsol dibersihkan.', type: _LineType.muted));
      } else if (_commands.containsKey(cmd)) {
        _lines.addAll(_commands[cmd]!);
      } else {
        _lines.add(_TermLine(text: 'Perintah tidak dikenal: "$cmd" — ketik "help"', type: _LineType.error));
      }
    });

    _inputCtrl.clear();
    TacticalAudioService.playClick();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollCtrl.hasClients) {
        _scrollCtrl.animateTo(
          _scrollCtrl.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _cursorCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 700))..repeat(reverse: true);
  }

  @override
  void dispose() {
    _inputCtrl.dispose();
    _scrollCtrl.dispose();
    _focusNode.dispose();
    _cursorCtrl.dispose();
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
            'BAB 07 // PUSAT KOMANDO OPERASIONAL LAPANGAN',
            PptColors.tniGreenDark,
            'C2 Console & Field Operations Terminal',
            'CyberCommandConsole menggabungkan terminal Linux interaktif, FieldOperationsView dengan posisi Satgas real-time, radio frequency hopping 433.825 MHz, dan CommandManualModal.',
          ),
          const SizedBox(height: 12),

          Expanded(
            child: Row(
              children: [
                // ── TERMINAL ─────────────────────────────────────────────────
                Expanded(
                  flex: 6,
                  child: Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFF0A1628),
                      borderRadius: BorderRadius.circular(14),
                      border: Border.all(color: PptColors.tniGreenNeon.withValues(alpha: 0.4), width: 1.5),
                      boxShadow: [
                        BoxShadow(color: PptColors.tniGreenNeon.withValues(alpha: 0.08), blurRadius: 20, spreadRadius: 2),
                      ],
                    ),
                    child: Column(
                      children: [
                        // Terminal titlebar
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0F2040),
                            borderRadius: BorderRadius.vertical(top: Radius.circular(12)),
                          ),
                          child: Row(
                            children: [
                              Row(
                                children: [
                                  _dot(const Color(0xFFFF5F57)),
                                  const SizedBox(width: 6),
                                  _dot(const Color(0xFFFFBD2E)),
                                  const SizedBox(width: 6),
                                  _dot(const Color(0xFF28CA42)),
                                ],
                              ),
                              const SizedBox(width: 12),
                              Text('CyberCommandConsole — cakrawala@c2:~',
                                  style: PptTypography.mono(fontSize: 11, color: const Color(0xFF8899AA))),
                              const Spacer(),
                              Text('RAHASIA // TOP SECRET',
                                  style: PptTypography.tacticalBadge(color: PptColors.merahIndonesia).copyWith(fontSize: 9)),
                            ],
                          ),
                        ),
                        // Terminal output
                        Expanded(
                          child: SingleChildScrollView(
                            controller: _scrollCtrl,
                            padding: const EdgeInsets.all(14),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: _lines.map((l) => _buildLine(l)).toList(),
                            ),
                          ),
                        ),
                        // Input area
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
                          decoration: const BoxDecoration(
                            color: Color(0xFF0F2040),
                            borderRadius: BorderRadius.vertical(bottom: Radius.circular(12)),
                          ),
                          child: Row(
                            children: [
                              Text('cakrawala@c2:~\$',
                                  style: PptTypography.mono(fontSize: 12, color: PptColors.tniGreenNeon)),
                              const SizedBox(width: 8),
                              Expanded(
                                child: KeyboardListener(
                                  focusNode: FocusNode(),
                                  onKeyEvent: (event) {
                                    if (event is KeyDownEvent &&
                                        event.logicalKey == LogicalKeyboardKey.enter) {
                                      _executeCommand(_inputCtrl.text);
                                    }
                                  },
                                  child: TextField(
                                    controller: _inputCtrl,
                                    focusNode: _focusNode,
                                    style: PptTypography.mono(fontSize: 12, color: Colors.white),
                                    decoration: const InputDecoration(
                                      border: InputBorder.none,
                                      isDense: true,
                                      hintText: 'ketik perintah... (Enter untuk eksekusi)',
                                      hintStyle: TextStyle(color: Color(0xFF4A6080), fontSize: 11),
                                    ),
                                    onSubmitted: _executeCommand,
                                  ),
                                ),
                              ),
                              AnimatedBuilder(
                                animation: _cursorCtrl,
                                builder: (context, child) => Opacity(
                                  opacity: _cursorCtrl.value,
                                  child: Container(
                                    width: 8, height: 16,
                                    color: PptColors.tniGreenNeon,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(width: 16),

                // ── KANAN: Fitur Panel ────────────────────────────────────────
                Expanded(
                  flex: 4,
                  child: Column(
                    children: [
                      _featureCard(
                        icon: Icons.people_alt_rounded,
                        title: 'FieldOperationsView',
                        color: PptColors.tniGreenDark,
                        items: const [
                          'Satgas Siber-01/02/03 posisi GPS real-time',
                          'Status personil & misi per unit lapangan',
                          'Radio frequency hopping: 433.825–433.925 MHz',
                          'ECCM anti-jamming interval 50ms otomatis',
                        ],
                      ),
                      const SizedBox(height: 10),
                      _featureCard(
                        icon: Icons.terminal_rounded,
                        title: 'CyberCommandConsole',
                        color: PptColors.cyberBlue,
                        items: const [
                          'Tab autocomplete 128 perintah terdaftar',
                          'CommandManualModal: 847 halaman panduan',
                          'Log real-time terenkripsi ke Supabase',
                          'Auth Blockchain Session per pengguna',
                        ],
                      ),
                      const SizedBox(height: 10),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: PptColors.merahIndonesia.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: PptColors.merahIndonesia.withValues(alpha: 0.3)),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.tips_and_updates_rounded, color: PptColors.merahIndonesia, size: 18),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Text(
                                'Ketik: status · nodes · ai · scan · crypto · satgas · manual',
                                style: PptTypography.bodySmall(color: PptColors.merahIndonesia),
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
          ),
        ],
      ),
    );
  }

  Widget _buildLine(_TermLine line) {
    Color color;
    switch (line.type) {
      case _LineType.prompt:   color = PptColors.tniGreenNeon; break;
      case _LineType.system:   color = PptColors.emasNanggroe; break;
      case _LineType.success:  color = const Color(0xFF69F0AE); break;
      case _LineType.warning:  color = const Color(0xFFFFD740); break;
      case _LineType.error:    color = const Color(0xFFFF5252); break;
      case _LineType.info:     color = const Color(0xFF82B1FF); break;
      case _LineType.muted:    color = const Color(0xFF607080); break;
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 2),
      child: Text(line.text, style: PptTypography.mono(fontSize: 11, color: color)),
    );
  }

  Widget _dot(Color c) => Container(width: 10, height: 10, decoration: BoxDecoration(color: c, shape: BoxShape.circle));

  Widget _featureCard({
    required IconData icon,
    required String title,
    required Color color,
    required List<String> items,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
          boxShadow: [BoxShadow(color: PptColors.shadowSoft, blurRadius: 12, offset: const Offset(0, 3))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 18),
                const SizedBox(width: 8),
                Text(title, style: PptTypography.cardHeader(color: color)),
              ],
            ),
            const SizedBox(height: 8),
            ...items.map((item) => Padding(
              padding: const EdgeInsets.only(bottom: 4),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(top: 3),
                    child: Container(width: 4, height: 4, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
                  ),
                  const SizedBox(width: 6),
                  Expanded(child: Text(item, style: PptTypography.bodySmall(color: PptColors.textSecondary))),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}

enum _LineType { prompt, system, success, warning, error, info, muted }

class _TermLine {
  final String text;
  final _LineType type;
  const _TermLine({required this.text, required this.type});
}
