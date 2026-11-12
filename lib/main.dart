import 'package:flutter/material.dart';
import 'core/theme/ppt_colors.dart';
import 'engine/slide_controller.dart';
import 'engine/presentation_scaffold.dart';
import 'slides/slide_01_hero.dart';
import 'slides/slide_02_threat_landscape.dart';
import 'slides/slide_03_vision_concept.dart';
import 'slides/slide_04_kodam_topology.dart';
import 'slides/slide_05_satelit_radar.dart';
import 'slides/slide_06_ai_crypto.dart';
import 'slides/slide_07_blockchain_tele.dart';
import 'slides/slide_08_field_terminal.dart';
import 'slides/slide_09_live_showcase.dart';
import 'slides/slide_10_roadmap_2045.dart';
import 'slides/slide_11_closing_qa.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const PptSiberApp());
}

class PptSiberApp extends StatelessWidget {
  const PptSiberApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SI-CAKRAWALA | Presentation Deck — SATSIBER TNI AD',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        brightness: Brightness.light,
        scaffoldBackgroundColor: PptColors.backgroundCanvas,
        primaryColor: PptColors.merahIndonesia,
        colorScheme: ColorScheme.fromSeed(
          seedColor: PptColors.merahIndonesia,
          brightness: Brightness.light,
          primary: PptColors.merahIndonesia,
          secondary: PptColors.emasNanggroe,
        ),
        useMaterial3: true,
      ),
      home: const PresentationMainScreen(),
    );
  }
}

class PresentationMainScreen extends StatefulWidget {
  const PresentationMainScreen({super.key});

  @override
  State<PresentationMainScreen> createState() => _PresentationMainScreenState();
}

class _PresentationMainScreenState extends State<PresentationMainScreen> {
  late final SlideController _controller;

  @override
  void initState() {
    super.initState();
    _controller = SlideController(totalSlides: 11);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final slides = [
      Slide01Hero(onStart: () => _controller.nextSlide()),
      const Slide02ThreatLandscape(),
      const Slide03VisionConcept(),
      const Slide04KodamTopology(),
      const Slide05SatelitRadar(),
      const Slide06AiCrypto(),
      const Slide07BlockchainTele(),
      const Slide08FieldTerminal(),
      const Slide09LiveShowcase(),
      const Slide10Roadmap2045(),
      Slide11ClosingQa(onRestart: () => _controller.jumpToSlide(0)),
    ];

    return PresentationScaffold(
      controller: _controller,
      slides: slides,
    );
  }
}
