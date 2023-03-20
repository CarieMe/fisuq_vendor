// import 'package:fisuq_vendor/theming/colors/app_colors.dart';
// import 'package:fisuq_vendor/theming/helper/const_corners.dart';
// import 'package:fisuq_vendor/theming/text/text.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';

// class ButtonMain extends StatefulWidget {
//   const ButtonMain({
//     super.key,
//     required this.data,
//     this.pressedOpacity = 0.4,
//     required this.onPressed,
//   }) : assert(pressedOpacity == null ||
//             (pressedOpacity >= 0.0 && pressedOpacity <= 1.0));
//   final String data;
//   final VoidCallback? onPressed;
//   final double? pressedOpacity;
//   bool get enabled => onPressed != null;

//   @override
//   State<ButtonMain> createState() => _ButtonMainState();

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties
//         .add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'));
//   }
// }

// class _ButtonMainState extends State<ButtonMain>
//     with SingleTickerProviderStateMixin {
//   static const Duration kFadeOutDuration = Duration(milliseconds: 120);
//   static const Duration kFadeInDuration = Duration(milliseconds: 180);
//   final Tween<double> _opacityTween = Tween<double>(begin: 1.0);

//   late AnimationController _animationController;
//   late Animation<double> _opacityAnimation;

//   @override
//   void initState() {
//     super.initState();
//     _animationController = AnimationController(
//       duration: const Duration(milliseconds: 200),
//       value: 0.0,
//       vsync: this,
//     );
//     _opacityAnimation = _animationController
//         .drive(CurveTween(curve: Curves.decelerate))
//         .drive(_opacityTween);
//     _setTween();
//   }

//   @override
//   void didUpdateWidget(ButtonMain old) {
//     super.didUpdateWidget(old);
//     _setTween();
//   }

//   void _setTween() {
//     _opacityTween.end = widget.pressedOpacity ?? 1.0;
//   }

//   @override
//   void dispose() {
//     _animationController.dispose();
//     super.dispose();
//   }

//   bool _buttonHeldDown = false;

//   void _handleTapDown(TapDownDetails event) {
//     if (!_buttonHeldDown) {
//       _buttonHeldDown = true;
//       _animate();
//     }
//   }

//   void _handleTapUp(TapUpDetails event) {
//     if (_buttonHeldDown) {
//       _buttonHeldDown = false;
//       _animate();
//     }
//   }

//   void _handleTapCancel() {
//     if (_buttonHeldDown) {
//       _buttonHeldDown = false;
//       _animate();
//     }
//   }

//   void _animate() {
//     if (_animationController.isAnimating) {
//       return;
//     }
//     final bool wasHeldDown = _buttonHeldDown;
//     final TickerFuture ticker = _buttonHeldDown
//         ? _animationController.animateTo(1.0,
//             duration: kFadeOutDuration, curve: Curves.easeInOutCubicEmphasized)
//         : _animationController.animateTo(0.0,
//             duration: kFadeInDuration, curve: Curves.easeOutCubic);
//     ticker.then<void>((void value) {
//       if (mounted && wasHeldDown != _buttonHeldDown) {
//         _animate();
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     final bool enabled = widget.enabled;
//     const Color backgroundColor = AppColor.primary;
//     final Color disabledColor = AppColor.primary.withOpacity(.5);
//     return MouseRegion(
//       cursor: enabled && kIsWeb ? SystemMouseCursors.click : MouseCursor.defer,
//       child: GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTapDown: enabled ? _handleTapDown : null,
//         onTapUp: enabled ? _handleTapUp : null,
//         onTapCancel: enabled ? _handleTapCancel : null,
//         onTap: widget.onPressed,
//         child: Semantics(
//           button: true,
//           child: ConstrainedBox(
//             constraints: const BoxConstraints(
//               minWidth: double.infinity,
//               minHeight: 50,
//             ),
//             child: FadeTransition(
//               opacity: _opacityAnimation,
//               child: DecoratedBox(
//                 decoration: BoxDecoration(
//                   borderRadius: Corners.cornerMd,
//                   color: !enabled ? disabledColor : backgroundColor,
//                   gradient: const LinearGradient(
//                       begin: Alignment.topLeft,
//                       end: Alignment.bottomRight,
//                       colors: [AppColor.primary, AppColor.secondary],
//                       stops: [0, 1]),
//                 ),
//                 child: Align(
//                   alignment: Alignment.center,
//                   widthFactor: 1.0,
//                   heightFactor: .0,
//                   child: Intro(
//                     data: widget.data,
//                     size: 17,
//                     bold: true,
//                   ),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
