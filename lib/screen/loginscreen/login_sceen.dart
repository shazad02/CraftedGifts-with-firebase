// ignore_for_file: avoid_print, use_build_context_synchronously

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:kelompok6_a22/util/icons.dart';
import 'package:kelompok6_a22/screen/dashboard_screen/dashboard_screen.dart';
import 'package:kelompok6_a22/screen/regisscreen/regis_screen.dart';
import 'package:kelompok6_a22/widget/button_custom.dart';
import 'package:kelompok6_a22/widget/circel_avatar.dart';
import 'package:kelompok6_a22/widget/custom_textfiled.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late String email;
  late String password;
  bool isLoading = false;

  void validation() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      try {
        setState(() {
          isLoading = true;
        });

        QuerySnapshot userSnapshot = await FirebaseFirestore.instance
            .collection('user')
            .where('email', isEqualTo: email)
            .get();

        if (userSnapshot.size > 0) {
          // ignore: unused_local_variable
          UserCredential userCredential =
              await FirebaseAuth.instance.signInWithEmailAndPassword(
            email: email,
            password: password,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const DashboardScreen(),
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Email Tidak Terdaftar'),
              content: const Text('Email yang Anda masukkan Sudah DI Banned.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } on FirebaseAuthException catch (e) {
        if (e.code == 'wrong-password') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Password Salah'),
              content: const Text('Password yang Anda masukkan salah.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else if (e.code == 'user-not-found') {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('User Tidak Ditemukan'),
              content: const Text('Tidak ada user dengan email tersebut.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        } else {
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: const Text('Error'),
              content: Text(e.message ?? 'An error occurred.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text('OK'),
                ),
              ],
            ),
          );
        }
      } finally {
        setState(() {
          isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Text("Sign In",
                      style: primaryTextStyle3.copyWith(fontSize: 32)),
                  const SizedBox(height: 5),
                  Text("Sign in to your account", style: primaryTextStyle2),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Email",
                          style: primaryTextStyle2.copyWith(fontSize: 16)),
                      CustomTextFil(
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'This field is required';
                          }
                          if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value)) {
                            return "Please enter a valid email address";
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            email = value;
                          });
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text("Password",
                          style: primaryTextStyle2.copyWith(fontSize: 16)),
                      CustomTextFil(
                        onChanged: (value) {
                          setState(() {
                            password = value;
                          });
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.04),
                  ButtonCus(
                    textButton: "Sign In",
                    onPressed: validation,
                    buttomcolor: bg2Color,
                    textcolor: bg1Color,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Text("Or sign in with",
                            style: primaryTextStyle2.copyWith(fontSize: 15)),
                      ),
                      const Expanded(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 15),
                          child: Divider(
                            color: Colors.black,
                            thickness: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.07),
                  const Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircelCustom(icon: Iconss.fb),
                      SizedBox(width: 10),
                      CircelCustom(icon: Iconss.fb),
                      SizedBox(width: 10),
                      CircelCustom(icon: Iconss.line),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Jika Belum Punya Akun? ", style: primaryTextStyle2),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => const RegisScreen(),
                            ),
                          );
                        },
                        child: Text(" Sign Up",
                            style:
                                primaryTextStyle2.copyWith(color: Colors.blue)),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
