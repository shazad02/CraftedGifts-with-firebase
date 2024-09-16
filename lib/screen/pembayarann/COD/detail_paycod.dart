// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:kelompok6_a22/provider/product_provider.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:kelompok6_a22/util/icons.dart';
import 'package:kelompok6_a22/screen/pembayarann/pilih.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final FirebaseAuth _auth = FirebaseAuth.instance;

class StoreData {
  Future<void> updateDocument(
      String kodeOrder, String newStatus, String name) async {
    QuerySnapshot snapshot = await _firestore
        .collection('order')
        .where('kodeOrder', isEqualTo: kodeOrder)
        .get();

    if (snapshot.docs.isNotEmpty) {
      String documentId = snapshot.docs.first.id;
      await _firestore.collection('order').doc(documentId).update({
        'status': newStatus,
        'pembayaran': name, // Add the pembayaran field
      });
    }
  }

  Future<String> saveData({
    required String name,
    required String orderId,
    String bayar = 'Dalam Perjalanan',
    required String kodeOrder,
    required String userId,
  }) async {
    String resp = "error";
    try {
      User? user = _auth.currentUser;
      if (user != null) {
        await _firestore.collection('buktii').add({
          'name': name,
          'orderId': orderId,
          'userId': userId,
          'kodeOrder': kodeOrder,
          'userGmail': user.email, // Add user.email to the data
          'status': bayar,
          'time': FieldValue.serverTimestamp(),
          'imageLink':
              'default_image', // Replace with a default image reference
        });
        await updateDocument(kodeOrder, bayar,
            name); // Update the document status and add the pembayaran field
        resp = 'Berhasil Mengupload Bukti';
      } else {
        resp = 'User tidak ditemukan.';
      }
    } catch (err) {
      resp = err.toString();
    }
    return resp;
  }
}

class DetailPayCOD extends StatefulWidget {
  final String image;
  final String name;
  final String penerima;
  final String orderId;
  final String nomor;
  final String kodeOrder;
  final String userId;
  final String lengkapUser;
  final String total;
  final String username;
  final String address;

  const DetailPayCOD({
    super.key,
    required this.image,
    required this.name,
    required this.penerima,
    required this.orderId,
    required this.kodeOrder,
    required this.userId,
    required this.nomor,
    required this.lengkapUser,
    required this.total,
    required this.username,
    required this.address,
  });

  @override
  State<DetailPayCOD> createState() => _DetailPayCODState();
}

class _DetailPayCODState extends State<DetailPayCOD> {
  int count = 1;
  String userName = '';
  late ProductProvider productProvider;
  bool _uploading = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> saveData() async {
    setState(() {
      _uploading = true;
    });

    try {
      String resp = await StoreData().saveData(
        kodeOrder: widget.kodeOrder,
        name: widget.name,
        orderId: widget.orderId,
        userId: widget.userId,
      );
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(resp)),
      );
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Gagal Mengupload Bukti')),
      );
    } finally {
      setState(() {
        _uploading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          "COD",
          style: primaryTextStyle2.copyWith(color: Colors.black),
        ),
        backgroundColor: bg1Color,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
              onTap: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    fullscreenDialog: true,
                    builder: (context) => PayScreen(
                      address: widget.address,
                      kodeOrder: widget.kodeOrder,
                      userId: widget.userId,
                      lengkapUser: widget.lengkapUser,
                      total: widget.total,
                      username: widget.username,
                    ),
                  ),
                );
              },
              child: Image.asset(Iconss.arrowback)),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              _buildInfoCard(
                  Icons.apartment, "Metoder Pembayaran:", widget.name),
              const SizedBox(height: 10),
              _buildInfoCard(Icons.location_on, "Alamat:", widget.address),
              const SizedBox(height: 10),
              _buildInfoCard(Icons.payments, "Total Pembayaran:", widget.total),
              const SizedBox(height: 10),
              _buildInfoCard(Icons.person, "Pemesan:", widget.username),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: (_uploading)
                    ? null
                    : () async {
                        await saveData();
                        if (!_uploading) {
                          Navigator.pushNamed(context, '/home');
                        }
                      },
                icon: _uploading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Icon(Icons.upload),
                label: const Text("ChekOut"),
                style: ElevatedButton.styleFrom(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildInfoCard(IconData icon, String title, String value) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        leading: Icon(
          icon,
          size: 30,
          color: bg4color,
        ),
        title: Text(
          title,
          style: primaryTextStyle2.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        subtitle: Text(
          value,
          style: primaryTextStyle2.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 20,
            color: Colors.black,
          ),
        ),
      ),
    );
  }
}
