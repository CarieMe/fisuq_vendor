import 'dart:async';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor/helper/color.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/provider/profile_provider.dart';
import 'package:vendor/provider/setting_provider.dart';
import 'package:vendor/screen/profile/widget/first_header.dart';
import 'package:vendor/screen/profile/widget/fourth_header.dart';
import 'package:vendor/screen/profile/widget/profile_image.dart';
import 'package:vendor/screen/profile/widget/second_header.dart';
import 'package:vendor/screen/profile/widget/third_header.dart';
import 'package:vendor/widget/appbar.dart';
import 'package:vendor/widget/button_design.dart';
import 'package:vendor/widget/design.dart';
import 'package:vendor/widget/network_availablity.dart';
import 'package:vendor/widget/routes.dart';
import 'package:vendor/widget/validation.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

String? lat, long;
ProfileProvider? profileProvider;

class _ProfileState extends State<Profile> with TickerProviderStateMixin {
  setStateNow() {
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider!.initializeVariable();
    profileProvider!.mobileC = TextEditingController();
    profileProvider!.nameC = TextEditingController();
    profileProvider!.emailC = TextEditingController();
    profileProvider!.addressC = TextEditingController();
    profileProvider!.storenameC = TextEditingController();
    profileProvider!.storeurlC = TextEditingController();
    profileProvider!.storeDescC = TextEditingController();
    profileProvider!.accnameC = TextEditingController();
    profileProvider!.accnumberC = TextEditingController();
    profileProvider!.bankcodeC = TextEditingController();
    profileProvider!.banknameC = TextEditingController();
    profileProvider!.latitututeC = TextEditingController();
    profileProvider!.longituteC = TextEditingController();
    profileProvider!.taxnameC = TextEditingController();
    profileProvider!.pannumberC = TextEditingController();
    profileProvider!.taxnumberC = TextEditingController();
    profileProvider!.getSallerDetail(context, setStateNow);

    profileProvider!.buttonController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);

    profileProvider!.buttonSqueezeanimation = Tween(
      begin: width * 0.7,
      end: 50.0,
    ).animate(
      CurvedAnimation(
        parent: profileProvider!.buttonController!,
        curve: const Interval(
          0.0,
          0.150,
        ),
      ),
    );
  }
//==============================================================================
//============================= dispose method =================================

  @override
  void dispose() {
    profileProvider!.buttonController!.dispose();
    profileProvider!.mobileC?.dispose();
    profileProvider!.nameC?.dispose();
    profileProvider!.addressC!.dispose();
    profileProvider!.emailC!.dispose();
    profileProvider!.storenameC!.dispose();
    profileProvider!.storeurlC!.dispose();
    profileProvider!.storeDescC!.dispose();
    profileProvider!.accnameC!.dispose();
    profileProvider!.accnumberC!.dispose();
    profileProvider!.bankcodeC!.dispose();
    profileProvider!.banknameC!.dispose();
    profileProvider!.latitututeC!.dispose();
    profileProvider!.longituteC!.dispose();
    profileProvider!.taxnameC!.dispose();
    profileProvider!.pannumberC!.dispose();
    profileProvider!.taxnumberC!.dispose();
    super.dispose();
  }

//==============================================================================
//========================== build Method ======================================

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      key: profileProvider!.scaffoldKey,
      backgroundColor: lightWhite,
      body: Stack(
        children: <Widget>[
          bodyPart(),
          DesignConfiguration.showCircularProgress(
            profileProvider!.isLoading,
            primary,
          )
        ],
      ),
    );

    // bottomNavigationBar: AppBtn(
    //   title: getTranslated(context, "Update Profile")!,
    //   btnAnim: profileProvider!.buttonSqueezeanimation,
    //   btnCntrl: profileProvider!.buttonController,
    //   paddingRequired: true,
    //   onBtnSelected: () async {
    //     _playAnimation();
    //     checkNetwork();
    //   },
    // ));
  }

//==============================================================================
//========================== build Method ======================================
  bodyPart() {
    return Column(
      children: [
        GradientAppBar(
          Local.editprofilelabel,
        ),
        Flexible(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 10,
              ),
              child: Column(
                children: <Widget>[
                  GetProfileImage(update: setStateNow),
                  GetFirstHeader(setStateNow: setStateNow),
                  GetSecondHeader(setStateNow: setStateNow),
                  GetThirdHeader(setStateNow: setStateNow),
                  GetFurthHeader(setStateNow: setStateNow),
                  changePass(),
                  // updateBtn(),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }

//==============================================================================
//============================ Change Pass =====================================

  changePass() {
    return Container(
      width: width,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(circularBorderRadius10),
        ),
        color: white,
      ),
      child: InkWell(
        child: Padding(
          padding: const EdgeInsets.only(
            left: 20.0,
            top: 15.0,
            bottom: 15.0,
            right: 20.0,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                Local.changepasswordlabel,
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: primary, fontWeight: FontWeight.bold),
              ),
              InkWell(
                onTap: () {
                  _showDialog(context);
                },
                child: const Padding(
                  padding: EdgeInsets.only(right: 12.0),
                  child: Icon(
                    Icons.edit,
                    color: black,
                    size: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _showDialog(BuildContext ctx) async {
    await showDialog(
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setStater) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0.0),
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(circularBorderRadius5),
                ),
              ),
              content: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20.0, 20.0, 0, 2.0),
                      child: Text(
                        Local.changepasswordlabel,
                        style: Theme.of(this.context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: primary),
                      ),
                    ),
                    const Divider(color: lightBlack),
                    Form(
                      key: profileProvider!.formKey,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              onChanged: (value) =>
                                  {profileProvider!.curPass = value},
                              onSaved: (value) =>
                                  {profileProvider!.curPass = value},
                              keyboardType: TextInputType.text,
                              validator: (val) =>
                                  StringValidation.validatePass(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                hintText: Local.currentpasswordlable,
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                      color: lightBlack,
                                      fontWeight: FontWeight.normal,
                                    ),
                                suffixIcon: IconButton(
                                  icon: Icon(
                                    profileProvider!.showCurPassword
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                  ),
                                  iconSize: 20,
                                  color: lightBlack,
                                  onPressed: () {
                                    setStater(
                                      () {
                                        profileProvider!.showCurPassword =
                                            !profileProvider!.showCurPassword;
                                      },
                                    );
                                  },
                                ),
                              ),
                              obscureText: !profileProvider!.showCurPassword,
                              controller: profileProvider!.curPassC,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              onChanged: (value) =>
                                  {profileProvider!.newPass = value},
                              onSaved: (value) =>
                                  {profileProvider!.newPass = value},
                              keyboardType: TextInputType.text,
                              validator: (val) =>
                                  StringValidation.validatePass(val, context),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                hintText: Local.newpasslbl,
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: lightBlack,
                                        fontWeight: FontWeight.normal),
                                suffixIcon: IconButton(
                                  icon: Icon(profileProvider!.showPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  iconSize: 20,
                                  color: lightBlack,
                                  onPressed: () {
                                    setStater(
                                      () {
                                        profileProvider!.showPassword =
                                            !profileProvider!.showPassword;
                                      },
                                    );
                                  },
                                ),
                              ),
                              obscureText: !profileProvider!.showPassword,
                              controller: profileProvider!.newPassC,
                            ),
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.fromLTRB(20.0, 0, 20.0, 0),
                            child: TextFormField(
                              keyboardType: TextInputType.text,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return Local.confirmpasswordrequired;
                                }
                                if (value != profileProvider!.newPass) {
                                  return Local.confirmpasswordnotmatch;
                                } else {
                                  return null;
                                }
                              },
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              decoration: InputDecoration(
                                hintText: Local.confirmpasswordlabel,
                                hintStyle: Theme.of(this.context)
                                    .textTheme
                                    .subtitle1!
                                    .copyWith(
                                        color: lightBlack,
                                        fontWeight: FontWeight.normal),
                                suffixIcon: IconButton(
                                  icon: Icon(profileProvider!.showCmPassword
                                      ? Icons.visibility
                                      : Icons.visibility_off),
                                  iconSize: 20,
                                  color: lightBlack,
                                  onPressed: () {
                                    setStater(
                                      () {
                                        profileProvider!.showCmPassword =
                                            !profileProvider!.showCmPassword;
                                      },
                                    );
                                  },
                                ),
                              ),
                              obscureText: !profileProvider!.showCmPassword,
                              controller: profileProvider!.confPassC,
                              onChanged: (v) => setState(
                                () {
                                  profileProvider!.confPass = v;
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              actions: <Widget>[
                TextButton(
                  child: Text(
                    Local.cancel,
                    style: Theme.of(this.context).textTheme.subtitle2!.copyWith(
                        color: lightBlack, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    Routes.pop(context);
                  },
                ),
                TextButton(
                  child: Text(
                    Local.savelbl,
                    style: Theme.of(this.context)
                        .textTheme
                        .subtitle2!
                        .copyWith(color: primary, fontWeight: FontWeight.bold),
                  ),
                  onPressed: () {
                    final form = profileProvider!.formKey.currentState!;
                    if (form.validate()) {
                      setState(
                        () {
                          Routes.pop(context);
                        },
                      );
                      profileProvider!.changePassWord(ctx, setStateNow);
                    }
                  },
                )
              ],
            );
          },
        );
      },
    );
  }

  updateBtn() {
    return AppBtn(
      title: Local.updateprofile,
      btnAnim: profileProvider!.buttonSqueezeanimation,
      btnCntrl: profileProvider!.buttonController,
      onBtnSelected: () async {
        checkNetwork();
      },
    );
  }

  Future<void> checkNetwork() async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      await profileProvider!.buttonController!.reverse();
      profileProvider!.setUpdateUser(context, setStateNow);
    } else {
      Future.delayed(const Duration(seconds: 2)).then(
        (_) async {
          await profileProvider!.buttonController!.reverse();
          setState(
            () {
              isNetworkAvail = false;
            },
          );
        },
      );
    }
  }
}
