// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

import '../util/theme.dart';

// ignore: must_be_immutable
class CariTextfill extends StatelessWidget {
  CariTextfill({
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
      width: double.infinity,
      margin: const EdgeInsets.only(),
      decoration: const BoxDecoration(
          color: bg3Color, borderRadius: BorderRadius.all(Radius.circular(30))),
      child: TextFormField(
        readOnly: readOnly ?? false,
        keyboardType: keyboardType ?? TextInputType.text,
        validator: validate,
        style: primaryTextStyle2,
        obscureText: obscureText ?? false,
        decoration: InputDecoration(
          hintText: "Search any Produtcs    ",
          hintStyle: primaryTextStyle2.copyWith(color: Colors.black87),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: const BorderSide(color: Colors.black87, width: 2),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
        ),
        onChanged: onChanged,
        controller: controller,
      ),
    );
  }
}
