// ignore_for_file: unrelated_type_equality_checks

import 'package:flutter/material.dart';
import 'package:kelompok6_a22/util/theme.dart';

class ButtonCircle extends StatelessWidget {
  final Function onPressed;
  final String textButton;
  final Color buttomcolor;
  final Color textcolor;

  const ButtonCircle(
      {super.key,
      required this.textButton,
      required this.onPressed,
      required this.buttomcolor,
      required this.textcolor});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 4.5 / 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          backgroundColor: bg2Color,
        ),
        onPressed: onPressed as void Function(),
        child: Text(
          textButton,
          style: primaryTextStyle2.copyWith(
            fontSize: 14,
            color: bg1Color,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    );
  }
}
