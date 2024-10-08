// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:kelompok6_a22/models/cart_model.dart';
import 'package:kelompok6_a22/models/pay_model.dart';

import '../models/produck_model.dart';
import '../models/user_model.dart';

class ProductProvider with ChangeNotifier {
  final List<Product> _populerProducts = [];
  final List<Product> _priaProduk = [];
  List<PayModel> _PayProducts = [];

  List<Product> get populerProducts {
    return [..._populerProducts];
  }

  List<Product> get priaProduk {
    return [..._priaProduk];
  }

  List<PayModel> get payProducts {
    return [..._PayProducts];
  }

  Future<void> fetchPayProducts() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance.collection("pembayaran").get();
      final List<QueryDocumentSnapshot<Map<String, dynamic>>> documents =
          snapshot.docs;

      _PayProducts = documents
          .map((document) => PayModel.fromJson(document.data()))
          .toList();
    } catch (error) {
      throw 'Failed to fetch Pay products: $error';
    }
  }

  void addOrder() {}

  List<CartModel> cartModelList = [];
  late CartModel cartModel;

  void getCardData({
    required String name,
    required String image,
    required int quenty,
    required double price,
    required String category,
  }) {
    cartModel = CartModel(
      image: image,
      price: price,
      quenty: quenty,
      name: name,
      category: category,
    );
    cartModelList.add(cartModel);
  }

  List<CartModel> get getCardModelList {
    return List.from(cartModelList);
  }

  int get getCardModelListLength {
    return cartModelList.length;
  }

  List<String> notificationList = [];
  void addNotif(String notification) {
    notificationList.add(notification);
  }

  int get getNotificationIndex {
    return notificationList.length;
  }

  List<CartModel> checkOutModelList = [];
  late CartModel checkOutModel;

  void getCheckOutData({
    required String name,
    required String image,
    required int quenty,
    required double price,
    required String category,
  }) {
    checkOutModel = CartModel(
      image: image,
      price: price,
      quenty: quenty,
      name: name,
      category: category,
    );
    checkOutModelList.add(checkOutModel);
  }

  List<CartModel> get getCheckOutModelList {
    return List.from(checkOutModelList);
  }

  int get getCheckOutModelListLength {
    return checkOutModelList.length;
  }

  List<UserModel> userModelList = [];
  late UserModel userModel;

  Future<void> getUserData() async {
    List<UserModel> newList = [];
    User? currentUser = FirebaseAuth.instance.currentUser;
    QuerySnapshot userSnapShot = await FirebaseFirestore.instance
        .collection("user")
        .where("userid", isEqualTo: currentUser?.uid)
        .get();

    for (var element in userSnapShot.docs) {
      if (currentUser?.uid ==
          (element.data() as Map<String, dynamic>)["userid"]) {
        userModel = UserModel(
          email: (element.data() as Map<String, dynamic>)["email"] ?? '',
          name: (element.data() as Map<String, dynamic>)["name"] ?? '',
          phone: (element.data() as Map<String, dynamic>)["phone"] ?? '',
        );
        newList.add(userModel);
      }
    }

    userModelList = newList;
  }

  Future<void> updateUserData({
    required String newName,
    required String newEmail,
    required String newPhone,
  }) async {
    try {
      User? currentUser = FirebaseAuth.instance.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection("user")
            .doc(currentUser.uid)
            .update({
          "name": newName,
          "email": newEmail,
          "phone": newPhone,
        });

        // Update the user model in the list
        int index =
            userModelList.indexWhere((user) => user.userid == currentUser.uid);
        if (index != -1) {
          userModelList[index] = UserModel(
            name: newName,
            email: newEmail,
            phone: newPhone,
          );
        }

        notifyListeners();
      }
    } catch (error) {
      throw 'Failed to update user data: $error';
    }
  }

  late String _userAddress = '';

  String get getUserAddress {
    return _userAddress;
  }

  Future<void> getUserAddressData() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    DocumentSnapshot userSnapshot = await FirebaseFirestore.instance
        .collection("user")
        .doc(currentUser?.uid)
        .get();

    Map<String, dynamic> userData = userSnapshot.data() as Map<String, dynamic>;
    _userAddress = userData['alamat'] ?? '';
  }

  void deleteCartProduk(int index) {
    cartModelList.removeAt(index);
    notifyListeners();
  }

  void clearCartProduk() {
    cartModelList.clear();
    notifyListeners();
  }
}
