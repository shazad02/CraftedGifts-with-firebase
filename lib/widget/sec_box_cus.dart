import 'package:flutter/material.dart';
import 'package:kelompok6_a22/util/theme.dart';

class SecBox extends StatelessWidget {
  final String image;
  final String text;
  final String harga;
  final String category;

  const SecBox({
    super.key,
    required this.image,
    required this.text,
    required this.harga,
    required this.category,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 35 / 100,
      width: MediaQuery.of(context).size.width * 43 / 100,
      decoration: BoxDecoration(
        color: bg2Color,
        borderRadius: const BorderRadius.all(
          Radius.circular(20),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.all(MediaQuery.of(context).size.height * 1.2 / 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ClipRRect(
              borderRadius: const BorderRadius.all(
                Radius.circular(15),
              ),
              child: Image.asset(
                height: MediaQuery.of(context).size.height * 20 / 100,
                width: MediaQuery.of(context).size.width * 42 / 100,
                image,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(
              height: 5,
            ),
            Text(
              text,
              style: primaryTextStyle3.copyWith(
                  fontSize: 17, color: bg3Color, fontWeight: extrabold),
            ),
            Text(
              category,
              style: primaryTextStyle3.copyWith(
                  fontSize: 17, color: bg3Color, fontWeight: extrabold),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1 / 100,
            ),
            Text(
              harga,
              style: primaryTextStyle2.copyWith(fontSize: 15, color: bg3Color),
            )
          ],
        ),
      ),
    );
  }
}
