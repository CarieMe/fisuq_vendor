import 'package:flutter/material.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/profile/profile.dart';
import 'package:vendor/screen/profile/widget/common_design_feilds.dart';
import 'package:vendor/widget/validation.dart';

class GetSecondHeader extends StatelessWidget {
  Function setStateNow;
  GetSecondHeader({
    Key? key,
    required this.setStateNow,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 5.0),
      child: Card(
        elevation: 0,
        shape: const RoundedRectangleBorder(
            borderRadius:
                BorderRadius.all(Radius.circular(circularBorderRadius10))),
        child: Column(
          children: <Widget>[
            CommanDesingFields(
              icon: Icons.store_outlined,
              title: Local.storename,
              variable: profileProvider!.storename,
              empty: Local.notadded,
              addField: Local.storename,
              key: profileProvider!.storenameKey,
              keybordtype: TextInputType.text,
              validation: (val) => StringValidation.validateField(val, context),
              index: 4,
              update: setStateNow,
              fromMap: false,
            ),
            getDivider(),
            CommanDesingFields(
              icon: Icons.link_outlined,
              title: getTranslated(context, "StoreURL")!,
              variable: profileProvider!.storeurl,
              empty: getTranslated(context, "NoURL")!,
              addField: getTranslated(context, "addURL")!,
              key: profileProvider!.storeurlKey,
              keybordtype: TextInputType.text,
              validation: (val) => StringValidation.validateField(val, context),
              index: 5,
              update: setStateNow,
              fromMap: false,
            ),
            getDivider(),
            CommanDesingFields(
              icon: Icons.description_outlined,
              title: getTranslated(context, "Description")!,
              variable: profileProvider!.storeDesc,
              empty: getTranslated(context, "NotAdded")!,
              addField: getTranslated(context, "addDescription")!,
              key: profileProvider!.storeDescKey,
              keybordtype: TextInputType.text,
              validation: (val) => StringValidation.validateField(val, context),
              index: 6,
              update: setStateNow,
              fromMap: false,
            ),
          ],
        ),
      ),
    );
  }
}
