import 'package:flutter/material.dart';
import 'package:vendor/helper/constant.dart';
import 'package:vendor/helper/theming.dart';
import 'package:vendor/screen/profile/profile.dart';
import 'package:vendor/screen/profile/widget/common_design_feilds.dart';
import 'package:vendor/widget/validation.dart';

class GetThirdHeader extends StatelessWidget {
  Function setStateNow;
  GetThirdHeader({
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
            Radius.circular(circularBorderRadius10),
          ),
        ),
        child: Column(
          children: <Widget>[
            CommanDesingFields(
              icon: Icons.format_list_numbered_outlined,
              title: Local.accountnumber,
              variable: profileProvider!.accNo,
              empty: Local.notadded,
              addField: Local.accountnumber,
              key: profileProvider!.accnumberKey,
              keybordtype: TextInputType.text,
              validation: (val) => StringValidation.validateField(val, context),
              index: 7,
              update: setStateNow,
              fromMap: false,
            ),
            getDivider(),
            CommanDesingFields(
              icon: Icons.import_contacts_outlined,
              title: Local.accountname,
              variable: profileProvider!.accname,
              empty: Local.notadded,
              addField: Local.addaccountname,
              key: profileProvider!.accnameKey,
              keybordtype: TextInputType.text,
              validation: (val) => StringValidation.validateField(val, context),
              index: 8,
              update: setStateNow,
              fromMap: false,
            ),
            getDivider(),
            CommanDesingFields(
              icon: Icons.request_quote_outlined,
              title: Local.bankcode,
              variable: profileProvider!.bankcode,
              empty: Local.notadded,
              addField: Local.addbankcode,
              key: profileProvider!.bankcodeKey,
              keybordtype: TextInputType.text,
              validation: (val) => StringValidation.validateField(val, context),
              index: 9,
              update: setStateNow,
              fromMap: false,
            ),
            getDivider(),
            CommanDesingFields(
              icon: Icons.account_balance_outlined,
              title: Local.bankname,
              variable: profileProvider!.bankname,
              empty: Local.notadded,
              addField: Local.addbankname,
              key: profileProvider!.banknameKey,
              keybordtype: TextInputType.text,
              validation: (val) => StringValidation.validateField(val, context),
              index: 10,
              update: setStateNow,
              fromMap: false,
            ),
          ],
        ),
      ),
    );
  }
}
