import 'package:flutter/material.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/profile/profile.dart';
import 'package:vendor/screen/profile/widget/common_design_feilds.dart';
import 'package:vendor/widget/validation.dart';

class GetFirstHeader extends StatelessWidget {
  Function setStateNow;
  GetFirstHeader({
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
          borderRadius: BorderRadius.all(
            Radius.circular(
              circularBorderRadius10,
            ),
          ),
        ),
        child: Column(
          children: <Widget>[
            CommanDesingFields(
              icon: Icons.person_outlined,
              title: Local.namelbl,
              variable: profileProvider!.name,
              empty: Local.notadded,
              addField: Local.addnamelabel,
              key: profileProvider!.sellernameKey,
              keybordtype: TextInputType.text,
              validation: (val) =>
                  StringValidation.validateUserName(val, context),
              index: 0,
              update: setStateNow,
              fromMap: false,
            ),
            getDivider(),
            CommanDesingFields(
              icon: Icons.phone_in_talk_outlined,
              title: Local.mobilenumberhint,
              variable: profileProvider!.mobile,
              empty: Local.notadded,
              addField: Local.addmobilenumber,
              key: profileProvider!.mobilenumberKey,
              keybordtype: TextInputType.number,
              validation: (val) => StringValidation.validateMob(val, context),
              index: 1,
              update: setStateNow,
              fromMap: false,
            ),
            getDivider(),
            CommanDesingFields(
              icon: Icons.email_outlined,
              title: Local.email,
              variable: profileProvider!.email,
              empty: Local.notadded,
              addField: Local.addemail,
              key: profileProvider!.emailKey,
              keybordtype: TextInputType.text,
              validation: (val) => StringValidation.validateField(val, context),
              index: 2,
              update: setStateNow,
              fromMap: false,
            ),
            getDivider(),
            CommanDesingFields(
              icon: Icons.location_on_outlined,
              title: Local.address,
              variable: profileProvider!.address,
              empty: Local.notadded,
              addField: Local.addaddress,
              key: profileProvider!.addressKey,
              keybordtype: TextInputType.text,
              validation: (val) => StringValidation.validateField(val, context),
              index: 3,
              update: setStateNow,
              fromMap: false,
            ),
          ],
        ),
      ),
    );
  }
}
