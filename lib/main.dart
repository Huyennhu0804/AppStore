import 'package:flutter/material.dart';
import 'package:project_learning_g1/model/cart_model.dart';
import 'package:project_learning_g1/product_page.dart';
import 'package:project_learning_g1/provider/product_provider.dart';
import 'package:provider/provider.dart';



void main() {
  List<CartModel> listCart = [];
  runApp(
      MultiProvider(providers: [
        ChangeNotifierProvider(create: (_)=> ProductProvider())
      ],
        child:  MaterialApp(
          debugShowCheckedModeBanner: false,
          home: ProductPage(),
        ),
      )
    //LIST VIEW & GRID VIEW
  );
}
