import 'package:flutter/material.dart';
import 'slide_controller.dart';

/// Transisi slide eksekutif & profesional:
/// Menggunakan kurva Emphasized Decelerate yang sangat lembut (silky-smooth),
/// pergeseran paralaks mikro (micro-displacement), dan depth fade natural tanpa hentakan.
class SlideTransitionSwitcher extends StatelessWidget {
  final Widget child;
  final SlideDirection direction;

  const SlideTransitionSwitcher({
    super.key,
    required this.child,
    required this.direction,
  });

  // Kurva fluid motion standar industri (Material Emphasized / Apple Keynote Decelerate)
  static const Curve _decelCurve = Cubic(0.12, 0.82, 0.18, 1.0);
  static const Curve _accelCurve = Cubic(0.35, 0.0, 0.75, 0.3);

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 560),
      reverseDuration: const Duration(milliseconds: 560),
      switchInCurve: _decelCurve,
      switchOutCurve: _accelCurve,
      layoutBuilder: (currentChild, previousChildren) {
        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            ...previousChildren,
            ?currentChild,
          ],
        );
      },
      transitionBuilder: (Widget child, Animation<double> animation) {
        final isIncoming = child.key == this.child.key;
        final double dir = direction == SlideDirection.next ? 1.0 : -1.0;

        // 1. Pergeseran Paralaks Lembut (8% masuk, 4% keluar)
        final slideAnim = Tween<Offset>(
          begin: isIncoming ? Offset(0.08 * dir, 0.0) : Offset.zero,
          end: isIncoming ? Offset.zero : Offset(-0.04 * dir, 0.0),
        ).animate(CurvedAnimation(
          parent: animation,
          curve: isIncoming ? _decelCurve : _accelCurve,
        ));

        // 2. Skala Mikro Sinematik (1.5% micro-depth, tanpa overshoot/bounce)
        final scaleAnim = Tween<double>(
          begin: isIncoming ? 0.985 : 1.0,
          end: isIncoming ? 1.0 : 0.985,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: isIncoming ? _decelCurve : _accelCurve,
        ));

        // 3. Fade Transparan Bertingkat (Asymmetric Fade Blend)
        final fadeAnim = Tween<double>(
          begin: isIncoming ? 0.0 : 1.0,
          end: isIncoming ? 1.0 : 0.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: isIncoming
              ? const Interval(0.0, 0.85, curve: Curves.easeOutCubic)
              : const Interval(0.0, 0.45, curve: Curves.easeInCubic),
        ));

        return SlideTransition(
          position: slideAnim,
          child: ScaleTransition(
            scale: scaleAnim,
            child: FadeTransition(
              opacity: fadeAnim,
              child: child,
            ),
          ),
        );
      },
      child: child,
    );
  }
}
