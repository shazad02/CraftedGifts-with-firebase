// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kelompok6_a22/provider/category_provider.dart';
import 'package:kelompok6_a22/util/icons.dart';
import 'package:kelompok6_a22/screen/dashboard_screen/cari.dart';
import 'package:kelompok6_a22/screen/dashboard_screen/compont/app_bar.dart';
import 'package:kelompok6_a22/screen/dashboard_screen/drawer.dart';
import 'package:kelompok6_a22/screen/profile_Screen/edit_profile.dart';
import 'package:kelompok6_a22/widget/produk_card.dart';
import 'package:provider/provider.dart';

import '../../../../models/produck_model.dart';

import '../../util/theme.dart';

class AllProduct extends StatefulWidget {
  const AllProduct({
    super.key,
  });

  @override
  State<AllProduct> createState() => _AllProductState();
}

class _AllProductState extends State<AllProduct> {
  @override
  Widget build(BuildContext context) {
    Widget allItem() {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 9 / 10,
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance.collection("products").get(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              QuerySnapshot<Map<String, dynamic>> querySnapshot =
                  snapshot.data!;
              List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
                  querySnapshot.docs;

              List<Product> products = documents
                  .map((document) => Product.fromJson(document.data()))
                  .toList();

              return GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.7,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  Product product = products[index];
                  return Column(
                    children: [
                      ProductCard(
                        image: product.image,
                        text: product.name,
                        price: product.price,
                        onAdd: () {
                          print('Tombol tambah diklik');
                        },
                        category: product.category,
                        description: product.description,
                      ),
                    ],
                  );
                },
              );
            }
          },
        ),
      );
    }

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: bg1Color,
        elevation: 0,
        centerTitle: true,
        leading: const AppbarDash(),
        title: Text(
          "All Product",
          style: primaryTextStyle3,
        ),
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
      body: ChangeNotifierProvider<CategoryProvider>(
        create: (_) => CategoryProvider(),
        child: Consumer<CategoryProvider>(
          builder: (context, categoryProvider, _) {
            return SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    allItem(),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
