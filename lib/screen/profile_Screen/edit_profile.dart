// ignore_for_file: use_build_context_synchronously

import 'package:firebase_auth/firebase_auth.dart';
import 'package:kelompok6_a22/provider/product_provider.dart';
import 'package:flutter/material.dart';
import 'package:kelompok6_a22/util/icons.dart';
import 'package:kelompok6_a22/widget/custom_textfiled2.dart';
import 'package:provider/provider.dart';
import '../../models/ongkir_model.dart';
import '../../util/theme.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  State<EditProfile> createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  late ProductProvider productProvider;
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController passwordController; // Controller for password
  late List<OngkirModel> dropdownItems = [];
  String selectedDropdownValue = ''; // Initial dropdown value

  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    nameController = TextEditingController();
    emailController = TextEditingController();
    phoneController = TextEditingController();
    passwordController =
        TextEditingController(); // Initialize password controller

    // Set the initial values for the text fields
    nameController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.name
        : '';
    emailController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.email
        : '';
    phoneController.text = productProvider.userModelList.isNotEmpty
        ? productProvider.userModelList.first.phone
        : '';
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    passwordController.dispose(); // Dispose password controller
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: bg1Color,
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 30 / 100,
                  width: double.infinity,
                  decoration: const BoxDecoration(
                    color: bg2Color,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(360),
                    ),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(
                      MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: Image.asset(
                                Iconss.arrowback,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: MediaQuery.of(context).size.height * 4 / 100,
                        ),
                        Center(
                          child: Text(
                            "Profile",
                            style: primaryTextStyle3.copyWith(
                                fontSize: 22,
                                color: bg1Color,
                                fontWeight: extrabold),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                ),
                Text(
                  "${productProvider.userModelList.isNotEmpty ? productProvider.userModelList.first.name : ''} ",
                  style: primaryTextStyle3.copyWith(fontSize: 22),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 5 / 100,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.height * 5 / 100),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Email"),
                      CustomTextFil2(
                        hintText: 'Email User',
                        controller: emailController,
                      ),
                      const Text("Name"),
                      CustomTextFil2(
                        controller: nameController,
                        hintText: 'Name',
                      ),
                      const Text("Phone Number"),
                      CustomTextFil2(
                        hintText: 'Phone Number',
                        controller: phoneController,
                      ),
                      const Text("Password"), // New password field
                      CustomTextFil2(
                        hintText: 'New Password',
                        controller: passwordController,
                        obscureText: false, // Hide password input
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 4 / 100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 50 / 100,
                  height: MediaQuery.of(context).size.height * 7 / 100,
                  child: ElevatedButton(
                    onPressed: () {
                      _updateUserData();
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bg2Color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Update Profile',
                      style: primaryTextStyle3.copyWith(
                          color: bg1Color, fontSize: 15),
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 2 / 100,
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 50 / 100,
                  height: MediaQuery.of(context).size.height * 7 / 100,
                  child: ElevatedButton(
                    onPressed: () {
                      _updatePassword();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: bg2Color,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      'Update Password',
                      style: primaryTextStyle3.copyWith(
                          color: bg1Color, fontSize: 15),
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              top: MediaQuery.of(context).size.height * .3 -
                  (MediaQuery.of(context).size.width * .15),
              left: MediaQuery.of(context).size.width * .4,
              child: CircleAvatar(
                backgroundColor: Colors.transparent,
                radius: 50,
                child: ClipOval(
                  child: Image.asset(
                    Iconss.abuabu,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _updateUserData() {
    final String newname = nameController.text;
    final String newEmail = emailController.text;
    final String newphone = phoneController.text;

    // Update the user data using the ProductProvider
    productProvider.updateUserData(
      newName: newname,
      newEmail: newEmail,
      newPhone: newphone,
    );

    // Notify listeners of the change
    // ignore: invalid_use_of_protected_member, invalid_use_of_visible_for_testing_member
    productProvider.notifyListeners();
  }

  void _updatePassword() async {
    final String newPassword = passwordController.text;

    if (newPassword.isNotEmpty) {
      try {
        User? user = FirebaseAuth.instance.currentUser;
        if (user != null) {
          await user.updatePassword(newPassword);
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Password updated successfully')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to update password: $e')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password cannot be empty')),
      );
    }
  }
}
