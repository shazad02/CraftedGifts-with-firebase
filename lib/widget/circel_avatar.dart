// ignore_for_file: use_super_parameters

import 'package:flutter/material.dart';

class CircelCustom extends StatelessWidget {
  final String icon;
  const CircelCustom({
    Key? key,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      backgroundColor: Colors.transparent,
      radius: 20,
      child: Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(color: Colors.grey, width: 1),
        ),
        child: ClipOval(
          child: Image.asset(
            icon,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
