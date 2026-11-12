import 'package:flutter/material.dart';
import 'slide_controller.dart';

/// Widget transisi kaya efek multi-layer: Slide + Scale + Fade dengan efek Depth Shadow
class SlideTransitionSwitcher extends StatelessWidget {
  final Widget child;
  final SlideDirection direction;

  const SlideTransitionSwitcher({
    super.key,
    required this.child,
    required this.direction,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 680),
      reverseDuration: const Duration(milliseconds: 680),
      switchInCurve: Curves.easeOutExpo,
      switchOutCurve: Curves.easeInExpo,
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

        // Slide position animation
        final slideAnim = Tween<Offset>(
          begin: isIncoming ? Offset(0.22 * dir, 0.0) : Offset.zero,
          end: isIncoming ? Offset.zero : Offset(-0.22 * dir, 0.0),
        ).animate(CurvedAnimation(
          parent: animation,
          curve: isIncoming ? Curves.easeOutExpo : Curves.easeInExpo,
        ));

        // Scale animation (3D depth feel)
        final scaleAnim = Tween<double>(
          begin: isIncoming ? 0.94 : 1.0,
          end: isIncoming ? 1.0 : 0.94,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: isIncoming ? Curves.easeOutBack : Curves.easeIn,
        ));

        // Opacity animation
        final fadeAnim = Tween<double>(
          begin: isIncoming ? 0.0 : 1.0,
          end: isIncoming ? 1.0 : 0.0,
        ).animate(CurvedAnimation(
          parent: animation,
          curve: const Interval(0.0, 0.6, curve: Curves.easeInOut),
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
