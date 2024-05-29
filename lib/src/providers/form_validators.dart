import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

final emailRegExp = RegExp(
    r"^((([a-z]|\d|[!#\$%&'*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$");

typedef Form2FieldValidator<T> = String? Function(
    String? value, String? value2);

mixin FormValidator {
  String? emailValidator(value) {
    if (value.toString().isEmpty) {
      return "Campo requerido";
    } else if (!emailRegExp.hasMatch(value)) {
      return "Correo inválido";
    }
    return null;
  }

  Form2FieldValidator get matchValidator => (value, value2) {
        if (value2 != value) {
          return "Los campos no coinciden";
        }
        return null;
      };

  FormFieldValidator requiredValidator() => (value) {
        return (value?.toString().trim().isEmpty == true)
            ? "Campo requerido"
            : null;
      };

  FormFieldValidator requiredValidatorWithMinimun(int minimun,
          [int max = 999999999999]) =>
      (value) {
        final length = value?.toString().trim().length ?? 0;
        return length < minimun || length > max ? "Campo requerido" : null;
      };

  FormFieldValidator doubleValidator({bool required = true}) => (value) {
        if (value.toString().isEmpty) {
          return required ? "Campo requerido" : null;
        } else if (double.tryParse(value) == null) {
          return "Número inválido";
        }
        return null;
      };

  FormFieldValidator digitValidator({int length = 6}) => (value) {
        if (value.toString().isEmpty) {
          return "Campo requerido";
        } else if (length != value.toString().length) {
          return "Longitud inválida";
        } else if (RegExp(r'[\D]+').hasMatch(value)) {
          return "Número inválido";
        }
        return null;
      };

  String? phoneValidator(value) {
    if (value.toString().isEmpty) {
      return "Campo requerido";
    } else if (value.toString().length < 7) {
      return "Longitud inválida";
    }
    return null;
  }

  FormFieldValidator getDateValidator(DateFormat format,
          {int? minYear, int? maxYear}) =>
      (value) {
        try {
          final maxYear_ = maxYear ?? DateTime.now().year;
          final minYear_ = minYear ?? maxYear_ - 100;
          final _ = format.parseStrict((value as String).replaceAll(" ", ""));
          if (_.year > maxYear_ || _.year < minYear_) {
            return "Fecha inválida";
          }
          return null;
        } catch (e) {
          return "Fecha inválida";
        }
      };
}
DateFormat getDateFormat(BuildContext context) {
  var locale = Localizations.localeOf(context);
  var format = DateFormat.yMd(locale.toString());
  return format;
}
