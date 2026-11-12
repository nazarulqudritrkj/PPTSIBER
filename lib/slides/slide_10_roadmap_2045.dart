import 'package:flutter/material.dart';
import '../core/theme/ppt_colors.dart';
import '../core/theme/ppt_typography.dart';
import 'slide_02_threat_landscape.dart' show sectionHeader;

class Slide10Roadmap2045 extends StatelessWidget {
  const Slide10Roadmap2045({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(44, 60, 44, 55),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        sectionHeader(
          'BAB 09 // ROADMAP STRATEGIS KEDAULATAN DIGITAL', PptColors.merahIndonesia,
          'Roadmap Pertahanan Siber Menuju Indonesia Emas 2045',
          'Transformasi bertahap kapabilitas komando siber matra darat — dari konsolidasi jaringan Kodam menuju supremasi pertahanan multi-domain terpadu yang mandiri teknologi.',
        ),
        const SizedBox(height: 18),

        Expanded(
          child: Row(children: [
            _phaseCard('2026 — 2030', 'FASE I: KONSOLIDASI', Icons.foundation_rounded, PptColors.merahIndonesia, [
              'Deploy PBFT penuh di 15 Kodam Nusantara',
              'Standardisasi PQC (Kyber-1024) di semua jalur C2',
              'Operasionalisasi Satgas Siber-01 di perbatasan',
              'Integrasi Supabase Auth 5-Level Clearance nasional',
              'Training 500 Operator Siber TNI bersertifikat',
            ]),
            _timelineConnector(),
            _phaseCard('2030 — 2038', 'FASE II: EKSPANSI TRI-MATRA', Icons.satellite_alt_rounded, PptColors.emasDeep, [
              'Peluncuran satelit militer mandiri CAKRAWALA-01 LEO',
              'Interkoneksi C2 Tri-Matra (TNI AD, AL, AU)',
              'Pembangunan pusat superkomputasi AI edge sovereign',
              'Ekspansi radar taktis ke 38 Provinsi (EEZ coverage)',
              'Penelitian chip enkripsi Kyber indigenus Indonesia',
            ]),
            _timelineConnector(),
            _phaseCard('2038 — 2045', 'FASE III: SUPREMASI DIGITAL', Icons.flag_rounded, PptColors.tniGreenNeon, [
              'Kedaulatan teknologi siber 100% buatan bangsa',
              'Pertahanan multi-domain otonom nir-celah tunggal',
              'RI sebagai episentrum keamanan siber regional ASEAN',
              'Ekspor platform C2 ke aliansi pertahanan internasional',
              'Tercapai: Indonesia Emas 2045 dalam dimensi digital',
            ]),
          ]),
        ),

        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            gradient: LinearGradient(colors: [
              PptColors.merahIndonesia.withValues(alpha: 0.08),
              PptColors.emasNanggroe.withValues(alpha: 0.08),
            ]),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: PptColors.merahIndonesia.withValues(alpha: 0.2)),
          ),
          child: Row(children: [
            const Icon(Icons.info_outline_rounded, color: PptColors.merahIndonesia, size: 18),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Versi saat ini SI-CAKRAWALA v4.7.2-ALPHA telah mengimplementasikan Fase I secara menyeluruh, dengan prototipe Fase II dalam tahap pengembangan aktif di branch development.',
                style: PptTypography.bodySmall(color: PptColors.textSecondary),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _phaseCard(String period, String badge, IconData icon, Color color, List<String> points) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: color.withValues(alpha: 0.35), width: 1.5),
          boxShadow: [BoxShadow(color: color.withValues(alpha: 0.08), blurRadius: 16, offset: const Offset(0, 4))],
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            Text(period, style: PptTypography.mono(fontSize: 13, color: color, fontWeight: FontWeight.w900)),
            Icon(icon, color: color, size: 22),
          ]),
          const SizedBox(height: 6),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
            decoration: BoxDecoration(
              color: color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(badge, style: PptTypography.tacticalBadge(color: color)),
          ),
          const Divider(height: 16),
          ...points.map((p) => Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Icon(Icons.check_circle_rounded, size: 13, color: color),
              const SizedBox(width: 7),
              Expanded(child: Text(p, style: PptTypography.bodySmall(color: PptColors.textSecondary))),
            ]),
          )),
        ]),
      ),
    );
  }

  Widget _timelineConnector() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Container(width: 2, height: 60, color: PptColors.glassBorderLight),
        const Icon(Icons.arrow_forward_rounded, color: PptColors.merahIndonesia, size: 18),
        Container(width: 2, height: 60, color: PptColors.glassBorderLight),
      ]),
    );
  }
}
