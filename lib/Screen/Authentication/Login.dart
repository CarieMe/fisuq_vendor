import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/authentication/send_otp.dart';
import 'package:vendor/screen/term_feed/policys.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/network_availablity.dart';
import 'package:vendor/widget/no_network.dart';
import 'package:vendor/widget/routes.dart';
import 'package:vendor/widget/system_chrome_settings.dart';
import 'package:vendor/widget/validation.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> with TickerProviderStateMixin {
//==============================================================================
//============================= Variables Declaration ==========================

  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  TextEditingController mobilenumberController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode? passFocus, monoFocus = FocusNode();
  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();
  Animation? buttonSqueezeanimation;
  final mobileController = TextEditingController();

//==============================================================================
//============================= INIT Method ====================================
  setStateNow() {
    setState(() {});
  }

  bool isShowPass = true;
  @override
  void initState() {
    SystemChromeSettings.setSystemButtomNavigationBarithTopAndButtom();
    SystemChromeSettings.setSystemUIOverlayStyleWithDarkBrightNessStyle();
    super.initState();
    context.read<LoginProvider>().buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    buttonSqueezeanimation = Tween(
      begin: width * 0.7,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: context.read<LoginProvider>().buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
    setState(() {
      //mobileController.text = "Enter mobile number";
      //passwordController.text = "Enter password";
    });
  }

//==============================================================================
//============================= For Animation ==================================

  Future<void> _playAnimation() async {
    try {
      await context.read<LoginProvider>().buttonController!.forward();
    } on TickerCanceled {
      debugPrint('cancelled');
    }
  }

  void validateAndSubmit() async {
    if (validateAndSave()) {
      _playAnimation();
      checkNetwork();
    }
  }

//==============================================================================
//============================= Network Checking ===============================

  Future<void> checkNetwork() async {
    context
        .read<LoginProvider>()
        .getLoginUser(context, scaffoldMessengerKey, setStateNow);
  }

  bool validateAndSave() {
    final form = _formkey.currentState!;
    form.save();
    if (form.validate()) {
      return true;
    }
    return false;
  }

//==============================================================================
//============================= Dispose Method =================================

  @override
  void dispose() {
    SystemChromeSettings.setSystemButtomNavigationBarithTopAndButtom();
    SystemChromeSettings.setSystemUIOverlayStyleWithLightBrightNessStyle();
    context.read<LoginProvider>().buttonController!.dispose();
    super.dispose();
  }

//==============================================================================
//============================= No Internet Widget =============================
  setStateNoInternate() async {
    Navigator.pushReplacement(
      context,
      CupertinoPageRoute(builder: (BuildContext context) => super.widget),
    );
  }

//==============================================================================
//============================= Term And Policy ================================

  termAndPolicyTxt() {
    return Padding(
      padding: const EdgeInsets.only(
        bottom: 3.0,
        left: 25.0,
        right: 25.0,
        top: 10.0,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            Local.continueandagree,
            style: Theme.of(context).textTheme.caption!.copyWith(
                  color: fontColor,
                  fontWeight: FontWeight.normal,
                ),
          ),
          const SizedBox(
            height: 3.0,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      CupertinoPageRoute(
                        builder: (context) =>
                            ChangeNotifierProvider<SystemProvider>(
                          create: (context) => SystemProvider(),
                          child: Policy(
                            title: Local.termconditions,
                          ),
                        ),
                      ),
                    );
                  },
                  child: Text(
                    Local.termsandconditions,
                    style: Theme.of(context).textTheme.caption!.copyWith(
                        color: fontColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.normal),
                  )),
              const SizedBox(
                width: 5.0,
              ),
              Text(
                Local.and,
                style: Theme.of(context)
                    .textTheme
                    .caption!
                    .copyWith(color: fontColor, fontWeight: FontWeight.normal),
              ),
              const SizedBox(
                width: 5.0,
              ),
              InkWell(
                onTap: () {
                  Navigator.push(
                    context,
                    CupertinoPageRoute(
                      builder: (context) =>
                          ChangeNotifierProvider<SystemProvider>(
                        create: (context) => SystemProvider(),
                        child: Policy(
                          title: Local.privacypolicy,
                        ),
                      ),
                    ),
                  );
                },
                child: Text(
                  Local.privacypolicylabel,
                  style: Theme.of(context).textTheme.caption!.copyWith(
                        color: fontColor,
                        decoration: TextDecoration.underline,
                        fontWeight: FontWeight.normal,
                      ),
                ),
              ),
              Text(
                ",",
                style: Theme.of(context).textTheme.caption!.copyWith(
                      color: fontColor,
                      fontWeight: FontWeight.normal,
                    ),
              ),
            ],
          ),
        ],
      ),
    );
  }

//==============================================================================
//============================= Seller Registration Text ===================================

//==============================================================================
//============================= Build Method ===================================

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return ScaffoldMessenger(
      key: scaffoldMessengerKey,
      child: Scaffold(
        key: _scaffoldKey,
        backgroundColor: Theme.of(context).backgroundColor,
        body: isNetworkAvail
            ? Form(
                key: _formkey,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 100, 20, 50),
                  child: Stack(
                    fit: StackFit.expand,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          getLogo(),
                        ],
                      ),

                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          signInTxt(),
                          signInSubTxt(),
                          setMobileNo(),
                          setPass(),
                        ],
                      ),

                      //forgetPass(),
                      Visibility(
                        visible: MediaQuery.of(context).viewInsets.bottom == 0,
                        replacement: const SizedBox.shrink(),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            loginBtn(),
                          ],
                        ),
                      ),

                      //setDontHaveAcc(),
                      // termAndPolicyTxt(),
                    ],
                  ),
                ),
              )
            : noInternet(context, setStateNoInternate, buttonSqueezeanimation,
                context.read<LoginProvider>().buttonController),
      ),
    );
  }

  Widget setSignInLabel() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Align(
        alignment: Alignment.center,
        child: Text(
          Local.login,
          style: const TextStyle(
            color: primary,
            fontSize: textFontSize30,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  setDontHaveAcc() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 25.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Don't have an account? ",
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  color: black,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'ubuntu',
                ),
          ),
          InkWell(
            onTap: () {
              Routes.navigateToSellerRegister(context);
            },
            child: Text(
              'Sign Up',
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'ubuntu',
                  ),
            ),
          )
        ],
      ),
    );
  }

  setMobileNo() {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: NeuContainer.simple(
        context: context,
        child: TextFildLogin(
          onFieldSubmitted: (v) {
            FocusScope.of(context).requestFocus(passFocus);
          },
          keyboardType: TextInputType.number,
          controller: mobileController,
          focusNode: monoFocus,
          textInputAction: TextInputAction.done,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (val) => StringValidation.validateMob(val!, context),
          hintText: "Enter mobile number",
          onSaved: (String? value) {
            context.read<LoginProvider>().mobile = value;
          },
        ),
      ),
    );
  }

  setPass() {
    return Padding(
      padding: const EdgeInsets.only(top: 18),
      child: NeuContainer.simple(
        context: context,
        child: TextFildLogin(
          keyboardType: TextInputType.text,
          obscureText: isShowPass,
          controller: passwordController,
          focusNode: passFocus,
          textInputAction: TextInputAction.done,
          maxLines: 1,
          validator: (val) => StringValidation.validatePass(val!, context),
          onSaved: (String? value) {
            context.read<LoginProvider>().password = value;
          },
          hintText: Local.passwordlable,
          suffixIcon: InkWell(
            onTap: () {
              setState(
                () {
                  isShowPass = !isShowPass;
                },
              );
            },
            child: Padding(
              padding: const EdgeInsetsDirectional.only(end: 10.0),
              child: Icon(
                !isShowPass ? Icons.visibility : Icons.visibility_off,
                color: fontColor.withOpacity(0.4),
                size: 22,
              ),
            ),
          ),
        ),
      ),
    );
  }

  loginBtn() {
    return AppButton.main(
      data: Local.signinlabel,
      onTap: () async {
        validateAndSubmit();
      },
    );
  }

  Widget getLogo() {
    return SvgPicture.asset(
      DesignConfiguration.setSvgPath('logo3'),
      alignment: Alignment.center,
      height: 70,
      width: 90,
      fit: BoxFit.contain,
    );
  }

  signInSubTxt() {
    return const Padding(
      padding: EdgeInsetsDirectional.only(
        top: 13.0,
      ),
      child: BlNor(
        data: 'Please enter your login details below to start using app.',
      ),
    );
  }

  signInTxt() {
    return const Padding(
      padding: EdgeInsetsDirectional.only(
        top: 40.0,
      ),
      child: HlBol(
        data: "Welcome Fisuq Vendor",
      ),
    );
  }

  forgetPass() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(top: 30.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: <Widget>[
          InkWell(
            onTap: () {
              Navigator.push(
                context,
                CupertinoPageRoute(
                  builder: (context) => SendOtp(
                    title: getTranslated(context, 'FORGOT_PASS_TITLE'),
                  ),
                ),
              );
            },
            child: Text(
              getTranslated(context, 'FORGOT_PASSWORD_LBL')!,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.bold,
                    fontSize: textFontSize13,
                    fontFamily: 'ubuntu',
                  ),
            ),
          ),
        ],
      ),
    );
  }
}

setSnackbarScafold(
    GlobalKey<ScaffoldMessengerState> scafoldkey, contex, String msg) {
  scafoldkey.currentState!.showSnackBar(
    SnackBar(
      content: Text(
        msg,
        textAlign: TextAlign.center,
        style: const TextStyle(
          color: fontColor,
        ),
      ),
      duration: const Duration(
        milliseconds: 3000,
      ),
      backgroundColor: lightWhite,
      elevation: 1.0,
    ),
  );
}
