// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:kelompok6_a22/provider/product_provider.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:provider/provider.dart';

class ChekOutBox extends StatefulWidget {
  final String imageUrl;
  final String title;
  final double price;
  int index;
  int count;
  final String category;

  ChekOutBox({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.price,
    required this.count,
    required this.index,
    required this.category,
  });

  @override
  State<ChekOutBox> createState() => _ChekOutBoxState();
}

class _ChekOutBoxState extends State<ChekOutBox> {
  late ProductProvider productProvider;
  @override
  void initState() {
    super.initState();
    productProvider = Provider.of<ProductProvider>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    ProductProvider productProvider = Provider.of<ProductProvider>(context);
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
                  width: MediaQuery.of(context).size.width * 27 / 100,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(12),
                    color: bg3Color,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      widget.imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: Text(
                                      widget.title,
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                      style: const TextStyle(
                                        fontSize: 19,
                                        color: Colors.black,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        widget.category,
                                        style: primaryTextStyle2.copyWith(
                                            fontSize: 15),
                                      ),
                                    ],
                                  ),
                                  IconButton(
                                    onPressed: () {
                                      productProvider
                                          .deleteCartProduk(widget.index);
                                    },
                                    icon: const Icon(
                                      Icons.delete,
                                      size: 26,
                                      color: Colors.red,
                                    ),
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
                                    widget.count.toString(),
                                    style: primaryTextStyle3.copyWith(
                                        fontSize: 20),
                                  ),
                                  Text(
                                    "X",
                                    style: primaryTextStyle3.copyWith(
                                        fontSize: 20),
                                  ),
                                ],
                              ),
                              Text(
                                "Rp ${widget.price.toInt().toString()}",
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
