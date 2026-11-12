import 'package:web/web.dart' as web;
import 'tactical_audio_interface.dart';

/// Implementasi audio Web sintetis profesional dengan akustik lembut,
/// bebas dari distorsi nada tajam, memberikan sensasi haptic audio eksekutif.
class TacticalAudioImplementation implements TacticalAudioPlatform {
  web.AudioContext? _ctx;

  @override
  void init() {
    try {
      _ctx ??= web.AudioContext();
    } catch (_) {}
  }

  void _resume() {
    try {
      _ctx ??= web.AudioContext();
      if (_ctx?.state == 'suspended') {
        _ctx?.resume();
      }
    } catch (_) {}
  }

  @override
  void playNext() {
    try {
      _resume();
      final ctx = _ctx;
      if (ctx == null) return;

      final osc = ctx.createOscillator();
      final gain = ctx.createGain();
      final double now = ctx.currentTime.toDouble();

      // Soft air whoosh feedback: 480Hz -> 720Hz (gelombang sinus halus, volume terkalibrasi lembut)
      osc.type = 'sine';
      osc.frequency.setValueAtTime(480, now);
      osc.frequency.exponentialRampToValueAtTime(720, now + 0.10);

      gain.gain.setValueAtTime(0.001, now);
      gain.gain.linearRampToValueAtTime(0.045, now + 0.025);
      gain.gain.exponentialRampToValueAtTime(0.001, now + 0.13);

      osc.connect(gain);
      gain.connect(ctx.destination);

      osc.start(now);
      osc.stop(now + 0.14);
    } catch (_) {}
  }

  @override
  void playBack() {
    try {
      _resume();
      final ctx = _ctx;
      if (ctx == null) return;

      final osc = ctx.createOscillator();
      final gain = ctx.createGain();
      final double now = ctx.currentTime.toDouble();

      // Soft warm return harmonic cue: 620Hz -> 420Hz (sinus lembut, transisi natural)
      osc.type = 'sine';
      osc.frequency.setValueAtTime(620, now);
      osc.frequency.exponentialRampToValueAtTime(420, now + 0.11);

      gain.gain.setValueAtTime(0.001, now);
      gain.gain.linearRampToValueAtTime(0.040, now + 0.025);
      gain.gain.exponentialRampToValueAtTime(0.001, now + 0.14);

      osc.connect(gain);
      gain.connect(ctx.destination);

      osc.start(now);
      osc.stop(now + 0.15);
    } catch (_) {}
  }

  @override
  void playClick() {
    try {
      _resume();
      final ctx = _ctx;
      if (ctx == null) return;

      final osc = ctx.createOscillator();
      final gain = ctx.createGain();
      final double now = ctx.currentTime.toDouble();

      // Subtle tactile blip: 850Hz, durasi mikro 35ms
      osc.type = 'sine';
      osc.frequency.setValueAtTime(850, now);

      gain.gain.setValueAtTime(0.035, now);
      gain.gain.exponentialRampToValueAtTime(0.001, now + 0.035);

      osc.connect(gain);
      gain.connect(ctx.destination);

      osc.start(now);
      osc.stop(now + 0.04);
    } catch (_) {}
  }
}
