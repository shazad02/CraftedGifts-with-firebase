// ignore_for_file: avoid_print, use_build_context_synchronously, duplicate_ignore

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:kelompok6_a22/util/icons.dart';
import 'package:kelompok6_a22/screen/dashboard_screen/dashboard_screen.dart';
import 'package:kelompok6_a22/screen/loginscreen/login_sceen.dart';
import 'package:kelompok6_a22/widget/button_custom.dart';
import 'package:kelompok6_a22/widget/circel_avatar.dart';
import 'package:kelompok6_a22/widget/custom_textfiled.dart';

class RegisScreen extends StatefulWidget {
  const RegisScreen({super.key});

  @override
  State<RegisScreen> createState() => _RegisScreenState();
}

class _RegisScreenState extends State<RegisScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final GlobalKey<ScaffoldMessengerState> _scaffoldKey =
      GlobalKey<ScaffoldMessengerState>();

  late String email;
  late String name;
  late String phone;
  late String password;
  bool? isLoading = false;

  void validation() async {
    final FormState form = _formKey.currentState!;
    if (form.validate()) {
      setState(() {
        isLoading = true;
      });

      try {
        UserCredential userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: email,
          password: password,
        );
        FirebaseFirestore firestore = FirebaseFirestore.instance;
        await firestore.collection('user').doc(userCredential.user!.uid).set({
          "name": name,
          "email": email,
          "phone": phone,
          "userid": userCredential.user!.uid,
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const DashboardScreen(),
          ),
        );
      } on FirebaseAuthException catch (e) {
        setState(() {
          isLoading = false;
        });
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
      } on PlatformException catch (e) {
        setState(() {
          isLoading = false;
        });
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
    } else {
      print("No");
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
                  Text("Sign up",
                      style: primaryTextStyle3.copyWith(fontSize: 32)),
                  const SizedBox(height: 5),
                  Text("Create your new account", style: primaryTextStyle2),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name",
                          style: primaryTextStyle2.copyWith(fontSize: 16)),
                      CustomTextFil(
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nama is required';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            name = value;
                          });
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
                      Text("Phone",
                          style: primaryTextStyle2.copyWith(fontSize: 16)),
                      CustomTextFil(
                        keyboardType: TextInputType.number,
                        validate: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Nomer is required';
                          } else if (value.length < 11) {
                            return 'Nomer Terlalu Pendek';
                          }
                          return null;
                        },
                        onChanged: (value) {
                          setState(() {
                            phone = value;
                          });
                        },
                      ),
                      SizedBox(
                          height: MediaQuery.of(context).size.height * 0.02),
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
                    textButton: "Sign up",
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
                        child: Text("Or sign up with",
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
                      CircelCustom(icon: Iconss.google),
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
                      Text("Jika Punya Akun? ", style: primaryTextStyle2),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (c) => const LoginScreen(),
                            ),
                          );
                        },
                        child: Text(" Sign in",
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
