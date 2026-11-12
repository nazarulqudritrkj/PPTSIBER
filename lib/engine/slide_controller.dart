import 'dart:async';
import 'package:flutter/material.dart';
import '../core/audio/tactical_audio_service.dart';

enum SlideDirection { next, back }

class SlideController extends ChangeNotifier {
  final int totalSlides;
  int _currentIndex = 0;
  SlideDirection _lastDirection = SlideDirection.next;
  bool _isMuted = false;

  late final Stopwatch _stopwatch;
  Timer? _ticker;

  SlideController({this.totalSlides = 11}) {
    _stopwatch = Stopwatch()..start();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) {
      notifyListeners();
    });
  }

  int get currentIndex => _currentIndex;
  SlideDirection get lastDirection => _lastDirection;
  bool get isMuted => _isMuted;
  bool get hasPrevious => _currentIndex > 0;
  bool get hasNext => _currentIndex < totalSlides - 1;

  String get formattedTimer {
    final int sec = _stopwatch.elapsed.inSeconds;
    final int m = sec ~/ 60;
    final int s = sec % 60;
    return '${m.toString().padLeft(2, '0')}:${s.toString().padLeft(2, '0')}';
  }

  void nextSlide() {
    if (hasNext) {
      _lastDirection = SlideDirection.next;
      _currentIndex++;
      TacticalAudioService.playNext();
      notifyListeners();
    }
  }

  void previousSlide() {
    if (hasPrevious) {
      _lastDirection = SlideDirection.back;
      _currentIndex--;
      TacticalAudioService.playBack();
      notifyListeners();
    }
  }

  void jumpToSlide(int index) {
    if (index >= 0 && index < totalSlides && index != _currentIndex) {
      _lastDirection = index > _currentIndex ? SlideDirection.next : SlideDirection.back;
      _currentIndex = index;
      TacticalAudioService.playClick();
      notifyListeners();
    }
  }

  void toggleAudio() {
    TacticalAudioService.toggleMute();
    _isMuted = TacticalAudioService.isMuted;
    notifyListeners();
  }

  @override
  void dispose() {
    _ticker?.cancel();
    _stopwatch.stop();
    super.dispose();
  }
}

