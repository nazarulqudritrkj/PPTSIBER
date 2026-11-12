import 'tactical_audio_interface.dart';
import 'tactical_audio_stub.dart'
    if (dart.library.html) 'tactical_audio_web.dart';

/// Service Pemutar Suara Taktis PPT SI-CAKRAWALA
/// Menggunakan Web Audio API synthesizer dengan zero network latency.
class TacticalAudioService {
  static final TacticalAudioPlatform _platform = getAudioPlatform();
  static bool _isMuted = false;
  static bool _initialized = false;

  static bool get isMuted => _isMuted;

  static void init() {
    if (!_initialized) {
      _platform.init();
      _initialized = true;
    }
  }

  static void toggleMute() {
    _isMuted = !_isMuted;
    if (!_isMuted) {
      playClick();
    }
  }

  static void setMute(bool value) {
    _isMuted = value;
  }

  static void playNext() {
    if (_isMuted) return;
    init();
    _platform.playNext();
  }

  static void playBack() {
    if (_isMuted) return;
    init();
    _platform.playBack();
  }

  static void playClick() {
    if (_isMuted) return;
    init();
    _platform.playClick();
  }
}

