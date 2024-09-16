// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

import '../util/theme.dart';

// ignore: must_be_immutable
class SecondTextfill extends StatelessWidget {
  SecondTextfill({
    this.readOnly,
    // required this.hintText,
    this.labelText,
    this.obscureText,
    this.validate,
    this.keyboardType,
    Key? key,
    this.onChanged,
    this.controller,
  }) : super(key: key);

  // String hintText;
  String? labelText;
  bool? readOnly;
  bool? obscureText;
  TextInputType? keyboardType;
  FormFieldValidator<String>? validate;
  void Function(String)? onChanged;
  TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 5.5 / 100,
      width: MediaQuery.of(context).size.width * 43 / 100,
      margin: const EdgeInsets.only(),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10))),
      child: TextFormField(
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validate,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          // hintText: hintText,
          hintStyle: primaryTextStyle2.copyWith(color: bg2Color),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: bg6color, width: 3),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        onChanged: onChanged,
        controller: controller,
      ),
    );
  }
}
