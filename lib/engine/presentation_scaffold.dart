import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../core/theme/ppt_colors.dart';
import '../core/theme/ppt_typography.dart';
import '../core/painters/sumatera_ornament_painter.dart';
import 'slide_controller.dart';

class PresentationScaffold extends StatefulWidget {
  final SlideController controller;
  final List<Widget> slides;

  const PresentationScaffold({
    super.key,
    required this.controller,
    required this.slides,
  });

  @override
  State<PresentationScaffold> createState() => _PresentationScaffoldState();
}

class _PresentationScaffoldState extends State<PresentationScaffold>
    with TickerProviderStateMixin {
  late final AnimationController _ornamentController;
  late final AnimationController _glowController;
  late final PageController _pageController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: widget.controller.currentIndex);
    widget.controller.addListener(_onSlideChanged);
    _ornamentController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 60),
    )..repeat();
    _glowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2800),
    )..repeat(reverse: true);
  }

  void _onSlideChanged() {
    if (_pageController.hasClients) {
      final targetPage = widget.controller.currentIndex;
      if ((_pageController.page ?? 0).round() != targetPage) {
        _pageController.animateToPage(
          targetPage,
          duration: const Duration(milliseconds: 520),
          curve: Curves.easeInOutCubic,
        );
      }
    }
  }

  @override
  void dispose() {
    widget.controller.removeListener(_onSlideChanged);
    _pageController.dispose();
    _focusNode.dispose();
    _ornamentController.dispose();
    _glowController.dispose();
    super.dispose();
  }

  void _handleKeyEvent(KeyEvent event) {
    if (event is KeyDownEvent) {
      if (event.logicalKey == LogicalKeyboardKey.arrowRight ||
          event.logicalKey == LogicalKeyboardKey.space ||
          event.logicalKey == LogicalKeyboardKey.pageDown) {
        widget.controller.nextSlide();
      } else if (event.logicalKey == LogicalKeyboardKey.arrowLeft ||
          event.logicalKey == LogicalKeyboardKey.pageUp) {
        widget.controller.previousSlide();
      } else if (event.logicalKey == LogicalKeyboardKey.home) {
        widget.controller.jumpToSlide(0);
      } else if (event.logicalKey == LogicalKeyboardKey.end) {
        widget.controller.jumpToSlide(widget.slides.length - 1);
      } else if (event.logicalKey == LogicalKeyboardKey.keyM) {
        widget.controller.toggleAudio();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return KeyboardListener(
      focusNode: _focusNode,
      autofocus: true,
      onKeyEvent: _handleKeyEvent,
      child: ListenableBuilder(
        listenable: widget.controller,
        builder: (context, _) {
          return Scaffold(
            backgroundColor: const Color(0xFFCFD8E3),
            body: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: Container(
                  decoration: BoxDecoration(
                    color: PptColors.backgroundCanvas,
                    boxShadow: const [
                      BoxShadow(
                        color: Color(0x44000000),
                        blurRadius: 48,
                        spreadRadius: 8,
                        offset: Offset(0, 16),
                      ),
                    ],
                  ),
                  child: Stack(
                    children: [
                      // ── 1. Ambient Merah Glow (top-left) ──────────────────
                      Positioned(
                        top: -80,
                        left: -80,
                        child: AnimatedBuilder(
                          animation: _glowController,
                          builder: (context, child) => Container(
                            width: 380,
                            height: 380,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  PptColors.merahIndonesia.withValues(
                                      alpha: 0.07 + _glowController.value * 0.04),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ── 2. Ambient Emas Glow (bottom-right) ───────────────
                      Positioned(
                        bottom: -100,
                        right: -80,
                        child: AnimatedBuilder(
                          animation: _glowController,
                          builder: (context, child) => Container(
                            width: 420,
                            height: 420,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  PptColors.emasNanggroe.withValues(
                                      alpha: 0.09 + _glowController.value * 0.05),
                                  Colors.transparent,
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),

                      // ── 3. Animated Sumatera Ornament Background ──────────
                      Positioned.fill(
                        child: AnimatedBuilder(
                          animation: _ornamentController,
                          builder: (context, _) => CustomPaint(
                            painter: SumateraOrnamentPainter(
                              animationValue: _ornamentController.value,
                              opacity: 0.06,
                            ),
                          ),
                        ),
                      ),

                      // ── 4. Main Slide Presentation Viewport (100% Bebas Tabrakan Teks) ──
                      Positioned.fill(
                        child: ClipRect(
                          child: PageView.builder(
                            controller: _pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: widget.slides.length,
                            itemBuilder: (context, index) {
                              return widget.slides[index];
                            },
                          ),
                        ),
                      ),

                      // ── 5. Top Header HUD ─────────────────────────────────
                      Positioned(
                        top: 0,
                        left: 0,
                        right: 0,
                        child: _buildTopHeaderHud(),
                      ),

                      // ── 6. Bottom Navigation HUD ──────────────────────────
                      Positioned(
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: _buildBottomNavHud(),
                      ),

                      // ── 7. Side Thumbnail Grid (Slide Number Strip) ───────
                      Positioned(
                        right: 0,
                        top: 48,
                        bottom: 48,
                        child: _buildSideSlideStrip(),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildTopHeaderHud() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white.withValues(alpha: 0.92),
            Colors.white.withValues(alpha: 0.0),
          ],
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              _hudbadge(
                gradient: PptColors.merahPutihGradient,
                text: 'SI-CAKRAWALA',
                textColor: Colors.white,
                borderColor: Colors.transparent,
                icon: Icons.shield_rounded,
                iconColor: Colors.white,
              ),
              const SizedBox(width: 8),
              _hudbadge(
                text: 'NANGGROE CAKRAWALA SHIELD // SATSIBER TNI AD',
                borderColor: PptColors.emasNanggroe.withValues(alpha: 0.5),
                icon: Icons.star_rounded,
                iconColor: PptColors.emasNanggroe,
              ),
              const SizedBox(width: 8),
              AnimatedBuilder(
                animation: _glowController,
                builder: (context, child) => Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: PptColors.tniGreenNeon
                        .withValues(alpha: 0.08 + _glowController.value * 0.06),
                    border: Border.all(
                        color: PptColors.tniGreenNeon
                            .withValues(alpha: 0.5 + _glowController.value * 0.3)),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 7,
                        height: 7,
                        decoration: BoxDecoration(
                          color: PptColors.tniGreenNeon
                              .withValues(alpha: 0.5 + _glowController.value * 0.5),
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text('SYS OPTIMAL',
                          style: PptTypography.tacticalBadge(
                              color: PptColors.tniGreenDark)),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Row(
            children: [
              _hudbadge(
                text: widget.controller.formattedTimer,
                borderColor: PptColors.glassBorderLight,
                icon: Icons.timer_outlined,
                iconColor: PptColors.textMuted,
                isMonospace: true,
              ),
              const SizedBox(width: 8),
              InkWell(
                onTap: () => widget.controller.toggleAudio(),
                borderRadius: BorderRadius.circular(6),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: widget.controller.isMuted
                        ? Colors.white
                        : PptColors.emasNanggroe.withValues(alpha: 0.1),
                    border: Border.all(
                      color: widget.controller.isMuted
                          ? PptColors.glassBorderLight
                          : PptColors.emasNanggroe,
                    ),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        widget.controller.isMuted
                            ? Icons.volume_off_rounded
                            : Icons.volume_up_rounded,
                        size: 14,
                        color: widget.controller.isMuted
                            ? PptColors.textMuted
                            : PptColors.emasDeep,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        widget.controller.isMuted ? 'MUTED' : 'SFX ON',
                        style: PptTypography.tacticalBadge(
                          color: widget.controller.isMuted
                              ? PptColors.textMuted
                              : PptColors.emasDeep,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _hudbadge({
    Gradient? gradient,
    required String text,
    Color borderColor = const Color(0x33CBD5E1),
    IconData? icon,
    Color iconColor = PptColors.textMuted,
    Color textColor = PptColors.tniGreenDark,
    bool isMonospace = false,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
      decoration: BoxDecoration(
        gradient: gradient,
        color: gradient == null ? Colors.white : null,
        border: Border.all(color: borderColor),
        borderRadius: BorderRadius.circular(6),
        boxShadow: gradient != null
            ? [
                BoxShadow(
                  color: (gradient as LinearGradient)
                      .colors
                      .first
                      .withValues(alpha: 0.25),
                  blurRadius: 8,
                  offset: const Offset(0, 2),
                )
              ]
            : null,
      ),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(icon, size: 12, color: iconColor),
            const SizedBox(width: 5),
          ],
          isMonospace
              ? Text(text,
                  style: PptTypography.mono(
                      fontSize: 11, color: PptColors.textPrimary))
              : Text(text, style: PptTypography.tacticalBadge(color: textColor)),
        ],
      ),
    );
  }

  Widget _buildBottomNavHud() {
    final int current = widget.controller.currentIndex + 1;
    final int total = widget.slides.length;
    final double progress = current / total;

    return Container(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
          colors: [
            Colors.white.withValues(alpha: 0.96),
            Colors.white.withValues(alpha: 0.0),
          ],
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Progress Bar animasi
          AnimatedContainer(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: SizedBox(
                height: 3,
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: PptColors.glassBorderLight,
                  valueColor:
                      const AlwaysStoppedAnimation<Color>(PptColors.merahIndonesia),
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // Tombol BACK — enhanced dengan ripple & shadow
              _NavButton(
                label: '◀  KEMBALI',
                onTap: widget.controller.hasPrevious
                    ? () => widget.controller.previousSlide()
                    : null,
                isActive: widget.controller.hasPrevious,
                isPrimary: false,
              ),

              // Slide Counter dengan dot indicators
              _buildDotIndicator(current, total),

              // Tombol NEXT — enhanced vibrant red
              _NavButton(
                label: 'LANJUT  ▶',
                onTap: widget.controller.hasNext
                    ? () => widget.controller.nextSlide()
                    : null,
                isActive: widget.controller.hasNext,
                isPrimary: true,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildDotIndicator(int current, int total) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 5),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: PptColors.merahIndonesia.withValues(alpha: 0.3)),
            boxShadow: [
              BoxShadow(
                  color: PptColors.merahIndonesia.withValues(alpha: 0.08),
                  blurRadius: 8)
            ],
          ),
          child: Row(
            children: [
              Text(
                current.toString().padLeft(2, '0'),
                style: PptTypography.mono(
                    fontSize: 14,
                    color: PptColors.merahIndonesia,
                    fontWeight: FontWeight.w900),
              ),
              Text(' / $total',
                  style: PptTypography.mono(
                      fontSize: 11, color: PptColors.textMuted)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSideSlideStrip() {
    return Container(
      width: 32,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.7),
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(8), bottomLeft: Radius.circular(8)),
        border: Border(left: BorderSide(color: PptColors.glassBorderLight)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: List.generate(widget.slides.length, (i) {
          final isActive = i == widget.controller.currentIndex;
          return GestureDetector(
            onTap: () => widget.controller.jumpToSlide(i),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 250),
              margin: const EdgeInsets.symmetric(vertical: 2, horizontal: 5),
              width: isActive ? 20 : 14,
              height: isActive ? 5 : 3,
              decoration: BoxDecoration(
                color: isActive
                    ? PptColors.merahIndonesia
                    : PptColors.glassBorderLight,
                borderRadius: BorderRadius.circular(3),
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ── Tombol Navigasi Enhanced ────────────────────────────────────────────────
class _NavButton extends StatefulWidget {
  final String label;
  final VoidCallback? onTap;
  final bool isActive;
  final bool isPrimary;

  const _NavButton({
    required this.label,
    this.onTap,
    required this.isActive,
    required this.isPrimary,
  });

  @override
  State<_NavButton> createState() => _NavButtonState();
}

class _NavButtonState extends State<_NavButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _hoverController;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _hoverController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 180),
    );
  }

  @override
  void dispose() {
    _hoverController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: widget.isActive ? SystemMouseCursors.click : SystemMouseCursors.basic,
      onEnter: (_) {
        if (widget.isActive) {
          setState(() => _isHovered = true);
          _hoverController.forward();
        }
      },
      onExit: (_) {
        setState(() => _isHovered = false);
        _hoverController.reverse();
      },
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _hoverController,
          builder: (context, child) {
            final scale = 1.0 + (_hoverController.value * 0.03);
            return Transform.scale(
              scale: scale,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 9),
                decoration: BoxDecoration(
                  gradient: widget.isPrimary && widget.isActive
                      ? LinearGradient(
                          colors: _isHovered
                              ? [
                                  PptColors.merahVibrant,
                                  PptColors.merahDeep
                                ]
                              : [
                                  PptColors.merahIndonesia,
                                  PptColors.merahDeep
                                ],
                        )
                      : null,
                  color: !widget.isPrimary && widget.isActive
                      ? (_isHovered ? PptColors.backgroundAlt : Colors.white)
                      : !widget.isActive
                          ? Colors.grey.shade200
                          : null,
                  borderRadius: BorderRadius.circular(8),
                  border: !widget.isPrimary
                      ? Border.all(
                          color: widget.isActive
                              ? PptColors.glassBorderLight
                              : Colors.transparent)
                      : null,
                  boxShadow: widget.isPrimary && widget.isActive
                      ? [
                          BoxShadow(
                            color: PptColors.merahIndonesia.withValues(
                                alpha: 0.3 + _hoverController.value * 0.2),
                            blurRadius: 12 + _hoverController.value * 8,
                            offset: const Offset(0, 4),
                          )
                        ]
                      : null,
                ),
                child: Text(
                  widget.label,
                  style: PptTypography.tacticalBadge(
                    color: widget.isPrimary && widget.isActive
                        ? Colors.white
                        : widget.isActive
                            ? PptColors.textPrimary
                            : PptColors.textMuted,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
