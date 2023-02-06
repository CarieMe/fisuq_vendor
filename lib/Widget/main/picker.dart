import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Picker {
  static pickDate({
    required BuildContext context,
    required DateTime initialDateTime,
    required void Function(DateTime) onDateTimeChanged,
  }) async {
    await showModalBottomSheet(
      backgroundColor: Theme.of(context).backgroundColor,
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      builder: (BuildContext builder) {
        return CupertinoTheme(
          data: CupertinoThemeData(
            textTheme: CupertinoTextThemeData(
              dateTimePickerTextStyle: Theme.of(context).textTheme.bodySmall,
            ),
          ),
          child: SizedBox(
            height: MediaQuery.of(context).copyWith().size.height / 3,
            child: CupertinoDatePicker(
              mode: CupertinoDatePickerMode.date,
              initialDateTime: initialDateTime,
              onDateTimeChanged: onDateTimeChanged,
              use24hFormat: false,
              minuteInterval: 1,
            ),
          ),
        );
      },
    );
  }
}
