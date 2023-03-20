// import 'package:carieme_user/exports/exports_strings.dart';
// import 'package:easy_localization/easy_localization.dart';

// class Validate {
// // product name velidatation
//   static String? required(String? value) {
//     if (value!.isEmpty) {
//       return LocaleKeys.thisfieldisrequired.tr();
//     }
//     return null;
//   }
// // password verification

// // sort detail velidatation

//   static String? sort(String? value) {
//     if (value!.isEmpty) {
//       return LocaleKeys.sortdescriptionisrequired.tr();
//     }
//     if (value.length < 3) {
//       return LocaleKeys.minimam5characterisrequired.tr();
//     }
//     return null;
//   }

// // product name velidatation

//   static String? product(String? value) {
//     if (value!.isEmpty) {
//       return LocaleKeys.productnamerequired.tr();
//     }
//     if (value.length < 3) {
//       return LocaleKeys.validproductname.tr();
//     }
//     return null;
//   }

// //mobile verification

//   static String? mobile(String? value) {
//     if (value!.isEmpty) {
//       return LocaleKeys.mobilerequired.tr();
//     }
//     if (value.length < 5) {
//       return LocaleKeys.validmobile.tr();
//     }
//     return null;
//   }

//   static String? password(String? value) {
//     if (value!.isEmpty) {
//       return LocaleKeys.passwordrequired.tr();
//     } else if (value.length <= 5) {
//       return LocaleKeys.passworthlength.tr();
//     } else {
//       return null;
//     }
//   }

//   static String? confirm(String? value, String? confirm) {
//     if (value!.isEmpty) {
//       return LocaleKeys.confirmpasswordrequired.tr();
//     } else if (value != confirm) {
//       return LocaleKeys.confirmpasswordnotmatch.tr();
//     } else {
//       return null;
//     }
//   }

// // command for many fields

//   static String? field(String? value) {
//     if (value!.isEmpty) {
//       return LocaleKeys.fieldrequired.tr();
//     } else {
//       return null;
//     }
//   }

// // name validation

//   static String? username(String? value) {
//     if (value!.isEmpty) {
//       return LocaleKeys.usernamerequired.tr();
//     }
//     if (value.length <= 1) {
//       return LocaleKeys.usernamelenth.tr();
//     }
//     return null;
//   }

//   static String capitalize(String s) {
//     if (s == "") {
//       return "";
//     } else {
//       return s[0].toUpperCase() + s.substring(1);
//     }
//   }
// }
