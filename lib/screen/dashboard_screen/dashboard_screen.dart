// ignore_for_file: avoid_print, unused_local_variable

import 'package:flutter/material.dart';
import 'package:kelompok6_a22/provider/category_provider.dart';
import 'package:kelompok6_a22/provider/product_provider.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:kelompok6_a22/util/icons.dart';
import 'package:kelompok6_a22/screen/dashboard_screen/cari.dart';
import 'package:kelompok6_a22/screen/dashboard_screen/compont/app_bar.dart';
import 'package:kelompok6_a22/screen/dashboard_screen/compont/caruso.dart';
import 'package:kelompok6_a22/screen/dashboard_screen/drawer.dart';
import 'package:kelompok6_a22/screen/profile_Screen/edit_profile.dart';
import 'package:kelompok6_a22/widget/box_cuttom.dart';

import 'package:kelompok6_a22/screen/Category_screen/category_products.dart';
import 'package:provider/provider.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  Widget _categoryButton() {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, _) {
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          controller: ScrollController(),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      categoryProvider.setCategory('buket');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListProduct(
                            isEqualTo: 'bucket',
                            namescreen: 'bucket area',
                          ),
                        ),
                      );
                    },
                    child: const BoxCutomCategory(
                      image: Iconss.bouquet,
                      text: 'Bouquet',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      categoryProvider.setCategory('giftbox');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListProduct(
                            isEqualTo: 'gift box',
                            namescreen: 'Gift Box',
                          ),
                        ),
                      );
                    },
                    child: const BoxCutomCategory(
                      image: Iconss.giftbox,
                      text: 'Gift Box',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      categoryProvider.setCategory('bouquetbalon');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListProduct(
                            isEqualTo: 'bucket balon',
                            namescreen: 'bucket Ballon',
                          ),
                        ),
                      );
                    },
                    child: const BoxCutomCategory(
                      image: Iconss.bouquetballon,
                      text: 'Bouquet Ballon',
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      categoryProvider.setCategory('akrilik');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListProduct(
                            isEqualTo: 'akrilik',
                            namescreen: 'Akrilik',
                          ),
                        ),
                      );
                    },
                    child: const BoxCutomCategory(
                      image: Iconss.akrilik,
                      text: 'Akrilik',
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  GestureDetector(
                    onTap: () {
                      categoryProvider.setCategory('bingkai');
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ListProduct(
                            isEqualTo: 'bingkai',
                            namescreen: 'Bingkai',
                          ),
                        ),
                      );
                    },
                    child: const BoxCutomCategory(
                      image: Iconss.bingkai,
                      text: 'Bingkai',
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    late ProductProvider productProvider;
    productProvider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bg1Color,
        elevation: 0,
        leading: const AppbarDash(),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const CariScreen(
                    namescreen: '',
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Image.asset(
                Iconss.loupe,
                width: 30,
                height: 30,
              ),
            ),
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
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Image.asset(
                Iconss.avatar,
                width: 40,
                height: 40,
              ),
            ),
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
      drawer: const CustomDrawer(),
      body: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const MyCarousel(),
              const SizedBox(
                height: 10,
              ),
              _categoryButton(),
            ],
          ),
        ),
      ),
    );
  }
}
