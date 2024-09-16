// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:kelompok6_a22/provider/product_provider.dart';
import 'package:kelompok6_a22/util/icons.dart';
import 'package:kelompok6_a22/screen/CekOut_Screen/cekout_card.dart';
import 'package:kelompok6_a22/screen/pembayarann/pilih.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';
import 'dart:math';

import '../../util/theme.dart';

class HasilCekout extends StatefulWidget {
  final Map<String, dynamic> addressData;

  const HasilCekout({required this.addressData, super.key});

  @override
  State<HasilCekout> createState() => _HasilCekoutState();
}

class _HasilCekoutState extends State<HasilCekout> {
  late ProductProvider productProvider;
  String userAddress = '';
  String userName = '';
  String lengkapUser = '';
  String address = '';
  String status = 'Belum Bayar';
  double ongkirPrice = 0.0;
  int index = 0;
  double totalPrice = 0.0;
  int uniqueCode = 0;

  @override
  void initState() {
    super.initState();
    getUserAddress();
    _generateUniqueCode();
  }

  void _generateUniqueCode() {
    final random = Random();
    // Menghasilkan angka acak antara 10 dan 999 (termasuk 2 dan 3 digit)
    uniqueCode = random.nextInt(990) + 10;
  }

  void getUserAddress() async {
    userAddress = widget.addressData['ongkir'];
    address = widget.addressData['address'];
    setState(() {
      userName = widget.addressData['name'];
    });
    getOngkirPrice();
  }

  void getOngkirPrice() async {
    QuerySnapshot ongkirSnapshot = await FirebaseFirestore.instance
        .collection('ongkir')
        .where('name', isEqualTo: userAddress)
        .get();

    if (ongkirSnapshot.size > 0) {
      setState(() {
        ongkirPrice = double.parse(ongkirSnapshot.docs[0]['price']);
      });
    }
  }

  Widget _buildBottomSingleDetail(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: primaryTextStyle2.copyWith(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
        Text(
          endName,
          style: primaryTextStyle2.copyWith(
            fontSize: 14,
            color: Colors.grey[600],
          ),
        ),
      ],
    );
  }

  Widget _buildBottomSingle(
      {required String startName, required String endName}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(
          startName,
          style: primaryTextStyle2.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        Text(
          endName,
          style: primaryTextStyle2.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    double totalPrice = 0.0;
    double totalProductQuent = 0.0;
    for (var cardModel in productProvider.getCardModelList) {
      totalPrice += cardModel.price * cardModel.quenty;
    }
    for (var cardModel in productProvider.getCardModelList) {
      totalProductQuent += cardModel.quenty;
    }

    return Scaffold(
      backgroundColor: Colors.grey[200],
      appBar: AppBar(
        title: Text(
          "Cekout",
          style: primaryTextStyle3,
        ),
        backgroundColor: bg1Color,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(Iconss.arrowback)),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SizedBox(
              width: double.infinity,
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Name: ${widget.addressData['name']}',
                        style: primaryTextStyle2.copyWith(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Address: ${widget.addressData['address']}',
                        style: primaryTextStyle2.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Phone: ${widget.addressData['phone']}',
                        style: primaryTextStyle2.copyWith(fontSize: 14),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Kecamatan: ${widget.addressData['ongkir']}',
                        style: primaryTextStyle2.copyWith(fontSize: 14),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: ListView.builder(
              padding: const EdgeInsets.all(8.0),
              itemCount: productProvider.getCardModelListLength,
              itemBuilder: (context, myIndex) {
                index = myIndex;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: CekOutCardd(
                    imageUrl: productProvider.getCardModelList[myIndex].image,
                    title: productProvider.getCardModelList[myIndex].name,
                    price: productProvider.getCardModelList[myIndex].price,
                    count: productProvider.getCardModelList[myIndex].quenty,
                    totalPrice: totalPrice,
                    index: myIndex,
                    category: productProvider.getCardModelList[index].category,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 7,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  _buildBottomSingleDetail(
                    startName: "Jumlah Barang",
                    endName: "${totalProductQuent.toStringAsFixed(0)} Item",
                  ),
                  _buildBottomSingleDetail(
                    startName: "Ongkir",
                    endName: productProvider.getCardModelListLength > 0
                        ? "Rp ${ongkirPrice.toInt()}"
                        : "Rp 0",
                  ),
                  _buildBottomSingleDetail(
                    startName: "Subtotal",
                    endName: "Rp ${totalPrice.toInt()}",
                  ),
                  _buildBottomSingleDetail(
                    startName: "Kode Unik",
                    endName: "$uniqueCode",
                  ),
                  _buildBottomSingle(
                    startName: "Total Pembayaran",
                    endName: productProvider.getCardModelListLength > 0
                        ? "Rp ${totalPrice.toInt() + ongkirPrice.toInt() + uniqueCode}"
                        : "Rp 0",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Total ",
                  style: primaryTextStyle2.copyWith(
                      color: Colors.black87, fontWeight: FontWeight.bold),
                ),
                Text(
                  productProvider.getCardModelListLength > 0
                      ? "Rp ${totalPrice.toInt() + ongkirPrice.toInt() + uniqueCode}"
                      : "Rp 0",
                  style: primaryTextStyle2.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 18),
                )
              ],
            ),
            SizedBox(
              height: 45,
              width: MediaQuery.of(context).size.width * 0.4,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: bg2Color,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                onPressed: () async {
                  if (productProvider.cartModelList.isNotEmpty) {
                    print("Button diklik");
                    User? user = FirebaseAuth.instance.currentUser;
                    String? userId = user?.uid;

                    String? userEmail = user?.email;
                    double totalProductPrice = 0.0;
                    for (var cardModel in productProvider.getCardModelList) {
                      totalProductPrice += cardModel.price * cardModel.quenty;
                    }
                    String kodeOrder =
                        FirebaseFirestore.instance.collection("order").doc().id;

                    FirebaseFirestore.instance.collection("order").add({
                      "produk": productProvider.cartModelList
                          .map((c) => {
                                "produkName": c.name,
                                "produkPrice": c.price,
                                "produkQuantity": c.quenty,
                              })
                          .toList(),
                      "kodeOrder": kodeOrder,
                      "totalPrice":
                          totalProductPrice + ongkirPrice.toInt() + uniqueCode,
                      "userName": userName,
                      "userEmail": userEmail,
                      "userAlamat": userAddress,
                      "lengkapUser": address,
                      "lengkapUserr": widget.addressData,
                      "UserUid": userId,
                      "status": status,
                      "ongkir": ongkirPrice.toInt(),
                      'time': FieldValue.serverTimestamp(),
                      "address": address,
                    });

                    productProvider.clearCartProduk();
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        fullscreenDialog: true,
                        builder: (context) => PayScreen(
                          kodeOrder: kodeOrder,
                          userId: userId!,
                          username: userName,
                          address: address,
                          lengkapUser: lengkapUser,
                          total: (totalProductPrice +
                                  ongkirPrice.toInt() +
                                  uniqueCode)
                              .toStringAsFixed(0),
                        ),
                      ),
                    );
                  } else {
                    // Handle case when cart is empty
                  }
                },
                child: Text(
                  "Checkout",
                  style: primaryTextStyle2.copyWith(
                      color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
