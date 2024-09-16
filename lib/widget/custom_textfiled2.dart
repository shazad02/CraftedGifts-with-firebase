// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

import '../util/theme.dart';

// ignore: must_be_immutable
class CustomTextFil2 extends StatelessWidget {
  CustomTextFil2({
    this.readOnly,
    required this.hintText,
    this.labelText,
    this.obscureText,
    this.validate,
    this.keyboardType,
    Key? key,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  String? labelText;
  String hintText;
  bool? readOnly;
  bool? obscureText;
  TextInputType? keyboardType;
  FormFieldValidator<String>? validate;
  void Function(String)? onChanged;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(),
      decoration: const BoxDecoration(
          color: Colors.transparent,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validate,
        obscureText: obscureText ?? false,
        style: primaryTextStyle2,
        decoration: InputDecoration(
            hintText: hintText,
            hintStyle: const TextStyle(color: Colors.grey),
            border: const UnderlineInputBorder()),
        onChanged: onChanged,
        controller: controller,
      ),
    );
  }
}
