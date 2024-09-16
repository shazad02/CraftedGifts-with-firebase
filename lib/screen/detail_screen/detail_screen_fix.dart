import 'package:flutter/material.dart';
import 'package:kelompok6_a22/provider/product_provider.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:kelompok6_a22/util/icons.dart';
import 'package:kelompok6_a22/screen/dashboard_screen/cari.dart';
import 'package:kelompok6_a22/widget/button_circel.dart';
import 'package:kelompok6_a22/screen/Bag_screen/bag.dart';
import 'package:provider/provider.dart';

class DetailScreennn extends StatefulWidget {
  final String image;
  final String name;
  final double price;
  final String category;
  final String description;

  const DetailScreennn({
    super.key,
    required this.image,
    required this.name,
    required this.price,
    required this.category,
    required this.description,
  });

  @override
  State<DetailScreennn> createState() => _DetailScreennnState();
}

class _DetailScreennnState extends State<DetailScreennn> {
  int count = 1;
  late ProductProvider productProvider;

  @override
  Widget build(BuildContext context) {
    productProvider = Provider.of<ProductProvider>(context);
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
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (c) => const CariScreen(
                    namescreen: '',
                  ),
                ),
              );
            },
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Image.asset(
                Iconss.loupe,
                width: 25,
                height: 25,
              ),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 2 / 100,
          ),
          const Icon(Icons.shopping_cart_outlined),
          SizedBox(
            width: MediaQuery.of(context).size.width * 2 / 100,
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 10 / 100),
              child: Container(
                height: MediaQuery.of(context).size.height * 40 / 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  color: bg3Color,
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.network(
                    widget.image,
                    width: 1000,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 2 / 100,
            ),
            Expanded(
              child: Container(
                decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                child: ListView(
                  padding: const EdgeInsets.all(16.0),
                  children: [
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(widget.category,
                                style: primaryTextStyle2.copyWith(
                                    fontSize: 20, color: bg2Color)),
                            SizedBox(
                              width: MediaQuery.of(context).size.width *
                                  0.9, // Sesuaikan lebar container sesuai kebutuhan
                              child: Text(
                                widget.name,
                                style: primaryTextStyle3.copyWith(
                                  fontSize: 20,
                                  fontWeight: extrabold,
                                  color: bg2Color,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  "Rp ",
                                  style: primaryTextStyle3.copyWith(
                                      fontSize: 17,
                                      fontWeight: extrabold,
                                      color: bg2Color),
                                ),
                                Text(
                                  widget.price.toInt().toString(),
                                  style: primaryTextStyle3.copyWith(
                                      fontSize: 17,
                                      fontWeight: extrabold,
                                      color: bg2Color),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(8.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 3,
                            blurRadius: 5,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: RichText(
                        text: TextSpan(
                          style: primaryTextStyle2.copyWith(
                              fontSize: 17, color: Colors.black),
                          children: widget.description
                              .split('\n')
                              .map((text) => TextSpan(text: '$text\n\n'))
                              .toList(),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    Text(
                      "Quanty Item",
                      style: primaryTextStyle2.copyWith(
                          fontSize: 15, fontWeight: extrabold, color: bg2Color),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 2 / 100,
                    ),
                    Container(
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: bg2Color,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                if (count > 1) {
                                  count--;
                                }
                              });
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: bg1Color,
                            ),
                          ),
                          Text(
                            count.toString(),
                            style: primaryTextStyle3.copyWith(
                                fontSize: 18,
                                fontWeight: extrabold,
                                color: bg1Color),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                count++;
                              });
                            },
                            icon: const Icon(
                              Icons.add,
                              color: bg1Color,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(15),
        child: ButtonCircle(
          textButton: "Add To Bag",
          onPressed: () {
            productProvider.getCardData(
              name: widget.name,
              image: widget.image,
              quenty: count,
              price: widget.price,
              category: widget.category,
            );
            Navigator.of(context).pushReplacement(
              MaterialPageRoute(
                builder: (context) => const Bag(),
              ),
            );
          },
          buttomcolor: bg2Color,
          textcolor: bg3Color,
        ),
      ),
    );
  }
}
