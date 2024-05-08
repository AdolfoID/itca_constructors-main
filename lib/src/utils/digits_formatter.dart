import 'package:flutter/services.dart';

class DigitsAndDecimalsFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue;
    }
    // Remove any non-digit or non-decimal characters from the new value
    String filteredValue = newValue.text.replaceAll(RegExp(r'[^0-9.]'), '');

    // Split the filtered value into integer and decimal parts
    List<String> parts = filteredValue.split('.');

    // Ensure that there is at most one decimal point
    if (parts.length > 2) {
      return oldValue;
    }

    // Ensure that the integer part is not empty
    if (parts.isNotEmpty && parts[0].isEmpty) {
      return oldValue;
    }

    // Ensure that the decimal part has at most two digits
    if (parts.length == 2 && parts[1].length > 2) {
      return oldValue;
    }

    // Reconstruct the formatted value with the filtered parts
    String formattedValue = parts.join('.');

    // Clear the field if the value becomes empty
    if (formattedValue.isEmpty) {
      return TextEditingValue.empty;
    }

    return newValue.copyWith(
      text: formattedValue,
      selection: TextSelection.collapsed(offset: formattedValue.length),
    );
  }
}
