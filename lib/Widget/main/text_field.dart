// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:vendor/theming/utils/utils_corners.dart';

// class TextFild extends StatelessWidget {
//   const TextFild({
//     Key? key,
//     this.controller,
//     this.initialValue,
//     this.focusNode,
//     this.decoration,
//     this.keyboardType,
//     this.textCapitalization = TextCapitalization.none,
//     this.textInputAction,
//     this.style,
//     this.strutStyle,
//     this.textDirection,
//     this.textAlign = TextAlign.start,
//     this.textAlignVertical,
//     this.autofocus = false,
//     this.readOnly = false,
//     this.showCursor,
//     this.obscuringCharacter = '•',
//     this.obscureText = false,
//     this.autocorrect = true,
//     this.smartDashesType,
//     this.smartQuotesType,
//     this.enableSuggestions = true,
//     this.maxLengthEnforcement,
//     this.maxLines,
//     this.minLines,
//     this.expands = false,
//     this.maxLength,
//     this.onChanged,
//     this.onTap,
//     this.onEditingComplete,
//     this.onFieldSubmitted,
//     this.onSaved,
//     this.validator,
//     this.inputFormatters,
//     this.enabled,
//     this.cursorWidth = 2.0,
//     this.cursorHeight,
//     this.cursorRadius,
//     this.cursorColor,
//     this.keyboardAppearance,
//     this.scrollPadding = const EdgeInsets.all(20.0),
//     this.enableInteractiveSelection,
//     this.selectionControls,
//     this.buildCounter,
//     this.scrollPhysics,
//     this.autofillHints,
//     this.autovalidateMode,
//     this.scrollController,
//     this.restorationId,
//     this.enableIMEPersonalizedLearning = true,
//     this.mouseCursor,
//     //decoration
//     this.hintText,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.errorText,
//   }) : super(key: key);

//   final TextEditingController? controller;
//   final String? initialValue;
//   final FocusNode? focusNode;
//   final InputDecoration? decoration;
//   final TextInputType? keyboardType;
//   final TextCapitalization textCapitalization;
//   final TextInputAction? textInputAction;
//   final TextStyle? style;
//   final StrutStyle? strutStyle;
//   final TextDirection? textDirection;
//   final TextAlign textAlign;
//   final TextAlignVertical? textAlignVertical;
//   final bool autofocus;
//   final bool readOnly;
//   final bool? showCursor;
//   final String obscuringCharacter;
//   final bool obscureText;
//   final bool autocorrect;
//   final SmartDashesType? smartDashesType;
//   final SmartQuotesType? smartQuotesType;
//   final bool enableSuggestions;
//   final MaxLengthEnforcement? maxLengthEnforcement;
//   final int? maxLines;
//   final int? minLines;
//   final bool expands;
//   final int? maxLength;
//   final void Function(String)? onChanged;
//   final void Function()? onTap;
//   final void Function()? onEditingComplete;
//   final void Function(String)? onFieldSubmitted;
//   final void Function(String?)? onSaved;
//   final String? Function(String?)? validator;
//   final List<TextInputFormatter>? inputFormatters;
//   final bool? enabled;
//   final double cursorWidth;
//   final double? cursorHeight;
//   final Radius? cursorRadius;
//   final Color? cursorColor;
//   final Brightness? keyboardAppearance;
//   final EdgeInsets scrollPadding;
//   final bool? enableInteractiveSelection;
//   final TextSelectionControls? selectionControls;
//   final Widget? Function(BuildContext,
//       {required int currentLength,
//       required bool isFocused,
//       required int? maxLength})? buildCounter;
//   final ScrollPhysics? scrollPhysics;
//   final Iterable<String>? autofillHints;
//   final AutovalidateMode? autovalidateMode;
//   final ScrollController? scrollController;
//   final String? restorationId;
//   final bool enableIMEPersonalizedLearning;
//   final MouseCursor? mouseCursor;

//   //decoration
//   final String? hintText;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final String? errorText;

//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       initialValue: initialValue,
//       focusNode: focusNode,
//       keyboardType: keyboardType,
//       textCapitalization: textCapitalization,
//       textInputAction: textInputAction,
//       style: Theme.of(context).textTheme.bodySmall!,
//       strutStyle: strutStyle,
//       textDirection: textDirection,
//       textAlign: textAlign,
//       textAlignVertical: TextAlignVertical.center,
//       autofocus: autofocus,
//       readOnly: readOnly,
//       showCursor: showCursor,
//       obscuringCharacter: obscuringCharacter,
//       obscureText: obscureText,
//       autocorrect: autocorrect,
//       smartDashesType: smartDashesType,
//       smartQuotesType: smartQuotesType,
//       enableSuggestions: enableSuggestions,
//       maxLengthEnforcement: maxLengthEnforcement,
//       maxLines: maxLines,
//       minLines: minLines,
//       expands: expands,
//       maxLength: maxLength,
//       onChanged: onChanged,
//       onTap: onTap,
//       onEditingComplete: onEditingComplete,
//       onFieldSubmitted: onFieldSubmitted,
//       onSaved: onSaved,
//       validator: validator,
//       inputFormatters: inputFormatters,
//       enabled: enabled,
//       cursorWidth: 1.5,
//       cursorHeight: cursorHeight,
//       cursorRadius: cursorRadius,
//       cursorColor: Theme.of(context).indicatorColor.withOpacity(.5),
//       keyboardAppearance: keyboardAppearance,
//       scrollPadding: scrollPadding,
//       enableInteractiveSelection: enableInteractiveSelection,
//       selectionControls: selectionControls,
//       buildCounter: buildCounter,
//       scrollPhysics: scrollPhysics,
//       autofillHints: autofillHints,
//       autovalidateMode: autovalidateMode,
//       scrollController: scrollController,
//       restorationId: restorationId,
//       enableIMEPersonalizedLearning: enableIMEPersonalizedLearning,
//       mouseCursor: mouseCursor,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: Theme.of(context).textTheme.titleLarge,
//         suffixIcon: suffixIcon,
//         prefixIcon: prefixIcon,
//         labelStyle: Theme.of(context)
//             .textTheme
//             .bodySmall!
//             .copyWith(color: Theme.of(context).disabledColor),
//         errorStyle: Theme.of(context)
//             .textTheme
//             .titleMedium!
//             .copyWith(color: AppColor.red),
//         counterStyle: Theme.of(context).textTheme.titleSmall!,
//         counterText: '',
//         filled: true,
//         fillColor: Theme.of(context).canvasColor,
//         border: OutlineInputBorder(
//           borderSide: BorderSide(color: Theme.of(context).focusColor, width: 1),
//           borderRadius: Corners.cornerMd,
//         ),
//         isCollapsed: true,
//         contentPadding: const EdgeInsets.only(
//           left: 15.0,
//           bottom: 15.0,
//           top: 15.0,
//           right: 15,
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Theme.of(context).focusColor, width: 1),
//           borderRadius: Corners.cornerMd,
//         ),
//         disabledBorder: OutlineInputBorder(
//           borderSide: BorderSide(color: Theme.of(context).focusColor, width: 1),
//           borderRadius: Corners.cornerMd,
//         ),
//         enabledBorder: const UnderlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: Corners.cornerMd,
//         ),
//         errorBorder: const UnderlineInputBorder(
//           borderSide: BorderSide.none,
//           borderRadius: Corners.cornerMd,
//         ),
//         errorText: errorText,
//       ),
//     );
//   }
// }
