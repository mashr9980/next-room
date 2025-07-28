import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../generated/assets.dart';

class CustomCalendarHeader extends StatelessWidget {
  final Rx<DateTime> focusedDay;
  final Function onPreviousMonth;
  final Function onNextMonth;

  const CustomCalendarHeader({
    super.key,
    required this.focusedDay,
    required this.onPreviousMonth,
    required this.onNextMonth,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Padding(
        padding: const EdgeInsets.only(
          top: 15.0,
          right: 10,
          left: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '${focusedDay.value.monthName} ${focusedDay.value.day},${focusedDay.value.year}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  String get monthName {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[this.month - 1];
  }
}
