import 'package:flutter/material.dart';
import 'package:kelompok6_a22/screen/detail_screen/detail_screen_fix.dart';

import '../util/theme.dart';

// ignore: must_be_immutable
class ProductCard extends StatelessWidget {
  final String image;
  final String text;
  final double price;
  late final String category;
  String? description;
  final VoidCallback? onAdd;

  ProductCard({
    super.key,
    required this.image,
    required this.text,
    required this.price,
    required this.category,
    this.onAdd,
    this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context, rootNavigator: true).push(
            MaterialPageRoute(
              fullscreenDialog: true,
              builder: (context) => DetailScreennn(
                category: category,
                description: description ?? '',
                image: image,
                name: text,
                price: price,
              ),
            ),
          );
        },
        child: Container(
          decoration: BoxDecoration(
            color: bg2Color,
            borderRadius: const BorderRadius.all(
              Radius.circular(20),
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.2),
                spreadRadius: 1,
                blurRadius: 3,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            children: [
              Card(
                color: bg2Color,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 8.0,
                      ),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            // ignore: unnecessary_null_comparison
                            child: image != null
                                ? Image.network(
                                    image,
                                    fit: BoxFit.cover,
                                    height: MediaQuery.of(context).size.height *
                                        18 /
                                        100,
                                    width: MediaQuery.of(context).size.width *
                                        38 /
                                        100,
                                  )
                                : Container(
                                    width: MediaQuery.of(context).size.width *
                                        38 /
                                        100,
                                    height: MediaQuery.of(context).size.height *
                                        18 /
                                        100,
                                    color: Colors.grey[300],
                                    child: const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                  ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text,
                      style: primaryTextStyle3.copyWith(
                          fontSize: 17, color: bg3Color, fontWeight: extrabold),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    Text(
                      category,
                      style: primaryTextStyle3.copyWith(
                          fontSize: 15, color: bg3Color, fontWeight: extrabold),
                    ),
                    Row(
                      children: [
                        Text(
                          'Rp ',
                          style: primaryTextStyle2.copyWith(
                              fontSize: 17,
                              color: bg3Color,
                              fontWeight: extrabold),
                        ),
                        Text(
                          price.toInt().toString(),
                          style: primaryTextStyle2.copyWith(
                              fontSize: 17,
                              color: bg3Color,
                              fontWeight: extrabold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
