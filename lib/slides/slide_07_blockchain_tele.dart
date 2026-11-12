import 'package:flutter/material.dart';
import '../core/theme/ppt_colors.dart';
import '../core/theme/ppt_typography.dart';
import 'slide_02_threat_landscape.dart' show sectionHeader;

class Slide07BlockchainTele extends StatelessWidget {
  const Slide07BlockchainTele({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(44, 60, 44, 55),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        sectionHeader(
          'BAB 06 // BLOCKCHAIN KODAM & TELEMETRI FASILITAS', PptColors.emasNanggroe,
          'PBFT Distributed Ledger & Real-time Hardware Telemetry',
          'Dua pilar integritas data: Blockchain PBFT untuk audit perintah operasional, dan sistem telemetri hardware untuk memastikan kesiapan fisik fasilitas bunker pusat komando.',
        ),
        const SizedBox(height: 14),

        Expanded(
          child: Row(children: [
            // Kolom Blockchain
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: PptColors.emasNanggroe.withValues(alpha: 0.35), width: 1.5),
                  boxShadow: [BoxShadow(color: PptColors.emasNanggroe.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 4))],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('🔗 PILAR 05: BLOCKCHAIN MILITER PBFT', style: PptTypography.cardHeader(color: PptColors.emasDeep)),
                    const Icon(Icons.link_rounded, color: PptColors.emasNanggroe, size: 22),
                  ]),
                  const SizedBox(height: 8),
                  Text(
                    'BlockchainView mengimplementasikan PBFT distributed ledger di 15 Kodam. Setiap perintah operasi, akses sistem, dan transaksi data tercatat dalam blok Blake3-hashed yang divalidasi konsensus byzantine.',
                    style: PptTypography.bodySmall(color: PptColors.textSecondary),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0F172A),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('HASH BLOK TERBARU (KODAM JAYAKARTA C2):', style: PptTypography.mono(fontSize: 9, color: Colors.white54)),
                      const SizedBox(height: 3),
                      Text('0x7F89A4C2D...E198F04B // VALIDATED 15/15 NODES', style: PptTypography.mono(fontSize: 9.5, color: PptColors.tniGreenNeon)),
                    ]),
                  ),
                  const SizedBox(height: 8),
                  _blockRow('TOTAL BLOK TERVALIDASI', '48.285 Blok', PptColors.emasDeep),
                  _blockRow('INTERVAL BLOK BARU', '500 MS (Real-time Consensus)', PptColors.cyberBlue),
                  _blockRow('TOLERANSI BYZANTINE', 'Max 4 Node Gagal (f < n/3)', PptColors.merahIndonesia),
                  _blockRow('AUDIT INTEGRITAS', 'Zero Tampering — Forensik Real-time', PptColors.tniGreenNeon),
                  const Spacer(),
                  _featureTag('BlockchainMetricsHeader Widget', PptColors.emasDeep),
                  const SizedBox(height: 4),
                  _featureTag('TacticalBlockList + ValidatorMeshWidget', PptColors.emasDeep),
                  const SizedBox(height: 4),
                  _featureTag('Tombol: RUN INTEGRITY AUDIT (1.8s Verifikasi)', PptColors.emasDeep),
                ]),
              ),
            ),
            const SizedBox(width: 14),

            // Kolom Telemetri
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: PptColors.cyberBlue.withValues(alpha: 0.3), width: 1.5),
                  boxShadow: [BoxShadow(color: PptColors.shadowSoft, blurRadius: 16, offset: const Offset(0, 4))],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('📡 PILAR 06: TELEMETRI FASILITAS', style: PptTypography.cardHeader(color: PptColors.cyberBlue)),
                    const Icon(Icons.monitor_heart_rounded, color: PptColors.cyberBlue, size: 22),
                  ]),
                  const SizedBox(height: 8),
                  Text(
                    'TelemetryDashboardScreen memantau kesehatan infrastruktur fisik pusat komando secara real-time: GPU AI cluster, HVAC pendingin cair shelter, sensor seismik, radiasi nuklir, dan daya ransel satgas lapangan.',
                    style: PptTypography.bodySmall(color: PptColors.textSecondary),
                  ),
                  const SizedBox(height: 10),
                  _teleSensorGrid([
                    {'label': 'SUHU GPU CLUSTER', 'val': '48.2°C', 'status': 'OPTIMAL', 'color': 'green'},
                    {'label': 'COOLING HVAC LIQUID', 'val': '98.6%', 'status': 'NORMAL', 'color': 'blue'},
                    {'label': 'SENSOR SEISMIK', 'val': '0.02 G', 'status': 'STABIL', 'color': 'green'},
                    {'label': 'RADIASI NUKLIR', 'val': '2.1 mSv/hr', 'status': 'SAFE', 'color': 'green'},
                    {'label': 'DAYA RANSEL SATGAS', 'val': '87% ⚡', 'status': 'CHARGING', 'color': 'gold'},
                    {'label': 'BANDWIDTH SATCOM', 'val': '1.2 Gbps', 'status': 'FULL', 'color': 'blue'},
                  ]),
                  const Spacer(),
                  _featureTag('TelemetryMetricCard + SparklinePainter', PptColors.cyberBlue),
                  const SizedBox(height: 4),
                  _featureTag('SensorDiagnosticsModal (12 parameter sensor)', PptColors.cyberBlue),
                  const SizedBox(height: 4),
                  _featureTag('PowerCoolingControlPanel interaktif', PptColors.cyberBlue),
                ]),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _blockRow(String label, String val, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: PptTypography.bodySmall(color: PptColors.textMuted)),
        Text(val, style: PptTypography.mono(fontSize: 10.5, color: color, fontWeight: FontWeight.w700)),
      ]),
    );
  }

  Widget _featureTag(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Text('→ $label', style: PptTypography.mono(fontSize: 9.5, color: color)),
    );
  }

  Widget _teleSensorGrid(List<Map<String, String>> sensors) {
    final colorMap = {'green': PptColors.tniGreenNeon, 'blue': PptColors.cyberBlue, 'gold': PptColors.emasDeep};
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: sensors.map((s) {
        final color = colorMap[s['color']] ?? PptColors.textMuted;
        return SizedBox(
          width: 140,
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: PptColors.backgroundCanvas,
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: color.withValues(alpha: 0.3)),
            ),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(s['label']!, style: PptTypography.bodySmall(color: PptColors.textMuted).copyWith(fontSize: 9.5)),
              const SizedBox(height: 2),
              Text(s['val']!, style: PptTypography.mono(fontSize: 13, color: color, fontWeight: FontWeight.w700)),
              Text(s['status']!, style: PptTypography.tacticalBadge(color: PptColors.textMuted)),
            ]),
          ),
        );
      }).toList(),
    );
  }
}
