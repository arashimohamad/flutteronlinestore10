// ignore_for_file: prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:flutter/material.dart';

class ProductDetail extends StatelessWidget {
  //Kena sertakan property product
  //Map tu adalah type data dari product
  final Map product;
  ProductDetail({required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product['name']),
      ),
      body: Column(
        children: [
          // ignore: avoid_unnecessary_containers
          Container(child: Image.network(product['image_url']),),
          const SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,  //bagi jarak antara price dan icon
              children: [
                Text(
                  product['price'], 
                  style: const TextStyle(fontSize: 22),
                  ),
                const Row(
                  children: [
                    Icon(Icons.edit),
                    Icon(Icons.delete),
                  ],
                )
              ],
            ),
          ),
          Text(product['description']),
        ],
      )
    );
  }

  /* // Kod asal
    @override
    Widget build(BuildContext context) {
      return Container(
        //child: Text('Cuba'),
        child: Text(product['name']),
      );
    }
  */
}

//#15 Tambah Produk _ Series Tutorial Toko Online Laravel 8 + Flutter part 15