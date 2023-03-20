import 'package:vendor/theming/base/app_color.dart';
import 'package:vendor/theming/utils/utils_allert.dart';
import 'package:vendor/theming/utils/utils_corners.dart';
import 'package:vendor/theming/utils/utils_design.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ButtonBadge extends StatefulWidget {
  const ButtonBadge({
    super.key,
    this.pressedOpacity = 0.4,
    required this.onTap,
    required this.svg,
    required this.size,
    this.count,
    required this.badge,
  }) : assert(pressedOpacity == null ||
            (pressedOpacity >= 0.0 && pressedOpacity <= 1.0));

  final VoidCallback? onTap;
  final double? pressedOpacity;
  final String svg;
  final double size;
  final String? count;
  final bool badge;
  bool get enabled => onTap != null;

  @override
  State<ButtonBadge> createState() => _ButtonBadgeState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'));
  }
}

class _ButtonBadgeState extends State<ButtonBadge>
    with SingleTickerProviderStateMixin {
  static const Duration kFadeOutDuration = Duration(milliseconds: 120);
  static const Duration kFadeInDuration = Duration(milliseconds: 180);
  final Tween<double> _opacityTween = Tween<double>(begin: 1.0);

  late AnimationController _animationController;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 200),
      value: 0.0,
      vsync: this,
    );
    _opacityAnimation = _animationController
        .drive(CurveTween(curve: Curves.decelerate))
        .drive(_opacityTween);
    _setTween();
  }

  @override
  void didUpdateWidget(ButtonBadge old) {
    super.didUpdateWidget(old);
    _setTween();
  }

  void _setTween() {
    _opacityTween.end = widget.pressedOpacity ?? 1.0;
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  bool _buttonHeldDown = false;

  void _handleTapDown(TapDownDetails event) {
    if (!_buttonHeldDown) {
      _buttonHeldDown = true;
      _animate();
    }
  }

  void _handleTapUp(TapUpDetails event) {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _handleTapCancel() {
    if (_buttonHeldDown) {
      _buttonHeldDown = false;
      _animate();
    }
  }

  void _animate() {
    if (_animationController.isAnimating) {
      return;
    }
    final bool wasHeldDown = _buttonHeldDown;
    final TickerFuture ticker = _buttonHeldDown
        ? _animationController.animateTo(1.0,
            duration: kFadeOutDuration, curve: Curves.easeInOutCubicEmphasized)
        : _animationController.animateTo(0.0,
            duration: kFadeInDuration, curve: Curves.easeOutCubic);
    ticker.then<void>((void value) {
      if (mounted && wasHeldDown != _buttonHeldDown) {
        _animate();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final bool enabled = widget.enabled;
    return MouseRegion(
      cursor: enabled && kIsWeb ? SystemMouseCursors.click : MouseCursor.defer,
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTapDown: enabled ? _handleTapDown : null,
        onTapUp: enabled ? _handleTapUp : null,
        onTapCancel: enabled ? _handleTapCancel : null,
        onTap: () {
          Allert.tap();
          widget.onTap;
        },
        child: Semantics(
          button: true,
          child: ConstrainedBox(
            constraints: const BoxConstraints(
              minHeight: 38,
            ),
            child: FadeTransition(
              opacity: _opacityAnimation,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Center(
                    child: SvgPicture.asset(
                      SetPath.setSvgPath(widget.svg),
                      color: Theme.of(context).indicatorColor,
                      height: widget.size,
                      width: widget.size,
                    ),
                  ),
                  widget.badge
                      ? (widget.count!.isNotEmpty && widget.count != '0')
                          ? Positioned(
                              top: 8,
                              left: -8,
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: Corners.br100,
                                  border: Border.all(
                                    color: Theme.of(context).indicatorColor,
                                    width: .7,
                                  ),
                                  color: AppColors.red,
                                ),
                                child: Center(
                                  child: Padding(
                                    padding:
                                        const EdgeInsets.fromLTRB(5, 1, 5, 1),
                                    child: Text(
                                      widget.count!,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 14,
                                            color: AppColors.light3,
                                            fontWeight: FontWeight.w600,
                                          ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink()
                      : const SizedBox.shrink()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
