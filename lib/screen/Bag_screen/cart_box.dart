import 'package:flutter/material.dart';
import 'package:kelompok6_a22/util/theme.dart';

class CartBox extends StatelessWidget {
  final String image;
  final String text;
  final String harga;
  final String jumlah;
  final String kategori;

  const CartBox({
    super.key,
    required this.image,
    required this.text,
    required this.harga,
    required this.jumlah,
    required this.kategori,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(2)),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * 13 / 100,
                  width: MediaQuery.of(context).size.width * 27 / 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    color: bg3Color,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2),
                    child: Image.asset(
                      image,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height * 1 / 100,
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: SizedBox(
                      width: double.infinity,
                      height: MediaQuery.of(context).size.height * 10 / 100,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    text,
                                    style: primaryTextStyle3.copyWith(
                                        fontSize: 19),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        1 /
                                        100,
                                  ),
                                  Icon(
                                    Icons.delete,
                                    size: 30,
                                    color: Colors.red.withOpacity(0.7),
                                  )
                                ],
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        kategori,
                                        style: primaryTextStyle2.copyWith(
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        3 /
                                        100,
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    "Qty ",
                                    style: primaryTextStyle3.copyWith(
                                        fontSize: 20),
                                  ),
                                  Text(
                                    jumlah,
                                    style: primaryTextStyle3.copyWith(
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "Xx",
                                    style: primaryTextStyle3.copyWith(
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              Text(
                                harga,
                                style: primaryTextStyle3.copyWith(fontSize: 17),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
