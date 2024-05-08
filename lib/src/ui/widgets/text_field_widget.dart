import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../providers/form_validators.dart';
import '../../utils/digits_formatter.dart';

class TextFieldWidget extends StatelessWidget with FormValidator {
  final TextEditingController controller;
  final String? label;
  final Widget? labelWidget;
  final String hint;
  final Widget? suffixWidget;
  final double? titleWidthFlex;
  final FormFieldValidator<String>? validator;
  final bool requiredField;

  const TextFieldWidget({
    super.key,
    required this.controller,
    this.requiredField = true,
    this.label,
    this.labelWidget,
    this.suffixWidget,
    this.titleWidthFlex = 0.45,
    this.validator,
    this.hint = "Ingresar dato",
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      if (label != null)
        SizedBox(
          width: titleWidthFlex != null
              ? MediaQuery.of(context).size.width * titleWidthFlex!
              : null,
          child: Text(
            label!,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(),
          ),
        ),
      if (labelWidget != null) labelWidget!,
      Expanded(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 8,
          ).copyWith(
            left: 15,
          ),
          child: SizedBox(
            // height: 45,
            child: TextFormField(
              controller: controller,
              textAlign: TextAlign.center,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: [
                DigitsAndDecimalsFormatter(),
              ],
              validator:
                  validator ?? (requiredField ? requiredValidator() : null),
              decoration: InputDecoration(
                hintText: hint,
                hintStyle: TextStyle(
                  color:
                      Theme.of(context).colorScheme.onSurface.withOpacity(0.5),
                  fontSize: 13,
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 0,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 0.75,
                  ),
                ),
                errorBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.error,
                    width: 0.75,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide(
                    color: Theme.of(context).colorScheme.primary,
                    width: 0.75,
                  ),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: Colors.grey,
                    width: 0.75,
                  ),
                ),
                suffixIcon: Padding(
                  padding: const EdgeInsets.only(
                    right: 10,
                  ),
                  child: suffixWidget,
                ),
                suffixIconConstraints: const BoxConstraints(
                  minWidth: 10,
                  minHeight: 10,
                ),
              ),
            ),
          ),
        ),
      ),
    ]);
  }
}
