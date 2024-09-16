import 'package:flutter/material.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:kelompok6_a22/util/images.dart';
import 'package:kelompok6_a22/screen/loginscreen/login_sceen.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  Widget _welcomeup() {
    return Column(
      children: [
        Text(
          "Selamat Datang Di Kado",
          style: primaryTextStyle3.copyWith(
            fontSize: 20,
          ),
        ),
        Text(
          "Estetik Lhokseumawe",
          style: primaryTextStyle3.copyWith(
            fontSize: 20,
          ),
        ),
      ],
    );
  }

  Widget _welcomebottom() {
    return Column(
      children: [
        Text(
          "Berikan Hadiah Yang",
          style: primaryTextStyle2.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
        Text(
          "Terbaik Untuk Kebahagian",
          style: primaryTextStyle2.copyWith(
            fontSize: 18,
            fontWeight: medium,
          ),
        ),
      ],
    );
  }

  Widget _buttonStart() {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: defaultmargin),
      width: double.infinity,
      height: 50,
      child: ElevatedButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (c) => const LoginScreen(),
            ),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: bg2Color,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
        ),
        child: Text(
          'Ayo Mulai',
          style: primaryTextStyle2.copyWith(color: bg1Color, fontSize: 15),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
            child: Image.asset(Images.welcome),
          ),
          _welcomeup(),
          const SizedBox(
            height: 10,
          ),
          _welcomebottom(),
          const SizedBox(
            height: 20,
          ),
          _buttonStart(),
        ],
      ),
    );
  }
}
