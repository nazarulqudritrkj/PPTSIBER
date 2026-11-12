import 'tactical_audio_interface.dart';

class TacticalAudioImplementation implements TacticalAudioPlatform {
  @override
  void init() {}

  @override
  void playNext() {}

  @override
  void playBack() {}

  @override
  void playClick() {}
}

TacticalAudioPlatform getAudioPlatform() => TacticalAudioImplementation();

