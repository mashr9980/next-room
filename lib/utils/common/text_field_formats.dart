import 'package:flutter/services.dart';

class CardNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    final text = newValue.text.replaceAll(RegExp(r'\D'), '');
    final buffer = StringBuffer();
    for (int i = 0; i < text.length; i++) {
      buffer.write(text[i]);
      if ((i == 3 || i == 7 || i == 11) && i != text.length - 1) {
        buffer.write(' ');
      }
    }
    return TextEditingValue(
      text: buffer.toString(),
      selection: TextSelection.collapsed(offset: buffer.length),
    );
  }
}

class UsPhoneNumberFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue,
      TextEditingValue newValue,
      ) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.length > 10) {
      digitsOnly = digitsOnly.substring(0, 10);
    }

    String formatted = '';
    if (digitsOnly.isNotEmpty) {
      if (digitsOnly.length <= 3) {
        formatted = '(${digitsOnly.substring(0, digitsOnly.length)}';
      } else if (digitsOnly.length <= 6) {
        formatted = '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3)}';
      } else {
        formatted =
        '(${digitsOnly.substring(0, 3)}) ${digitsOnly.substring(3, 6)}-${digitsOnly.substring(6)}';
      }
    }

    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}


class ExpiryDateFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'\D'), '');

    if (digitsOnly.isEmpty) return newValue;

    String result = '';
    int offset = 0;

    // Extract month
    String month = '';
    if (digitsOnly.length >= 1) {
      int firstDigit = int.tryParse(digitsOnly[0]) ?? 0;

      if (digitsOnly.length == 1) {
        if (firstDigit > 1) {
          month = '0$firstDigit';
        } else {
          return TextEditingValue(
            text: digitsOnly,
            selection: TextSelection.collapsed(offset: digitsOnly.length),
          );
        }
      } else if (digitsOnly.length >= 2) {
        month = digitsOnly.substring(0, 2);
        int monthNum = int.tryParse(month) ?? 0;
        if (monthNum == 0 || monthNum > 12) {
          // Invalid month
          return oldValue;
        }
      }
    }

    // Extract year
    String year = '';
    if (digitsOnly.length > 2) {
      year = digitsOnly.substring(2);
      if (year.length > 4) {
        year = year.substring(0, 4);
      }
    }

    // Build final result
    result = month;
    if (year.isNotEmpty) {
      result += '/$year';
    }

    offset = result.length;

    return TextEditingValue(
      text: result,
      selection: TextSelection.collapsed(offset: offset),
    );
  }
}