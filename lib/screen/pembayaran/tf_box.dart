import 'package:flutter/material.dart';
import 'package:kelompok6_a22/util/theme.dart';

class BoxTranfer extends StatelessWidget {
  final String iamge;
  final String nama;
  final Function onPressed;
  const BoxTranfer({
    super.key,
    required this.iamge,
    required this.nama,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: onPressed as void Function(),
        child: Container(
          height: MediaQuery.of(context).size.height * 8 / 100,
          width: double.infinity,
          decoration: const BoxDecoration(
            color: bg2Color,
            borderRadius: BorderRadius.all(
              Radius.circular(20),
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(5),
                  ),
                  child: Image.asset(
                    iamge,
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 5 / 100,
                ),
                Text(
                  nama,
                  style: primaryTextStyle2.copyWith(fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
