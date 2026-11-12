import 'package:web/web.dart' as web;
import 'tactical_audio_interface.dart';

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

      // High-tech crisp rising whoosh + tactical affirmative click: 440Hz -> 920Hz
      osc.type = 'sine';
      osc.frequency.setValueAtTime(440, now);
      osc.frequency.exponentialRampToValueAtTime(920, now + 0.12);

      gain.gain.setValueAtTime(0.001, now);
      gain.gain.linearRampToValueAtTime(0.12, now + 0.02);
      gain.gain.exponentialRampToValueAtTime(0.001, now + 0.16);

      osc.connect(gain);
      gain.connect(ctx.destination);

      osc.start(now);
      osc.stop(now + 0.17);
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

      // Reverse resonant harmonic cue: 880Hz -> 380Hz
      osc.type = 'triangle';
      osc.frequency.setValueAtTime(880, now);
      osc.frequency.exponentialRampToValueAtTime(380, now + 0.14);

      gain.gain.setValueAtTime(0.001, now);
      gain.gain.linearRampToValueAtTime(0.10, now + 0.02);
      gain.gain.exponentialRampToValueAtTime(0.001, now + 0.18);

      osc.connect(gain);
      gain.connect(ctx.destination);

      osc.start(now);
      osc.stop(now + 0.19);
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

      osc.type = 'sine';
      osc.frequency.setValueAtTime(1100, now);

      gain.gain.setValueAtTime(0.07, now);
      gain.gain.exponentialRampToValueAtTime(0.001, now + 0.04);

      osc.connect(gain);
      gain.connect(ctx.destination);

      osc.start(now);
      osc.stop(now + 0.05);
    } catch (_) {}
  }
}

TacticalAudioPlatform getAudioPlatform() => TacticalAudioImplementation();
