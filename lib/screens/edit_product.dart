import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutteronlinestore10/screens/homepage.dart';
import 'package:http/http.dart' as http;

class EditProduct extends StatelessWidget {
  //const AddProduct({super.key});

  //Bawa data product dari HomePage ke edit Product guna Map dan harus
  //sertakan property product (data product)
  final Map product;
  // ignore: use_key_in_widget_constructors
  EditProduct({required this.product});

  //Untk validasi kita perlukan formKey
  final _formKey = GlobalKey<FormState>();

  //Ambil semua data dari form yg diinput oleh user dgn gunakan class:
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  //Buat fungsi save Product dan import http/dart

  //buleh guna url di bawah bagi yg guna android emulator
  final String url =
      "http://10.0.2.2/onlinestore10/public/api/products/update/";

  //buleh guna url di bawah bagi yg web browser
  //final String url = 'http://localhost/onlinestore10/public/api/products/update/';

  Future updateProduct() async {
    //Future ditambah kat depan krn fungsi ini perlukan waktu
    final response =
        await http.put(Uri.parse(url + product['id'].toString()), body: {
      //body nya apa? ia berupa objek
      "name": _nameController.text, //"name", nama field pada table product
      "description": _descriptionController.text,
      "price": _priceController.text,
      "image_url": _imageUrlController.text,
    });

    //print(response.body);
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Edit Product'),
        ),
        body: Form(
            //masukkan formKey di sini
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  //masukkan controller
                  controller: _nameController
                    ..text = product[
                        'name'], //tanda .. tu utk flutter initialize data dari table product
                  decoration: const InputDecoration(labelText: 'Name'),
                  //Masukkan validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Product Name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController
                    ..text = product['description'],
                  decoration: const InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Description";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController..text = product['price'],
                  decoration: const InputDecoration(labelText: 'Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Price";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _imageUrlController..text = product['image_url'],
                  decoration: const InputDecoration(labelText: 'Image URL'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Image URL";
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        updateProduct().then((value) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const HomePage()));
                          //Berikan notifikasi
                          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                              content: Text("Product Successfully Updated !"),));
                        });
                      }
                      //else {}
                      //print(_nameController.text); //mcm laravel guna dd()
                    },
                    child: const Text('Update')),
              ],
            )));
  }
}

//Ini screen form edit product
//#16 Edit Product - Series Tutorial Toko Online Laravel 8 + Flutter
