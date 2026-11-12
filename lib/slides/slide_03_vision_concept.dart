import 'package:flutter/material.dart';
import '../core/theme/ppt_colors.dart';
import '../core/theme/ppt_typography.dart';
import 'slide_02_threat_landscape.dart' show sectionHeader;

class Slide03VisionConcept extends StatelessWidget {
  const Slide03VisionConcept({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(44, 60, 44, 55),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        sectionHeader(
          'BAB 02 // ARSITEKTUR SOLUSI TERPADU', PptColors.emasDeep,
          'Nanggroe Cakrawala Shield: Platform C2 Multi-Domain',
          'Sistem SI-CAKRAWALA dirancang sebagai pusat komando operasional siber terpadu (Cyber Operation Command Center) TNI AD yang mengintegrasikan enam domain pertahanan dalam satu antarmuka terintegrasi berbasis Flutter Web 3.44 + CanvasKit.',
        ),
        const SizedBox(height: 16),

        Expanded(
          child: Row(children: [
            // Kiri: Arsitektur Teknis
            Expanded(
              flex: 5,
              child: Column(children: [
                _techCard('⚡ FRAMEWORK & RUNTIME', [
                  ('Platform', 'Flutter 3.44 / Dart 3.12.2 (CanvasKit WebGL)'),
                  ('Backend', 'Supabase Cloud (PostgreSQL + Realtime + Auth)'),
                  ('Hosting', 'GitHub Pages (CI/CD via GitHub Actions)'),
                  ('Render', 'Web Worker + Service Worker Caching PWA'),
                ], PptColors.cyberBlue),
                const SizedBox(height: 10),
                _techCard('🔐 KEAMANAN BERLAPIS', [
                  ('Auth Layer 1', 'Supabase JWT + Role-Based Access (5 Level Clearance)'),
                  ('Auth Layer 2', 'Blockchain Signature Validation (PBFT)'),
                  ('Enkripsi Data', 'Kyber-1024 KEM + Dilithium-5 Digital Signature'),
                  ('Audit Trail', 'Immutable blockchain log — 48.285+ blok tervalidasi'),
                ], PptColors.merahIndonesia),
              ]),
            ),
            const SizedBox(width: 14),

            // Kanan: 3 Lapisan Domain
            Expanded(
              flex: 6,
              child: Column(children: [
                _domainCard('LAPISAN 01 — SENSING & PENGINDERAAN',
                  Icons.satellite_alt_rounded, PptColors.cyberBlue,
                  '3D Globe WebGL (LEO/GEO orbit), Radar 360° multi-spektrum, Telemetri sensor array seismik/nuklir, dan monitoring GPU/HVAC shelter bunker secara real-time 60 FPS.',
                  ['Mata Satelit 3D (earth_atmos.jpg texture NASA)', 'Radar Taktis 360° + blip locking', 'Telemetri 12 parameter sensor']),
                const SizedBox(height: 8),
                _domainCard('LAPISAN 02 — INTELLIGENCE & DECISION',
                  Icons.psychology_rounded, PptColors.tniGreenNeon,
                  'Synaptic Neural Engine mendeteksi anomali transmisi, klasifikasi APT/DDoS/intrusi dengan akurasi 98.4% dan waktu inferensi 3.8ms. AI retraining otomatis setiap 6 jam.',
                  ['AI Log Stream: 4+ insiden real-time', 'Vector Threat Panel (expandable)', 'Auto-firewall response < 1.2ms']),
                const SizedBox(height: 8),
                _domainCard('LAPISAN 03 — TRUST & INTEGRITY',
                  Icons.lock_clock_rounded, PptColors.merahIndonesia,
                  'PBFT distributed ledger di 15 Kodam menjamin integritas perintah operasi. Setiap log akses, perintah C2, dan transaksi data tersimpan dalam rantai blok immutable terenkripsi.',
                  ['48.285+ blok tervalidasi Blake3', 'Consensus interval 500ms', 'Audit forensik real-time']),
              ]),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _techCard(String title, List<(String, String)> rows, Color color) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.25), width: 1.5),
        boxShadow: [BoxShadow(color: PptColors.shadowSoft, blurRadius: 10, offset: const Offset(0, 3))],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(title, style: PptTypography.cardHeader(color: color)),
        const Divider(height: 10),
        ...rows.map((r) => Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Row(children: [
            SizedBox(width: 100, child: Text(r.$1, style: PptTypography.bodySmall(color: PptColors.textMuted))),
            const Text(': ', style: TextStyle(color: PptColors.textMuted, fontSize: 11)),
            Expanded(child: Text(r.$2, style: PptTypography.mono(fontSize: 10.5, color: PptColors.textPrimary))),
          ]),
        )),
      ]),
    );
  }

  Widget _domainCard(String title, IconData icon, Color color, String desc, List<String> bullets) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: color.withValues(alpha: 0.3), width: 1.5),
        boxShadow: [BoxShadow(color: color.withValues(alpha: 0.06), blurRadius: 12, offset: const Offset(0, 3))],
      ),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Icon(icon, color: color, size: 22),
        ),
        const SizedBox(width: 12),
        Expanded(
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: PptTypography.tacticalBadge(color: color)),
            const SizedBox(height: 4),
            Text(desc, style: PptTypography.bodySmall(color: PptColors.textSecondary)),
            const SizedBox(height: 6),
            Wrap(spacing: 6, runSpacing: 4, children: bullets.map((b) => Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(3),
              ),
              child: Text(b, style: PptTypography.mono(fontSize: 9.5, color: color)),
            )).toList()),
          ]),
        ),
      ]),
    );
  }
}
