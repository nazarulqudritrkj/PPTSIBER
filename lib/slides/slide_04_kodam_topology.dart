import 'package:flutter/material.dart';
import '../core/theme/ppt_colors.dart';
import '../core/theme/ppt_typography.dart';
import 'slide_02_threat_landscape.dart' show sectionHeader;

class Slide04KodamTopology extends StatefulWidget {
  const Slide04KodamTopology({super.key});
  @override
  State<Slide04KodamTopology> createState() => _Slide04State();
}

class _Slide04State extends State<Slide04KodamTopology>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctr;
  int? _hoveredNode;

  @override
  void initState() {
    super.initState();
    _ctr = AnimationController(vsync: this, duration: const Duration(seconds: 2))..repeat(reverse: true);
  }

  @override
  void dispose() { _ctr.dispose(); super.dispose(); }

  static const List<Map<String, String>> _nodes = [
    {'name': 'Kodam Iskandar Muda', 'loc': 'Banda Aceh', 'role': '🛡️ Gerbang Barat Nusantara', 'lat': '< 11ms', 'region': 'SUMATERA'},
    {'name': 'Kodam I/Bukit Barisan', 'loc': 'Medan', 'role': '⚓ Node Selat Malaka & Andaman', 'lat': '< 12ms', 'region': 'SUMATERA'},
    {'name': 'Kodam II/Sriwijaya', 'loc': 'Palembang', 'role': '🏛️ Pusat Sumatera Selatan', 'lat': '< 13ms', 'region': 'SUMATERA'},
    {'name': 'Kodam Jayakarta ★ C2', 'loc': 'Jakarta', 'role': '🎯 PUSAT KOMANDO UTAMA', 'lat': '< 2ms', 'region': 'JAWA'},
    {'name': 'Kodam III/Siliwangi', 'loc': 'Bandung', 'role': '🔬 Hub Litbang Siber TNI', 'lat': '< 6ms', 'region': 'JAWA'},
    {'name': 'Kodam IV/Diponegoro', 'loc': 'Semarang', 'role': '📡 Node Jawa Tengah', 'lat': '< 8ms', 'region': 'JAWA'},
    {'name': 'Kodam V/Brawijaya', 'loc': 'Surabaya', 'role': '🌊 Penjaga Perairan Selat', 'lat': '< 9ms', 'region': 'JAWA'},
    {'name': 'Kodam IX/Udayana', 'loc': 'Bali', 'role': '🌴 Pintu Gerbang Timur Jawa', 'lat': '< 14ms', 'region': 'NUSATENGGARA'},
    {'name': 'Kodam XII/Tanjungpura', 'loc': 'Pontianak', 'role': '🌿 Perbatasan Malaysia', 'lat': '< 18ms', 'region': 'KALIMANTAN'},
    {'name': 'Kodam VI/Mulawarman', 'loc': 'Balikpapan', 'role': '🏗️ Perisai IKN Nusantara', 'lat': '< 15ms', 'region': 'KALIMANTAN'},
    {'name': 'Kodam XIV/Hasanuddin', 'loc': 'Makassar', 'role': '⚡ Hub Pertahanan Timur', 'lat': '< 16ms', 'region': 'SULAWESI'},
    {'name': 'Kodam XVI/Pattimura', 'loc': 'Ambon', 'role': '🌊 Node Laut Banda', 'lat': '< 20ms', 'region': 'MALUKU'},
    {'name': 'Kodam XVIII/Kasuari', 'loc': 'Manokwari', 'role': '🦅 Papua Barat Shield', 'lat': '< 24ms', 'region': 'PAPUA'},
    {'name': 'Kodam XVII/Cenderawasih', 'loc': 'Jayapura', 'role': '🛡️ Node Perbatasan PNG', 'lat': '< 22ms', 'region': 'PAPUA'},
    {'name': 'Kodam XIII/Merdeka', 'loc': 'Manado', 'role': '🌊 Sulawesi Utara Penjaga', 'lat': '< 19ms', 'region': 'SULAWESI'},
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(44, 60, 44, 55),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        sectionHeader(
          'BAB 03 // DESENTRALISASI PERTAHANAN NUSANTARA', PptColors.merahIndonesia,
          '15 Kodam Network: Topologi PBFT Distributed Ledger',
          'Jaringan buku besar militer terdesentralisasi di seluruh Komando Daerah Militer Nusantara. Konsensus Byzantine Fault Tolerant (PBFT) menjamin integritas data walaupun hingga 4 node diserang secara bersamaan.',
        ),
        const SizedBox(height: 10),

        Row(children: [
          _metricPill('15 NODE', 'Total Kodam', PptColors.merahIndonesia),
          const SizedBox(width: 10),
          _metricPill('11.4 MS', 'Rata-rata Latensi', PptColors.tniGreenNeon),
          const SizedBox(width: 10),
          _metricPill('PBFT v2.1', 'Protokol Konsensus', PptColors.emasDeep),
          const SizedBox(width: 10),
          _metricPill('48.285+', 'Blok Tervalidasi', PptColors.cyberBlue),
          const SizedBox(width: 10),
          _metricPill('500 MS', 'Interval Blok Baru', PptColors.tniGreenDark),
        ]),
        const SizedBox(height: 10),

        Expanded(
          child: GridView.builder(
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 5,
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 2.0,
            ),
            itemCount: _nodes.length,
            itemBuilder: (_, i) {
              final n = _nodes[i];
              final isMain = n['name']!.contains('★');
              final isHov = _hoveredNode == i;
              return MouseRegion(
                onEnter: (_) => setState(() => _hoveredNode = i),
                onExit: (_) => setState(() => _hoveredNode = null),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isMain
                        ? PptColors.merahIndonesia
                        : isHov ? PptColors.backgroundAlt : Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(
                      color: isMain
                          ? PptColors.emasNanggroe
                          : isHov ? PptColors.merahIndonesia.withValues(alpha: 0.5) : PptColors.glassBorderLight,
                      width: isMain || isHov ? 1.8 : 1.0,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: isMain
                            ? PptColors.merahIndonesia.withValues(alpha: 0.3)
                            : isHov ? PptColors.merahIndonesia.withValues(alpha: 0.08) : PptColors.shadowSoft,
                        blurRadius: isMain ? 16 : 8,
                        offset: const Offset(0, 2),
                      )
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Expanded(
                          child: Text(n['name']!,
                            style: PptTypography.tacticalBadge(
                              color: isMain ? Colors.white : PptColors.textPrimary),
                            overflow: TextOverflow.ellipsis),
                        ),
                        Container(
                          width: 7, height: 7,
                          decoration: BoxDecoration(
                            color: isMain ? PptColors.emasNanggroe : PptColors.tniGreenNeon,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ]),
                      const SizedBox(height: 2),
                      Text(n['role']!,
                        style: PptTypography.bodySmall(
                          color: isMain ? Colors.white.withValues(alpha: 0.85) : PptColors.textMuted),
                        overflow: TextOverflow.ellipsis),
                      const SizedBox(height: 2),
                      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                        Text(n['loc']!,
                          style: PptTypography.mono(
                            fontSize: 9, color: isMain ? PptColors.emasNanggroe : PptColors.tniGreenDark)),
                        Text(n['lat']!,
                          style: PptTypography.mono(
                            fontSize: 9, color: isMain ? Colors.white.withValues(alpha: 0.7) : PptColors.cyberBlue)),
                      ]),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ]),
    );
  }

  Widget _metricPill(String val, String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(6),
        border: Border.all(color: color.withValues(alpha: 0.35)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Text('$val  ', style: PptTypography.mono(fontSize: 12, color: color, fontWeight: FontWeight.w700)),
        Text(label, style: PptTypography.bodySmall(color: PptColors.textMuted)),
      ]),
    );
  }
}
