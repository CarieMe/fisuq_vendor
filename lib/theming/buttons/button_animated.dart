// import 'package:carieme_user/theming/base/app_color.dart';
// import 'package:carieme_user/theming/text/app_texts.dart';
// import 'package:carieme_user/utils/utils_allert.dart';
// import 'package:carieme_user/utils/utils_corners.dart';
// import 'package:carieme_user/widgets/custom/loader/dot_loader.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/foundation.dart';

// class ButtonAnimated extends StatefulWidget {
//   const ButtonAnimated({
//     super.key,
//     required this.data,
//     this.pressedOpacity = 0.4,
//     required this.onPressed,
//     required this.btnCntrl,
//     required this.btnAnim,
//   }) : assert(pressedOpacity == null ||
//             (pressedOpacity >= 0.0 && pressedOpacity <= 1.0));
//   final String data;
//   final VoidCallback? onPressed;
//   final double? pressedOpacity;
//   bool get enabled => onPressed != null;
//   final AnimationController btnCntrl;
//   final Animation btnAnim;
// // 
//   @override
//   State<ButtonAnimated> createState() => _ButtonAnimatedState();

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties.add(
//       FlagProperty('enabled', value: enabled, ifFalse: 'disabled'),
//     );
//   }
// }

// class _ButtonAnimatedState extends State<ButtonAnimated>
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
//   void didUpdateWidget(ButtonAnimated old) {
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
//     return AnimatedBuilder(
//       builder: builder,
//       animation: widget.btnCntrl,
//     );
//   }

//   Widget builder(BuildContext context, Widget? child) {
//     final bool enabled = widget.enabled;
//     Color backgroundColor = AppColors.primary;
//     final Color disabledColor = AppColors.primary.withOpacity(.5);
//     return MouseRegion(
//       cursor: enabled && kIsWeb ? SystemMouseCursors.click : MouseCursor.defer,
//       child: GestureDetector(
//         behavior: HitTestBehavior.opaque,
//         onTapDown: enabled ? _handleTapDown : null,
//         onTapUp: enabled ? _handleTapUp : null,
//         onTapCancel: enabled ? _handleTapCancel : null,
//         onTap: () {
//           Allert.tap();
//           widget.onPressed;
//         },
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
//                   borderRadius: Corners.br8,
//                   color: !enabled ? disabledColor : backgroundColor,
//                   gradient: LinearGradient(
//                     begin: Alignment.topLeft,
//                     end: Alignment.bottomRight,
//                     colors: [
//                       AppColors.primary,
//                       AppColors.secondary,
//                     ],
//                     stops: [0, 1],
//                   ),
//                 ),
//                 child: Align(
//                   alignment: Alignment.center,
//                   widthFactor: 1.0,
//                   heightFactor: .0,
//                   child: widget.btnAnim.value > 75.0
//                       ? TextH.white(data: widget.data, bold: true, size: 3)
//                       : DotLoader(color: AppColors.light0, size: 30),
//                 ),
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
