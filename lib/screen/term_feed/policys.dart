import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:vendor/helper/api_base_helper.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/exports.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/widget/appbar.dart';
import 'package:vendor/widget/network_availablity.dart';
import 'package:vendor/widget/no_network.dart';
import 'package:vendor/widget/validation.dart';

class Policy extends StatefulWidget {
  String? title;

  Policy({
    this.title,
  });
  @override
  _PolicyState createState() => _PolicyState();
}

class _PolicyState extends State<Policy> {
//==============================================================================
//============================= Variables Declaration ==========================

  Animation? buttonSqueezeanimation;
  AnimationController? buttonController;
  String? contactUs;
  String? termCondition;
  String? privacyPolicy;
  String? returnPolicy;
  String? shippingPolicy;
  ApiBaseHelper apiBaseHelper = ApiBaseHelper();

//==============================================================================
//============================= initState Method ===============================

  @override
  void initState() {
    super.initState();
    getSystemPolicy();
  }

  @override
  void dispose() {
    if (buttonController != null) {
      buttonController!.dispose();
    }
    super.dispose();
  }

  Future<void> getSystemPolicy() async {
    isNetworkAvail = await isNetworkAvailable();
    if (isNetworkAvail) {
      String type = '';
      if (widget.title == Local.privacypolicy) {
        type = "privacy_policy";
      } else if (widget.title == Local.termconditions) {
        type = "terms_conditions";
      } else if (widget.title == Local.contactus) {
        type = "contact_us";
      } else if (widget.title == Local.shippingpolicy) {
        type = "shipping_policy";
      } else if (widget.title == Local.returnpolicy) {
        type = "return_policy";
      } else {
        Future.delayed(const Duration(seconds: 2)).then(
          (_) async {
            setState(() {
              isNetworkAvail = false;
            });
            await buttonController!.reverse();
          },
        );
      }

      await Future.delayed(Duration.zero);
      await context.read<SystemProvider>().getSystemPolicies(type);
    }
  }
//==============================================================================
//============================= Build Method ===================================

  @override
  Widget build(BuildContext context) {
    height = MediaQuery.of(context).size.height;
    width = MediaQuery.of(context).size.width;
    return Scaffold(
      // appBar: getAppBar(
      //   widget.title!,
      //   context,
      // ),
      body: isNetworkAvail
          ? Consumer<SystemProvider>(
              builder: (context, value, child) {
                if (value.getCurrentStatus ==
                    SystemProviderPolicyStatus.isSuccsess) {
                  if (value.policy.isNotEmpty) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          GradientAppBar(
                            widget.title!,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                top: 8.0, left: 8.0, right: 8.0),
                            child: HtmlWidget(
                              value.policy,
                              onErrorBuilder: (context, element, error) =>
                                  Text('$element error: $error'),
                              onLoadingBuilder:
                                  (context, element, loadingProgress) =>
                                      const CircularProgressIndicator(),

                              onTapUrl: (url) {
                                launchUrl(Uri.parse(url));
                                return true;
                              },

                              renderMode: RenderMode.column,

                              // set the default styling for text
                              textStyle:
                                  const TextStyle(fontSize: textFontSize14),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    Center(
                      child: Text(Local.nodatafound),
                    );
                  }
                } else if (value.getCurrentStatus ==
                    SystemProviderPolicyStatus.isFailure) {
                  return Center(
                    child: Text('Something went wrong:- ${value.errorMessage}'),
                  );
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            )
          : noInternet(
              context,
              setStateNoInternate,
              buttonSqueezeanimation,
              buttonController,
            ),
    );
  }

  setStateNoInternate() async {
    _playAnimation();
    Future.delayed(const Duration(seconds: 2)).then(
      (_) async {
        isNetworkAvail = await isNetworkAvailable();
        if (isNetworkAvail) {
          Navigator.pushReplacement(
            context,
            CupertinoPageRoute(builder: (BuildContext context) => super.widget),
          );
        } else {
          await buttonController!.reverse();
          setState(
            () {},
          );
        }
      },
    );
  }

  Future<void> _playAnimation() async {
    try {
      await buttonController!.forward();
    } on TickerCanceled {}
  }
}
