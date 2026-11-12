import 'package:flutter/material.dart';
import '../core/theme/ppt_colors.dart';
import '../core/theme/ppt_typography.dart';
import '../core/widgets/ppt_section_header.dart';

export '../core/widgets/ppt_section_header.dart';

class Slide02ThreatLandscape extends StatefulWidget {
  const Slide02ThreatLandscape({super.key});
  @override
  State<Slide02ThreatLandscape> createState() => _Slide02State();
}

class _Slide02State extends State<Slide02ThreatLandscape>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctr;

  @override
  void initState() {
    super.initState();
    _ctr = AnimationController(vsync: this, duration: const Duration(seconds: 3))..repeat(reverse: true);
  }

  @override
  void dispose() { _ctr.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(44, 60, 44, 55),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        sectionHeader('BAB 01 // LATAR BELAKANG & URGENSI', PptColors.merahIndonesia,
          'Ancaman Siber Modern & Kedaulatan Digital Indonesia',
          'Perang asimetris kontemporer bergeser ke domain siber. Infrastruktur kritis, jaringan komando, dan aset militer rentan terhadap APT, DDoS, dan eksfiltrasi data senjata negara asing.'),
        const SizedBox(height: 16),

        Expanded(
          child: Row(children: [
            _threatCard(
              icon: Icons.bug_report_rounded,
              badge: 'VEKTOR 01: APT & INTRUSI', 
              title: 'Advanced Persistent Threats',
              desc: 'Kelompok APT-29/40 dan Lazarus Group aktif menargetkan jaringan militer ASEAN dengan teknik spear-phishing, supply-chain attack, dan zero-day exploit firmware router.',
              stats: [('Serangan APT 2026', '+340%'), ('Infeksi Firmware', '89 Insiden'), ('Kerugian Data', '12 TB')],
              color: PptColors.merahIndonesia,
              icon2: Icons.trending_up_rounded,
            ),
            const SizedBox(width: 14),
            _threatCard(
              icon: Icons.hub_outlined,
              badge: 'VEKTOR 02: FRAGMENTASI C2',
              title: 'Kesenjangan Konektivitas 15 Kodam',
              desc: 'Topografi kepulauan 17.000+ pulau menyulitkan koordinasi real-time antar Kodam. Tanpa PBFT distributed ledger, satu titik kompromi dapat melumpuhkan seluruh rantai komando.',
              stats: [('Kodam Terisolasi', '4 Unit'), ('Latensi Komunikasi', '> 1.2 s'), ('Celah SPOF', 'Kritis')],
              color: PptColors.emasDeep,
              icon2: Icons.warning_amber_rounded,
            ),
            const SizedBox(width: 14),
            _threatCard(
              icon: Icons.memory_rounded,
              badge: 'VEKTOR 03: ANCAMAN KUANTUM',
              title: 'Dekripsi Superkomputer Kuantum',
              desc: 'Proyeksi 2035: superkomputer kuantum mampu membobol enkripsi RSA-2048 dalam hitungan jam. Data intelijen militer terenkripsi hari ini bisa didekripsi di masa depan (harvest-now decrypt-later).',
              stats: [('Qubits Target', '4.000+'), ('Enkripsi RSA Usang', '< 10 Tahun'), ('Urgensitas PQC', 'MAXIMUM')],
              color: PptColors.cyberBlue,
              icon2: Icons.lock_open_rounded,
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _threatCard({
    required IconData icon, required String badge, required String title,
    required String desc, required List<(String, String)> stats,
    required Color color, required IconData icon2,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 20, offset: const Offset(0, 6))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
              decoration: BoxDecoration(color: color.withValues(alpha: 0.1), borderRadius: BorderRadius.circular(4)),
              child: Text(badge, style: PptTypography.tacticalBadge(color: color)),
            ),
            Icon(icon, color: color, size: 22),
          ]),
          const SizedBox(height: 10),
          Text(title, style: PptTypography.cardHeader(color: PptColors.textPrimary)),
          const SizedBox(height: 6),
          Text(desc, style: PptTypography.bodySmall(color: PptColors.textSecondary)),
          const Spacer(),
          ...stats.map((s) => Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
              decoration: BoxDecoration(
                color: PptColors.backgroundCanvas,
                borderRadius: BorderRadius.circular(6),
                border: Border.all(color: PptColors.glassBorderLight),
              ),
              child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                Text(s.$1, style: PptTypography.bodySmall(color: PptColors.textMuted)),
                Text(s.$2, style: PptTypography.mono(fontSize: 11, color: color, fontWeight: FontWeight.w700)),
              ]),
            ),
          )),
        ]),
      ),
    );
  }
}


