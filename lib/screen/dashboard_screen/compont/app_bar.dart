import 'package:flutter/material.dart';
import 'package:kelompok6_a22/util/icons.dart';

class AppbarDash extends StatelessWidget {
  const AppbarDash({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Flexible(
          flex: 1,
          child: GestureDetector(
              onTap: () {
                Scaffold.of(context).openDrawer();
              },
              child: Image.asset(Iconss.drawer)),
        ),
      ],
    );
  }
}
