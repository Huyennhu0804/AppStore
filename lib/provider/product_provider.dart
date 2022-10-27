import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:project_learning_g1/model/category_model.dart';
import 'dart:convert';
import 'package:project_learning_g1/model/product_model.dart';

class ProductProvider extends ChangeNotifier {
  List<ProductModel> list = [];
  List<CategoryModel> listCategory = [];

  void getList() async {
    String apiURL = "https://fakestoreapi.com/products";
    var client = http.Client();
    var jsonString = await client.get(Uri.parse(apiURL));
    var jsonObject = jsonDecode(jsonString.body);
    var productListObject = jsonObject as List;

    list = productListObject.map((e) {
      return ProductModel.fromJson(e);
    }).toList();
    notifyListeners();
  }

  List<ProductModel> getListProduct(String category, String searchValue) {
    List<ProductModel> listProdGird = [];
    if (category == "all") {
      listProdGird = list;
    } else {
      if (category != "all") {
        listProdGird =
            list.where((element) => element.category == category).toList();
      } else {
        if (searchValue != "") {
          listProdGird = list
              .where((element) => element.title
                  .toString()
                  .toLowerCase()
                  .contains(searchValue.toLowerCase()))
              .toList();
        }
      }
    }

    return listProdGird;
  }

  List<String> getAllCategory() {
    List<String> lst = <String>['all'];
    lst.add("men's clothing");
    lst.add("jewelery");
    lst.add("electronics");
    lst.add("women's clothing");

    return lst;
  }
}
