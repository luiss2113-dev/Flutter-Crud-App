import 'package:flutter/material.dart';

class CustomInputField extends StatelessWidget {
  final String? hintText;
  final String? labelText;
  final String? helperText;
  final IconData? icon;
  final IconData? suffixIcon;
  final TextInputType? inputType;
  final TextEditingController? controller;
  final bool hiddenText;

  final String formProperty;
  final Map<String, dynamic> formValues;

  const CustomInputField(
      {Key? key,
      this.hintText,
      this.labelText,
      this.helperText,
      this.icon,
      this.suffixIcon,
      this.inputType,
      this.hiddenText = false,
      this.controller,
      required this.formProperty,
      required this.formValues})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: false,
      textCapitalization: TextCapitalization.none,
      keyboardType: inputType,
      obscureText: hiddenText,
      onChanged: (value) => formValues[formProperty] = value,
      validator: (value) {
        if (value == null) return "Este campo es requerido";
        return value.length < 3 ? "Mínimo de 3 letras" : null;
      },
      autovalidateMode: AutovalidateMode.onUserInteraction,
      decoration: InputDecoration(
        hintText: hintText,
        labelText: labelText,
        helperText: helperText,
        suffixIcon: suffixIcon == null ? null : Icon(suffixIcon),
        icon: icon == null ? null : Icon(icon),
      ),
    );
  }
}
