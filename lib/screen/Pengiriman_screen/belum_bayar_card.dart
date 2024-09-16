// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:kelompok6_a22/screen/pembayarann/pilih.dart';

class CekoCar extends StatelessWidget {
  final String userName;
  final double totalPrice;
  final String kodeOrder;
  final String UserUid;
  final String lengkapUser;
  final String status;
  final DateTime time;

  const CekoCar({
    super.key,
    required this.userName,
    required this.totalPrice,
    required this.kodeOrder,
    required this.UserUid,
    required this.lengkapUser,
    required this.status,
    required this.time,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(
            fullscreenDialog: true,
            builder: (context) => PayScreen(
              kodeOrder: kodeOrder,
              userId: UserUid,
              lengkapUser: lengkapUser,
              total: totalPrice.toStringAsFixed(0),
              username: userName,
              address: lengkapUser,
            ),
          ),
        );
      },
      child: Card(
        color: Colors.white,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    DateFormat('dd-MM-yyyy HH:mm').format(time),
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey[600],
                    ),
                  ),
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: status == "Completed"
                          ? Colors.green.withOpacity(0.1)
                          : Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Text(
                      status,
                      style: primaryTextStyle2.copyWith(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color:
                            status == "Completed" ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
                ],
              ),
              const Divider(height: 20, color: Colors.grey),
              const SizedBox(height: 10),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.numbers, size: 24.0),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "ID: $kodeOrder",
                          style: primaryTextStyle2.copyWith(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Name: $userName",
                          style: primaryTextStyle2.copyWith(
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Address: $lengkapUser",
                          style: primaryTextStyle2.copyWith(
                            fontSize: 14,
                            color: Colors.grey[800],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Total Price: Rp ${totalPrice.toInt()}",
                          style: primaryTextStyle3.copyWith(
                            fontSize: 16,
                            color: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
