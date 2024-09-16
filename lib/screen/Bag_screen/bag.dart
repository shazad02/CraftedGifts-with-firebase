import 'package:flutter/material.dart';
import 'package:kelompok6_a22/provider/product_provider.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:kelompok6_a22/util/icons.dart';
import 'package:kelompok6_a22/screen/Alamat_Screen/alamat_cekout.dart';

import 'package:kelompok6_a22/screen/Bag_screen/cekout_box.dart';
import 'package:kelompok6_a22/widget/button_cart.dart';
import 'package:provider/provider.dart';

class Bag extends StatefulWidget {
  const Bag({super.key});

  @override
  State<Bag> createState() => _BagState();
}

class _BagState extends State<Bag> {
  late ProductProvider productProvider;
  bool isEmpty = false;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);

    if (productProvider.getCardModelListLength == 0) {
      isEmpty = true;
    } else {
      isEmpty = false;
    }

    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(Iconss.arrowback)),
        ),
        title: Text(
          "Cart",
          style: primaryTextStyle3,
        ),
      ),
      body: isEmpty
          ? Center(
              child: Text(
                "Tidak ada Barang di keranjang",
                style: primaryTextStyle2.copyWith(
                    fontSize: 18, color: Colors.black),
              ),
            )
          : ListView.builder(
              itemCount: productProvider.getCardModelListLength,
              itemBuilder: (context, index) => ChekOutBox(
                index: index,
                imageUrl: productProvider.getCardModelList[index].image,
                title: productProvider.getCardModelList[index].name,
                price: productProvider.getCardModelList[index].price,
                count: productProvider.getCardModelList[index].quenty,
                category: productProvider.getCardModelList[index].category,
              ),
            ),
      bottomNavigationBar: isEmpty
          ? null
          : Padding(
              padding: const EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color: bg2Color,
                ),
                height: 50,
                width: double.infinity,
                child: ButtonCart(
                    textButton: "Checkout",
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (c) => const SelectAlamat(),
                        ),
                      );
                    },
                    buttomcolor: bg2Color,
                    textcolor: blackTextColor),
              ),
            ),
    );
  }
}
