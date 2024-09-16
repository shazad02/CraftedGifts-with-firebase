// ignore_for_file: library_private_types_in_public_api

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kelompok6_a22/provider/product_provider.dart';
import 'package:kelompok6_a22/util/theme.dart';
import 'package:kelompok6_a22/util/icons.dart';
import 'package:kelompok6_a22/screen/CekOut_Screen/hasil_cekout.dart';
import 'package:kelompok6_a22/widget/custom_textfiled.dart';

class SelectAlamat extends StatefulWidget {
  const SelectAlamat({super.key});

  @override
  _SelectAlamatState createState() => _SelectAlamatState();
}

class _SelectAlamatState extends State<SelectAlamat> {
  late ProductProvider productProvider;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  User? _user;
  String? _selectedAddress;
  Map<String, dynamic>? _selectedAddressData;

  @override
  void initState() {
    super.initState();
    _user = _auth.currentUser;
  }

  void _showAddressForm(
      {Map<String, dynamic>? existingAddress,
      DocumentReference? docRef}) async {
    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (BuildContext context) {
        return AddressFormDialog(existingAddress: existingAddress);
      },
    );

    if (result != null) {
      if (docRef != null) {
        // Update the existing address in Firebase
        await docRef.update(result);
      } else {
        // Save the new address to Firebase with a timestamp
        await _firestore.collection('addresses').add({
          ...result,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    }
  }

  void _navigateToNextScreen(BuildContext context) {
    if (_selectedAddressData != null) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HasilCekout(addressData: _selectedAddressData!),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Address",
          style: primaryTextStyle3,
        ),
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          child: GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Image.asset(
                Iconss.arrowback,
              )),
        ),
      ),
      body: _user == null
          ? const Center(child: Text('User not logged in'))
          : Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => _showAddressForm(),
                  child: Text(
                    'Enter New Address',
                    style: primaryTextStyle2.copyWith(
                      color: Colors.black,
                    ),
                  ),
                ),
                Expanded(
                  child: AddressList(
                    selectedAddress: _selectedAddress,
                    onSelect: (address, addressData) {
                      setState(() {
                        _selectedAddress = address;
                        _selectedAddressData = addressData;
                      });
                    },
                    onEdit: (existingAddress, docRef) => _showAddressForm(
                        existingAddress: existingAddress, docRef: docRef),
                  ),
                ),
              ],
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _navigateToNextScreen(context),
        child: const Icon(
          Icons.arrow_forward,
          color: Colors.white,
        ),
      ),
    );
  }
}

class AddressFormDialog extends StatefulWidget {
  final Map<String, dynamic>? existingAddress;

  const AddressFormDialog({super.key, this.existingAddress});

  @override
  _AddressFormDialogState createState() => _AddressFormDialogState();
}

class _AddressFormDialogState extends State<AddressFormDialog> {
  final _formKey = GlobalKey<FormState>();
  final _addressController = TextEditingController();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  String? _selectedOngkir;
  List<String> _ongkirList = [];

  @override
  void initState() {
    super.initState();
    _loadOngkirData();

    if (widget.existingAddress != null) {
      _addressController.text = widget.existingAddress!['address'];
      _nameController.text = widget.existingAddress!['name'];
      _phoneController.text = widget.existingAddress!['phone'];
      _selectedOngkir = widget.existingAddress!['ongkir'];
    }
  }

  Future<void> _loadOngkirData() async {
    final snapshot =
        await FirebaseFirestore.instance.collection('ongkir').get();
    setState(() {
      _ongkirList = snapshot.docs.map((doc) => doc['name'] as String).toList();
    });
  }

  @override
  void dispose() {
    _addressController.dispose();
    _nameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return AlertDialog(
      title: Text(
        '         Your Address           ',
        style: primaryTextStyle2.copyWith(color: Colors.black),
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Nama',
                style: primaryTextStyle2,
              ),
              CustomTextFil(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                ),
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              Text(
                'Nomor Handphone',
                style: primaryTextStyle2,
              ),
              CustomTextFil(
                controller: _phoneController,
                decoration: const InputDecoration(labelText: 'Phone Number'),
                keyboardType: TextInputType.phone,
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              Text(
                'Kecamatan',
                style: primaryTextStyle2,
              ),
              Container(
                width: double.infinity,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(
                    Radius.circular(15),
                  ),
                  color: bg4color,
                ),
                child: DropdownButtonFormField<String>(
                  decoration: InputDecoration(
                    labelStyle: const TextStyle(
                        color: Colors.white), // Warna teks label
                    enabledBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color:
                              Colors.white), // Warna border ketika tidak fokus
                      borderRadius: BorderRadius.circular(15),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.blue), // Warna border ketika fokus
                      borderRadius: BorderRadius.circular(15),
                    ),
                    border: OutlineInputBorder(
                      borderSide: const BorderSide(
                          color: Colors.white), // Warna border default
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  dropdownColor: bg4color, // Warna latar belakang dropdown
                  iconEnabledColor: Colors.white, // Warna ikon dropdown
                  value: _selectedOngkir,
                  items: _ongkirList.map((ongkir) {
                    return DropdownMenuItem<String>(
                      value: ongkir,
                      child: Text(
                        ongkir,
                        style: const TextStyle(
                            color: Colors.white), // Warna teks item dropdown
                      ),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      _selectedOngkir = value;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an Kecamatan';
                    }
                    return null;
                  },
                ),
              ),
              Text(
                'Alamat Lengakap',
                style: primaryTextStyle2,
              ),
              CustomTextFil(
                controller: _addressController,
                decoration: const InputDecoration(labelText: 'Address'),
                validate: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your address';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: Text(
            'Cancel',
            style: primaryTextStyle2.copyWith(color: Colors.redAccent),
          ),
        ),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              Navigator.of(context).pop({
                'address': _addressController.text,
                'name': _nameController.text,
                'phone': _phoneController.text,
                'ongkir': _selectedOngkir,
                'userId': user?.uid,
              });
            }
          },
          child: Text(
            'Add',
            style: primaryTextStyle2.copyWith(color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class AddressList extends StatelessWidget {
  final String? selectedAddress;
  final Function(String, Map<String, dynamic>) onSelect;
  final Function(Map<String, dynamic>, DocumentReference) onEdit;

  const AddressList({
    super.key,
    required this.selectedAddress,
    required this.onSelect,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      return const Center(child: Text('Please log in to view addresses.'));
    }

    return StreamBuilder<QuerySnapshot>(
      stream: FirebaseFirestore.instance
          .collection('addresses')
          .where('userId', isEqualTo: user.uid)
          .snapshots(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
          return const Center(child: Text('No addresses found.'));
        }

        final addresses = snapshot.data!.docs;

        return ListView.builder(
          itemCount: addresses.length,
          itemBuilder: (context, index) {
            final addressData = addresses[index];
            final data = addressData.data() as Map<String, dynamic>;
            final address = data['address'];
            final name = data['name'];
            final phone = data['phone'];
            final ongkir = data['ongkir'];
            final docRef = addressData.reference;

            return ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //tampilkan data
                  Text(
                    '$name',
                    style: primaryTextStyle3.copyWith(fontSize: 20),
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    '$phone',
                    style: primaryTextStyle2.copyWith(fontSize: 17),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$ongkir',
                    style: primaryTextStyle2.copyWith(fontSize: 17),
                  ),
                  Text(
                    '$address',
                    style: primaryTextStyle2.copyWith(fontSize: 17),
                  ),
                ],
              ),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // IconButton(
                  //   icon: const Icon(
                  //     Icons.edit,
                  //     color: bg4color,
                  //   ),
                  //   onPressed: () => onEdit(data, docRef),
                  // ),

                  Container(
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: IconButton(
                      icon: const Icon(
                        Icons.delete,
                        color: bg4color,
                      ),
                      onPressed: () async {
                        await docRef.delete();
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Container(
                    decoration: const BoxDecoration(
                        color: bg4color,
                        borderRadius: BorderRadius.all(Radius.circular(15))),
                    child: IconButton(
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.white,
                      ),
                      onPressed: () => onEdit(data, docRef),
                    ),
                  ),
                ],
              ),
              leading: IconButton(
                icon: Icon(
                  Icons.check_circle,
                  color:
                      selectedAddress == address ? Colors.green : Colors.grey,
                ),
                onPressed: () {
                  onSelect(address, data);
                },
              ),
            );
          },
        );
      },
    );
  }
}
