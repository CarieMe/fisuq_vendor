// import 'package:fisuq_vendor/Widget/desing.dart';
// import 'package:fisuq_vendor/Widget/validation.dart';
// import 'package:fisuq_vendor/theming/colors/app_colors.dart';
// import 'package:fisuq_vendor/theming/text/text.dart';
// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class ButtonSettings extends StatefulWidget {
//   const ButtonSettings({
//     super.key,
//     this.pressedOpacity = 0.4,
//     required this.onPressed,
//     required this.title,
//     required this.img,
//     this.top,
//   }) : assert(pressedOpacity == null ||
//             (pressedOpacity >= 0.0 && pressedOpacity <= 1.0));

//   final VoidCallback? onPressed;
//   final double? pressedOpacity;
//   final String title;
//   final String img;
//   final bool? top;
//   bool get enabled => onPressed != null;

//   @override
//   State<ButtonSettings> createState() => _ButtonSettingsState();

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties
//         .add(FlagProperty('enabled', value: enabled, ifFalse: 'disabled'));
//   }
// }

// class _ButtonSettingsState extends State<ButtonSettings>
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
//   void didUpdateWidget(ButtonSettings old) {
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
//               minHeight: 46,
//             ),
//             child: FadeTransition(
//               opacity: _opacityAnimation,
//               child: Align(
//                 alignment: Alignment.center,
//                 widthFactor: 1.0,
//                 heightFactor: 1.0,
//                 child: Container(
//                   clipBehavior: Clip.antiAlias,
//                   decoration: BoxDecoration(
//                     borderRadius: BorderRadius.only(
//                       topRight: Radius.circular(
//                         widget.top == null
//                             ? 0
//                             : widget.top == true
//                                 ? 8
//                                 : 0,
//                       ),
//                       topLeft: Radius.circular(
//                         widget.top == null
//                             ? 0
//                             : widget.top == true
//                                 ? 8
//                                 : 0,
//                       ),
//                       bottomLeft: Radius.circular(
//                         widget.top == null
//                             ? 0
//                             : widget.top == true
//                                 ? 0
//                                 : 8,
//                       ),
//                       bottomRight: Radius.circular(
//                         widget.top == null
//                             ? 0
//                             : widget.top == true
//                                 ? 0
//                                 : 8,
//                       ),
//                     ),
//                     color: Theme.of(context).cardColor,
//                   ),
//                   child: Padding(
//                     padding: const EdgeInsets.fromLTRB(25, 10, 10, 10),
//                     child: Row(
//                       children: [
//                         Expanded(
//                           flex: 0,
//                           child: widget.title ==
//                                   getTranslated(context, 'YOUR_PROM_CO')
//                               ? Container(
//                                   decoration: BoxDecoration(
//                                     color: AppColor.primary,
//                                     borderRadius: BorderRadius.circular(5.0),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(5.0),
//                                     child: Image.asset(
//                                       DesignConfiguration.setPngPath(
//                                           widget.img),
//                                       height: 18,
//                                       width: 18,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 )
//                               : Container(
//                                   decoration: BoxDecoration(
//                                     color: AppColor.primary,
//                                     borderRadius: BorderRadius.circular(5.0),
//                                   ),
//                                   child: Padding(
//                                     padding: const EdgeInsets.all(5.0),
//                                     child: SvgPicture.asset(
//                                       DesignConfiguration.setSvgPath(
//                                         widget.img,
//                                       ),
//                                       height: 18,
//                                       width: 18,
//                                       color: Colors.white,
//                                     ),
//                                   ),
//                                 ),
//                         ),
//                         const SizedBox(width: 30),
//                         Expanded(flex: 1, child: TextTL(widget.title)),
//                         const Expanded(
//                           flex: 0,
//                           child: Icon(
//                             Icons.navigate_next,
//                           ),
//                         )
//                       ],
//                     ),
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
