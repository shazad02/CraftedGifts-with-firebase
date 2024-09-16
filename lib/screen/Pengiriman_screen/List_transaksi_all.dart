// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:kelompok6_a22/provider/category_provider.dart';
import 'package:kelompok6_a22/util/icons.dart';
import 'package:kelompok6_a22/screen/Pengiriman_screen/cek_status_card.dart';
import 'package:provider/provider.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../models/cek_model.dart';

import '../../util/theme.dart';

class ListCek extends StatefulWidget {
  final String namescreen;
  final String isEqualTo;

  const ListCek({
    super.key,
    required this.isEqualTo,
    required this.namescreen,
  });

  @override
  State<ListCek> createState() => _ListCekState();
}

class _ListCekState extends State<ListCek> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    Widget dashboardPopuler() {
      User? currentUser = _auth.currentUser;

      return SizedBox(
        height: MediaQuery.of(context).size.height * 9 / 10,
        child: FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
          future: FirebaseFirestore.instance
              .collection("order")
              .where("status", isEqualTo: widget.isEqualTo)
              .where("UserUid", isEqualTo: currentUser?.uid)
              .get(),
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

              List<CekModel> cekmodels = documents
                  .map((document) => CekModel.fromJson(document.data()))
                  .toList();

              // Mengurutkan cekmodels berdasarkan waktu (ascending)
              cekmodels.sort((a, b) => b.time.compareTo(a.time));

              if (cekmodels.isEmpty) {
                return Center(
                  child: Text(
                    'Tidak ada Pesanan',
                    style: primaryTextStyle2.copyWith(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                );
              }

              return ListView.builder(
                itemCount: cekmodels.length,
                itemBuilder: (context, index) {
                  CekModel cekModel = cekmodels[index];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: CekCard(
                      UserUid: cekModel.UserUid,
                      kodeOrder: cekModel.kodeOrder,
                      totalPrice: cekModel.totalPrice,
                      userName: cekModel.userName,
                      lengkapUser: cekModel.address,
                      status: cekModel.status,
                      time: cekModel.time,
                      pembayaran: cekModel.pembayaran,
                    ),
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
        elevation: 0,
        backgroundColor: bg1Color,
        centerTitle: false,
        title: Text(
          widget.namescreen,
          style: primaryTextStyle2.copyWith(color: Colors.black),
        ),
        actions: const [],
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(Iconss.arrowback)),
        ),
      ),
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
                    dashboardPopuler(),
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
