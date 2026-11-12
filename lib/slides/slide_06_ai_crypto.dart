import 'package:flutter/material.dart';
import '../core/theme/ppt_colors.dart';
import '../core/theme/ppt_typography.dart';
import 'slide_02_threat_landscape.dart' show sectionHeader;

class Slide06AiCrypto extends StatelessWidget {
  const Slide06AiCrypto({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(44, 60, 44, 55),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        sectionHeader(
          'BAB 05 // AI SYNAPTIC ENGINE & KRIPTOGRAFI PQC', PptColors.tniGreenNeon,
          'Intelijen Buatan & Perisai Kriptografi Pasca-Kuantum',
          'Engine AI taktis dengan inferensi 3.8ms di-paired dengan enkripsi post-quantum standar NIST, menghadirkan pertahanan berlapis terhadap ancaman fisik dan komputasional masa depan.',
        ),
        const SizedBox(height: 14),

        Expanded(
          child: Row(children: [
            // Kolom AI Engine
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: PptColors.tniGreenNeon.withValues(alpha: 0.3), width: 1.5),
                  boxShadow: [BoxShadow(color: PptColors.shadowSoft, blurRadius: 16, offset: const Offset(0, 4))],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('🤖 PILAR 02: SYNAPTIC AI ENGINE', style: PptTypography.cardHeader(color: PptColors.tniGreenDark)),
                    _liveChip('DEEP INFERENCE'),
                  ]),
                  const SizedBox(height: 8),
                  Text(
                    'AiNeuralEngineWidget mengimplementasikan Synaptic Neural Network dengan log audit otomatis real-time. Engine mendeteksi pola APT-29 (94.2% probabilitas), DDoS via IP-based clustering, dan DNS anomali sinkholebing otomatis.',
                    style: PptTypography.bodySmall(color: PptColors.textSecondary),
                  ),
                  const SizedBox(height: 10),
                  _statRow('AKURASI DETEKSI ANCAMAN', '98.4%', PptColors.tniGreenNeon),
                  _statRow('WAKTU INFERENSI EDGE', '3.8 MS', PptColors.cyberBlue),
                  _statRow('AUTO FIREWALL RESPONSE', '< 1.2 MS', PptColors.merahIndonesia),
                  _statRow('RETRAIN CYCLE', 'Setiap 6 Jam (+Δ 0.4% Akurasi)', PptColors.emasDeep),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: PptColors.backgroundCanvas,
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: PptColors.glassBorderLight),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('LOG REAL-TIME AI DECISION STREAM:', style: PptTypography.bodySmall(color: PptColors.textMuted)),
                      const SizedBox(height: 4),
                      _logLine('[17:34:20]', 'APT-29 terdeteksi IP 185.220.101.4 — Probabilitas 94.2%', PptColors.merahIndonesia),
                      _logLine('[17:33:55]', 'Firewall diterapkan Kodam VI/Mlw — 0 Packet Loss', PptColors.tniGreenNeon),
                      _logLine('[17:31:10]', '890 kueri DNS anomali di-sinkhole — Laut Natuna', PptColors.emasDeep),
                    ]),
                  ),
                ]),
              ),
            ),
            const SizedBox(width: 14),

            // Kolom Kriptografi PQC
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(color: PptColors.merahIndonesia.withValues(alpha: 0.3), width: 1.5),
                  boxShadow: [BoxShadow(color: PptColors.shadowSoft, blurRadius: 16, offset: const Offset(0, 4))],
                ),
                child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
                    Text('🔒 PILAR 04: KRIPTOGRAFI PASCA-KUANTUM', style: PptTypography.cardHeader(color: PptColors.merahIndonesia)),
                    const Icon(Icons.lock_rounded, color: PptColors.merahIndonesia, size: 22),
                  ]),
                  const SizedBox(height: 8),
                  Text(
                    'AuthBlockchainService mengimplementasikan standard NIST Post-Quantum Cryptography (PQC) untuk menjamin confidentiality dan authenticity perintah militer di era komputasi kuantum.',
                    style: PptTypography.bodySmall(color: PptColors.textSecondary),
                  ),
                  const SizedBox(height: 10),
                  _pqcRow('KEY ENCAPSULATION', 'Kyber-1024', 'Lattice-Based KEM', PptColors.merahIndonesia),
                  _pqcRow('DIGITAL SIGNATURE', 'Dilithium-5 (ML-DSA)', 'Module-Lattice', PptColors.emasDeep),
                  _pqcRow('HASH FUNCTION', 'Blake3 Blockchain', 'Merkle Tree Root', PptColors.cyberBlue),
                  _pqcRow('SECURITY LEVEL', 'NIST Level 5', 'Maximum Protection', PptColors.tniGreenNeon),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      gradient: LinearGradient(colors: [
                        PptColors.merahIndonesia.withValues(alpha: 0.08),
                        PptColors.emasNanggroe.withValues(alpha: 0.08),
                      ]),
                      borderRadius: BorderRadius.circular(8),
                      border: Border.all(color: PptColors.merahIndonesia.withValues(alpha: 0.2)),
                    ),
                    child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                      Text('IMPLEMENTASI DALAM KODE:', style: PptTypography.bodySmall(color: PptColors.textMuted)),
                      const SizedBox(height: 4),
                      Text('class AuthBlockchainService', style: PptTypography.mono(fontSize: 10, color: PptColors.merahIndonesia)),
                      Text('  → generateKyberKeyPair()', style: PptTypography.mono(fontSize: 10, color: PptColors.textPrimary)),
                      Text('  → signWithDilithium5(message)', style: PptTypography.mono(fontSize: 10, color: PptColors.textPrimary)),
                      Text('  → verifyBlockchainSignature(hash)', style: PptTypography.mono(fontSize: 10, color: PptColors.textPrimary)),
                    ]),
                  ),
                ]),
              ),
            ),
          ]),
        ),
      ]),
    );
  }

  Widget _liveChip(String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
      decoration: BoxDecoration(
        color: PptColors.tniGreenNeon.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: PptColors.tniGreenNeon.withValues(alpha: 0.5)),
      ),
      child: Text(label, style: PptTypography.tacticalBadge(color: PptColors.tniGreenNeon)),
    );
  }

  Widget _statRow(String label, String val, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(label, style: PptTypography.bodySmall(color: PptColors.textMuted)),
        Text(val, style: PptTypography.mono(fontSize: 11, color: color, fontWeight: FontWeight.w700)),
      ]),
    );
  }

  Widget _pqcRow(String type, String algo, String basis, Color color) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.06),
          borderRadius: BorderRadius.circular(6),
          border: Border.all(color: color.withValues(alpha: 0.2)),
        ),
        child: Row(children: [
          Expanded(child: Text(type, style: PptTypography.bodySmall(color: PptColors.textMuted))),
          Expanded(flex: 2, child: Text(algo, style: PptTypography.mono(fontSize: 11, color: color, fontWeight: FontWeight.w700))),
          Expanded(child: Text(basis, style: PptTypography.bodySmall(color: PptColors.textMuted))),
        ]),
      ),
    );
  }

  Widget _logLine(String time, String msg, Color color) {
    return Padding(
      padding: const EdgeInsets.only(top: 4),
      child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(time, style: PptTypography.mono(fontSize: 9.5, color: color)),
        const SizedBox(width: 6),
        Expanded(child: Text(msg, style: PptTypography.mono(fontSize: 9.5, color: PptColors.textPrimary))),
      ]),
    );
  }
}
