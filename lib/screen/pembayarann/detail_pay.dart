// ignore_for_file: use_build_context_synchronously

import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:kelompok6_a22/provider/product_provider.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:kelompok6_a22/util/icons.dart';
import 'package:kelompok6_a22/screen/pembayarann/data.dart';
import 'package:kelompok6_a22/screen/pembayarann/pilih.dart';
import 'package:provider/provider.dart';

class DetailPay extends StatefulWidget {
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

  const DetailPay({
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
  State<DetailPay> createState() => _DetailPayState();
}

class _DetailPayState extends State<DetailPay> {
  int count = 1;
  String userName = '';
  late ProductProvider productProvider;
  Uint8List? _image;
  bool _uploading = false;

  Future<Uint8List?> pickImageFromGallery() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.gallery);
    if (file != null) {
      Uint8List? bytes = await file.readAsBytes();
      return bytes;
    }
    return null;
  }

  Future<Uint8List?> pickImageFromCamera() async {
    final ImagePicker imagePicker = ImagePicker();
    XFile? file = await imagePicker.pickImage(source: ImageSource.camera);
    if (file != null) {
      Uint8List? bytes = await file.readAsBytes();
      return bytes;
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> saveData() async {
    setState(() {
      _uploading = true;
    });

    if (_image != null) {
      try {
        String resp = await StoreData().saveData(
          kodeOrder: widget.kodeOrder,
          file: _image!,
          name: widget.name,
          orderId: widget.orderId,
          userId: widget.userId,
        );
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(resp)),
        );
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to upload image')),
        );
      } finally {
        setState(() {
          _uploading = false;
        });
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Tidak Ada Gambar Yang Dipilih')),
      );
    }
  }

  Future<void> selectImage() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Pilih Gambar"),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                GestureDetector(
                  child: const Text("Gallery"),
                  onTap: () async {
                    Navigator.pop(context);
                    Uint8List? img = await pickImageFromGallery();
                    setState(() {
                      _image = img;
                    });
                  },
                ),
                const Padding(padding: EdgeInsets.all(8.0)),
                GestureDetector(
                  child: const Text("Kamera"),
                  onTap: () async {
                    Navigator.pop(context);
                    Uint8List? img = await pickImageFromCamera();
                    setState(() {
                      _image = img;
                    });
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
    return Scaffold(
      backgroundColor: bg1Color,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          widget.name,
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
              GestureDetector(
                onTap: selectImage,
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.grey[200],
                    borderRadius: BorderRadius.circular(20),
                    image: _image != null
                        ? DecorationImage(
                            image: MemoryImage(_image!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: _image == null
                      ? Center(
                          child: Text(
                            "Upload Bukti Pembayaran",
                            style: primaryTextStyle2.copyWith(
                              color: Colors.black87,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
              const SizedBox(height: 20),
              _buildInfoCard(Icons.apartment, "Banking:", widget.name),
              const SizedBox(height: 10),
              _buildInfoCard(Icons.payment, "No Rekening:", widget.nomor),
              const SizedBox(height: 10),
              _buildInfoCard(Icons.location_on, "Alamat:", widget.address),
              const SizedBox(height: 10),
              _buildInfoCard(Icons.payments, "Total Pembayaran:", widget.total),
              const SizedBox(height: 10),
              _buildInfoCard(Icons.person, "Pemesan:", widget.username),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: (_uploading || _image == null)
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
                label: const Text("Upload"),
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
