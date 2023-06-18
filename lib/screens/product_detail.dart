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
          Container(child: Image.network(product['image_url']),),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,  //bagi jarak antara price dan icon
              children: [
                Text(
                  product['price'], 
                  style: TextStyle(fontSize: 22),
                  ),
                Row(
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