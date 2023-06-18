import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutteronlinestore10/screens/homepage.dart';
import 'package:http/http.dart' as http;

class AddProduct extends StatelessWidget {
  //const AddProduct({super.key});

  //Untk validasi kita perlukan formKey
  final _formKey = GlobalKey<FormState>();

  //Ambil semua data dari form yg diinput oleh user dgn gunakan class:
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _imageUrlController = TextEditingController();

  //Buat fungsi save Product dan import http/dart

  //buleh guna url di bawah bagi yg guna android emulator
  final String url = "http://10.0.2.2/onlinestore10/public/api/products";

  //buleh guna url di bawah bagi yg web browser
  //final String url = 'http://localhost/onlinestore10/public/api/products';

  Future saveProduct() async {
    //Future ditambah kat depan krn fungsi ini perlukan waktu
    final response = await http.post(Uri.parse(url), body: {
      //body nya apa? ia berupa objek
      "name": _nameController.text, //"name", nama field pada table product
      "description": _descriptionController.text,
      "price": _priceController.text,
      "image_url": _imageUrlController.text,
    });
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Add Product'),
        ),
        body: Form(
            //masukkan formKey di sini
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  //masukkan controller
                  controller: _nameController,
                  decoration: InputDecoration(labelText: 'Name'),
                  //Masukkan validator
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Product Name";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(labelText: 'Description'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Description";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _priceController,
                  decoration: InputDecoration(labelText: 'Price'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Price";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _imageUrlController,
                  decoration: InputDecoration(labelText: 'Image URL'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please Enter Image URL";
                    }
                    return null;
                  },
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      saveProduct().then((value){
                        Navigator.push(
                          context,
                            MaterialPageRoute(
                              builder: (context) => HomePage()));
                        //Berikan notifikasi
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text("Product Successfully Added !"),));
                      });
                    }                      
                    //print(_nameController.text); //mcm laravel guna dd()
                  },
                  child: Text('Save')),
              ],
            )));
  }
}

//Ini screen form add product
//#15 Tambah Produk _ Series Tutorial Toko Online Laravel 8 + Flutter part 15