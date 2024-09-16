import 'package:flutter/material.dart';
import 'package:kelompok6_a22/screen/pembayarann/COD/detail_paycod.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:kelompok6_a22/screen/pembayarann/detail_pay.dart';

// ignore: must_be_immutable
class PayCard extends StatelessWidget {
  final String image;
  final String nama;
  final String nomor;
  final String penerima;
  final String orderId;
  final String kodeOrder;
  final String userId;
  final String lengkapUser;
  final String total;
  final VoidCallback? onAdd;
  final String username;
  final String address;

  const PayCard({
    super.key,
    required this.image,
    required this.nama,
    this.onAdd,
    required this.nomor,
    required this.penerima,
    required this.orderId,
    required this.kodeOrder,
    required this.userId,
    required this.lengkapUser,
    required this.total,
    required this.username,
    required this.address,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (nama == 'COD') {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => DetailPayCOD(
                nomor: nomor,
                image: image,
                name: nama,
                penerima: penerima,
                orderId: orderId,
                kodeOrder: kodeOrder,
                userId: userId,
                lengkapUser: lengkapUser,
                total: total,
                username: username,
                address: address,
              ),
            ),
          );
        } else {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => DetailPay(
                nomor: nomor,
                image: image,
                name: nama,
                penerima: penerima,
                orderId: orderId,
                kodeOrder: kodeOrder,
                userId: userId,
                lengkapUser: lengkapUser,
                total: total,
                username: username,
                address: address,
              ),
            ),
          );
        }
      },
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 10 / 100,
        child: Card(
          color: bg1Color,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20,
                ),
              ),
              side: BorderSide(color: bg2Color, width: 2)),
          elevation: 2,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ListTile(
                leading: ClipOval(
                  child: Image.network(
                    image,
                    fit: BoxFit.fill,
                    width: 50,
                    height: 50,
                  ),
                ),
                title: Text(
                  nama,
                  style: primaryTextStyle2.copyWith(
                      color: Colors.black87,
                      fontWeight: FontWeight.bold,
                      fontSize: 17),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
