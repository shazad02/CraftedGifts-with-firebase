// ignore_for_file: avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kelompok6_a22/provider/category_provider.dart';
import 'package:kelompok6_a22/util/icons.dart';
import 'package:kelompok6_a22/widget/produk_card.dart';
import 'package:provider/provider.dart';
import '../../../../../models/produck_model.dart';
import '../../util/theme.dart';

class CariScreen extends StatefulWidget {
  final String namescreen;

  const CariScreen({
    super.key,
    required this.namescreen,
  });

  @override
  State<CariScreen> createState() => _CariScreenState();
}

class _CariScreenState extends State<CariScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = "";

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _updateSearchQuery(String newQuery) {
    setState(() {
      _searchQuery = newQuery;
    });
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'cari products',
          hintStyle: primaryTextStyle2,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.asset(
              Iconss.loupe,
              width: 1,
              height: 1,
            ),
          ),
          suffixIcon: IconButton(
            icon: const Icon(Icons.arrow_forward_ios),
            onPressed: () {
              // You can add additional search functionality here if needed
              _updateSearchQuery(_searchController.text);
            },
          ),
        ),
        onChanged: _updateSearchQuery,
      ),
    );
  }

  Widget dashboardPopuler() {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 9 / 10,
      child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
        future: _searchQuery.isEmpty
            ? FirebaseFirestore.instance.collection("products").get()
            : FirebaseFirestore.instance
                .collection("products")
                .where("name", isGreaterThanOrEqualTo: _searchQuery)
                .where("name", isLessThanOrEqualTo: '$_searchQuery\uf8ff')
                .get(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            QuerySnapshot<Map<String, dynamic>> querySnapshot = snapshot.data!;
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: bg1Color,
      body: SafeArea(
        child: ChangeNotifierProvider<CategoryProvider>(
          create: (_) => CategoryProvider(),
          child: Consumer<CategoryProvider>(
            builder: (context, categoryProvider, _) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 10),
                    _buildSearchBar(),
                    dashboardPopuler(),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
