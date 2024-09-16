import 'package:flutter/material.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:kelompok6_a22/util/icons.dart';

class ButtonCart extends StatelessWidget {
  final Function onPressed;
  final String textButton;
  final Color buttomcolor;
  final Color textcolor;

  const ButtonCart({
    super.key,
    required this.textButton,
    required this.onPressed,
    required this.buttomcolor,
    required this.textcolor,
    // Updated constructor
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: MediaQuery.of(context).size.height * 4.5 / 100,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
          backgroundColor: buttomcolor,
        ),
        onPressed: onPressed as void Function(),
        child: Row(
          // Use Row to place icon and text horizontally
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Iconss.cartshoping),
            const SizedBox(
                width: 8), // SizedBox for spacing between icon and text
            Text(
              textButton,
              style: primaryTextStyle3.copyWith(
                fontSize: 16,
                color: textcolor,
                fontWeight: FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
