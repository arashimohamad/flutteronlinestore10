// ignore_for_file: file_names

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutteronlinestore10/screens/add_product.dart';
import 'package:flutteronlinestore10/screens/edit_product.dart';
import 'package:flutteronlinestore10/screens/product_detail.dart';
import 'package:http/http.dart' as http;

// Tak boleh guna class HomePage extends StatelessWidget. Ini krn jika user delete product,
// maka skrin mobile masih lagi paparkan data yg telah dihapuskan. Caranya kita kena convert kpd
// class HomePage extends StatefulWidget

class HomePage extends StatelessWidget {
  const HomePage({
    super.key,
  });

  //Link API Tambah Product
  //buleh guna url di bawah bagi yg guna android emulator
  final String url = "http://10.0.2.2/onlinestore10/public/api/products";

  //buleh guna url di bawah bagi yg web browser
  //final String url = 'http://localhost/onlinestore10/public/api/products';

  Future getProducts() async {
    var response = await http.get(Uri.parse(url));
    //print(json.decode(response.body));   //recall data
    return json.decode(response.body);
  }

  //Link API Delete Product
  //final String url2 = "http://10.0.2.2/onlinestore10/public/api/products/delete/";

  //buleh guna url di bawah bagi yg web browser. Bawa parameter product ID
  //final String url2 = 'http://localhost/onlinestore10/public/api/products/delete/';

  //Link API Delete Product
  Future deleteProduct(String productId) async {
    //String urlDelete = url2 + productId;
    //String urlDelete = "http://localhost/onlinestore10/public/api/products/delete/" + productId;
    // ignore: prefer_interpolation_to_compose_strings
    String urlDelete = "http://10.0.2.2/onlinestore10/public/api/products/delete/" + productId;
    var response = await http.delete(Uri.parse(urlDelete));
    //print(json.decode(response.body));   //recall data
    return json.decode(response.body);
  }

  @override
  Widget build(BuildContext context) {
    //getProducts();
    return Scaffold(
        //Floating button utk add product
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            //Arahkan ke Add Product guna
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddProduct(),
                ));
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Center(child: Text('Online Shop')),
        ),
        body: FutureBuilder(
          future: getProducts(),
          builder: (context, snapshot) {
            //cek ada data/tidak
            if (snapshot.hasData) {
              return ListView.builder(
                  // ListView utk looping
                  itemCount: snapshot.data['data'].length, // bil item
                  itemBuilder: (context, index) {
                    //return Text(snapshot.data['data'][index]['name']);
                    return SizedBox(
                      //add style
                      height: 180,
                      child: Card(
                        elevation: 5,
                        child: Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ProductDetail(
                                              product: snapshot.data['data']
                                                  [index],
                                            )));
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                height: 120,
                                width: 120,
                                child: Image.network(
                                  snapshot.data['data'][index]['image_url'],
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.all(10.0),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Align(
                                      alignment: Alignment.topLeft,
                                      child: Text(
                                        snapshot.data['data'][index]['name'],
                                        style: const TextStyle(
                                            fontSize: 20.0,
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Align(
                                        alignment: Alignment.topLeft,
                                        child: Text(snapshot.data['data'][index]
                                            ['description'])),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            GestureDetector(
                                                onTap: () {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder:
                                                              (context) =>
                                                                  EditProduct(
                                                                    product: snapshot
                                                                            .data['data']
                                                                        [index],
                                                                  )));
                                                },
                                                child: const Icon(Icons.edit)),
                                            GestureDetector(
                                                onTap: () {
                                                  deleteProduct(snapshot.data['data'][index]['id'].toString()).then((value){
                                                    //Refresh screen mobile guna setState tapi class kena pakai class StatefulWidget
                                                    //setState(() {});
                                                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                                                      content: Text("Product Successfully Deleted !"),
                                                    ));
                                                  });
                                                },
                                                child: const Icon(Icons.delete)),
                                          ],
                                        ),
                                        Text(snapshot.data['data'][index]
                                                ['price']
                                            .toString()),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  });
            } else {
              return const Text('Data error');
            }
          },
        ));
  }
}
