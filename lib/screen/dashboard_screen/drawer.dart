import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelompok6_a22/provider/product_provider.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:kelompok6_a22/util/icons.dart';

import 'package:kelompok6_a22/screen/Allitems_screen/allproduct.dart';
import 'package:kelompok6_a22/screen/dashboard_screen/dashboard_screen.dart';
import 'package:kelompok6_a22/screen/Pengiriman_screen/List_belum_bayar.dart';
import 'package:kelompok6_a22/screen/Pengiriman_screen/List_transaksi_all.dart';
import 'package:kelompok6_a22/screen/profile_Screen/edit_profile.dart';
import 'package:kelompok6_a22/screen/splashscreen/splash_screen.dart';
import 'package:kelompok6_a22/screen/Bag_screen/bag.dart';
import 'package:kelompok6_a22/screen/Alamat_Screen/useralamat.dart';
import 'package:provider/provider.dart';

class CustomDrawer extends StatefulWidget {
  const CustomDrawer({super.key});

  @override
  State<CustomDrawer> createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  Future<void> _logout() async {
    await _auth.signOut();
    // ignore: deprecated_member_use, use_build_context_synchronously
    Navigator.pushAndRemoveUntil(
      // ignore: use_build_context_synchronously
      context,
      MaterialPageRoute(
        builder: (context) => const SplashScreen(),
      ),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    late ProductProvider productProvider;
    productProvider = Provider.of<ProductProvider>(context, listen: false);

    // Get user data once when the widget is built
    productProvider.getUserData();
    return Drawer(
      child: ListView(
        children: [
          ListTile(
            title: Container(
              height: MediaQuery.of(context).size.height * 12 / 100,
              decoration: BoxDecoration(
                color: bg3Color,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Consumer<ProductProvider>(
                      builder: (context, productProvider, child) {
                        if (productProvider.userModelList.isEmpty) {
                          return const CircularProgressIndicator();
                        } else {
                          final userModel = productProvider.userModelList.first;
                          return Text(
                            userModel.name,
                            style: primaryTextStyle2.copyWith(
                              color: Colors.black,
                              fontSize: 24,
                            ),
                          );
                        }
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const EditProfile(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Text(
                            "Edit Profile",
                            style: primaryTextStyle2.copyWith(fontSize: 18),
                          ),
                          Image.asset(Iconss.back)
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            title: Container(
              decoration: BoxDecoration(
                color: bg3Color,
                borderRadius: const BorderRadius.all(
                  Radius.circular(15),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 3,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(17),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const DashboardScreen(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset(Iconss.categorize),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Home',
                            style: primaryTextStyle2.copyWith(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const AllProduct(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset(Iconss.gift),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'All Product',
                            style: primaryTextStyle2.copyWith(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const Bag(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset(Iconss.shopingcart),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Cart',
                            style: primaryTextStyle2.copyWith(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (c) => const UserAlamat(),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.house,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Addres',
                            style: primaryTextStyle2.copyWith(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Licek(
                              isEqualTo: 'Belum Bayar',
                              namescreen: 'Belum Bayar',
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset(Iconss.shopingcart),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Belum Bayar',
                            style: primaryTextStyle2.copyWith(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListCek(
                              isEqualTo: 'Tunggu',
                              namescreen: 'Tunggu',
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.hourglass_empty,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Menunggu',
                            style: primaryTextStyle2.copyWith(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListCek(
                              isEqualTo: 'Dalam Perjalanan',
                              namescreen: 'Dalam Perjalanan',
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          Image.asset(Iconss.scooter),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Dalam Perjalanan',
                            style: primaryTextStyle2.copyWith(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListCek(
                              isEqualTo: 'Selesai',
                              namescreen: 'Selesai',
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.done,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Selesai',
                            style: primaryTextStyle2.copyWith(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ListCek(
                              isEqualTo: 'Ditolak',
                              namescreen: 'Ditolak',
                            ),
                          ),
                        );
                      },
                      child: Row(
                        children: [
                          const Icon(
                            Icons.clear,
                            size: 30,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Ditolak',
                            style: primaryTextStyle2.copyWith(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    GestureDetector(
                      onTap: _logout,
                      child: Row(
                        children: [
                          Image.asset(Iconss.logout),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(
                            'Logout',
                            style: primaryTextStyle2.copyWith(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: extrabold),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 20 / 100,
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
