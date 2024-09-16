import 'package:flutter/material.dart';
import 'package:kelompok6_a22/util/theme.dart';

class BoxCutomCategory extends StatelessWidget {
  final String image;
  final String text;

  const BoxCutomCategory({
    super.key,
    required this.image,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 42 / 100,
      height: MediaQuery.of(context).size.height * 17 / 100,
      decoration: BoxDecoration(
        color: bg2Color,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        border: Border.all(
          color: bg1Color,
          width: 3,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 1 / 100),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              text,
              style: primaryTextStyle3.copyWith(
                  fontWeight: extrabold, fontSize: 18, color: bg1Color),
            )
          ],
        ),
      ),
    );
  }
}
