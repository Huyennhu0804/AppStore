import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_learning_g1/ProductDetail.dart';

import 'package:project_learning_g1/cart_page.dart';
import 'package:project_learning_g1/model/cart_model.dart';
import 'package:project_learning_g1/model/product_model.dart';
import 'package:project_learning_g1/model/rate.dart';
import 'package:project_learning_g1/provider/product_provider.dart';

import 'package:provider/provider.dart';

import "cart.dart" as cart;

import 'model/rate.dart';

class ProductPage extends StatefulWidget {

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  @override
  bool showGrid = true;
  List<CartModel> listCart = [];
  String searchValue = "";
  String category = "all";
  var listProduct;

  Widget build(BuildContext context) {
    var productProvider = Provider.of<ProductProvider>(context);
    productProvider.getList();
    listProduct = productProvider;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const SizedBox(
              height: 20,
            ),
            buildCart(context),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                buildTitle("Product"),
                buildGrid(context),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            buildSearchBar(context),
            const SizedBox(
              height: 20,
            ),
            buildListCategory(productProvider),

            (showGrid
                ? buildGirdProduct(category, searchValue)
                : buildListProduct(category, searchValue))
          ],
        ),
      ),
    );
  }

  //Cart
  buildCart(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Badge(
            badgeContent: Text(
                '${cart.lst.length}', style: TextStyle(color: Colors.white)),
            animationDuration: Duration(milliseconds: 300),
            animationType: BadgeAnimationType.slide,
            position: BadgePosition.topStart(),
            child: IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => CartPage(data: listCart)));
              },
              icon: Icon(Icons.shopping_cart),
            ),
          ),

        ],
      ),
    );
  }

  //Search bar
  buildSearchBar(BuildContext context) {
    return TextField(
      onChanged: (value) =>
          setState(() {
            searchValue = value;
          }),
      style: const TextStyle(color: Colors.blue),
      decoration: InputDecoration(
          hintText: "Search the title of a product",
          prefixIcon: const Icon(Icons.search),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(50))),
    );
  }

  //Grid
  buildGrid(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        IconButton(
            onPressed: () {
              setState(() {
                showGrid = true;
              });
            },
            icon: const Icon(
              Icons.grid_3x3,
              size: 30,
            )),
        IconButton(
            onPressed: () {
              setState(() {
                showGrid = false;
              });
            },
            icon: const Icon(
              Icons.list,
              size: 30,
            ))
      ],
    );
  }

  //ListCategory
  buildListCategory(productProvider) {
    return Container(
      width: double.infinity,
      height: 80,
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: [
            ...listProduct.getAllCategory().map((e) =>
                InkWell(
                  onTap: () =>
                  {
                    setState(() => {category = e})
                  },
                  child: Container(
                    margin: EdgeInsets.all(5),
                    padding: EdgeInsets.all(15),
                    decoration: BoxDecoration(
                        border: (category == e
                            ? const Border(
                            bottom: BorderSide(color: Colors.blue))
                            : const Border())),
                    child: Text(
                      e,
                      style: TextStyle(
                          fontSize: 20,
                          color: (category == e ? Colors.blue : Colors.grey)),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }

  //Title
  buildTitle(String s) {
    return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      Text(
        s,
        style: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
      )
    ]);
  }

  //ListProduct
  buildGirdProduct(String category, String searchValue) {
    List<ProductModel> lss = listProduct.list;
    var listProdGird = [];

    if(category == "all"){
      listProdGird = lss;
    }
    else{
      listProdGird = lss.where((element) =>
      element.category == category).toList();
    }

    if (searchValue != "") {
      listProdGird = lss.where((element) =>
          element.title.toString().toLowerCase().contains(
              searchValue.toLowerCase())).toList();
    }


    return Expanded(
      child: listProdGird.length == 0
          ? Center(
          child: Text(
            'No results found for "${searchValue}"',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ))
          : GridView.count(
        childAspectRatio: .90,
        mainAxisSpacing: 20,
        crossAxisSpacing: 30,
        crossAxisCount: 2,
        children: [
          ...listProdGird.map((e) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetail(data: e)));
              },
              child: Container(
                padding: const EdgeInsets.fromLTRB(8, 15, 8, 0),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xffdcdbdb),
                        blurRadius: 10.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Image.network(e.image ?? "",
                        height: 100, fit: BoxFit.contain),
                    const SizedBox(height: 10),
                    //Title
                    Text(
                        (e.title
                            .toString()
                            .length > 50
                            ? '${e.title!.substring(0, 50)}...'
                            : e.title.toString()) ??
                            "",
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 12,
                        )),
                    //price
                    const SizedBox(height: 10),
                    Text('\$ ${e.price.toString()}' ?? "",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                        )),
                    //Rating and Add to cart
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        //rating
                        buildRating(e.rating),
                        ElevatedButton(
                          child: const Icon(Icons.add_shopping_cart),
                          onPressed: () {
                            // if (handleAddCart(e))
                            //   buildFlashMessage(
                            //       'success', 'Add to cart successfully');
                            // else
                            //   buildFlashMessage('error', 'add cart failed');
                            if(cart.findById(e.id).quantity < 10){
                              cart.addToCart(e, 1);
                            }

                          },
                        )
                      ],
                    )
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  buildListProduct(String category, String searchValue) {

    List<ProductModel> lss = listProduct.list;
    var listProdList = [];

    if(category == "all"){
      listProdList = lss;
    }
    else{
      listProdList = lss.where((element) =>
      element.category == category).toList();
    }

    if (searchValue != "") {
      listProdList = lss.where((element) =>
          element.title.toString().toLowerCase().contains(searchValue.toLowerCase())).toList();
    }


    return Expanded(
      child: listProdList.length == 0
          ? Center(
          child: Text(
            'No results found for "${searchValue}"',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ))
          : ListView(
        scrollDirection: Axis.vertical,
        children: [
          ...listProdList.map((e) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ProductDetail(data: e)));
              },
              child: Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 20),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                        color: Color(0xffdcdbdb),
                        blurRadius: 10.0,
                        offset: Offset(0, 5)),
                    BoxShadow(color: Colors.white, offset: Offset(-5, 0)),
                    BoxShadow(color: Colors.white, offset: Offset(5, 0)),
                  ],
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Image.network(e.image ?? "",
                        width: 80, height: 80, fit: BoxFit.contain),
                    const SizedBox(width: 20),
                    Container(
                      width: 200,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //Title
                          Text(e.title ?? "",
                              textAlign: TextAlign.start,
                              style: const TextStyle(
                                fontSize: 12,
                              )),
                          //price
                          const SizedBox(height: 10),
                          Text('\$ ${e.price.toString()}' ?? "",
                              style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.red,
                              )),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              buildRating(e.rating),
                              const SizedBox(width: 30),
                              Text(
                                'count ${e.rating.count.toString()}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12),
                              )
                            ],
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: 100,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                              onPressed: () {

                                if(cart.findById(e.id).quantity < 10){
                                  cart.addToCart(e, 1);
                                }

                              },
                              icon: const Icon(Icons.add_shopping_cart),
                              label: const Text(
                                'Add Cart',
                                style: TextStyle(fontSize: 18),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            );
          })
        ],
      ),
    );
  }

  buildFlashMessage(String status, String message) {
    return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Container(
          height: 70,
          padding: EdgeInsets.all(18),
          decoration: BoxDecoration(
              color: (status == "success" ? Colors.green : Colors.red),
              borderRadius: BorderRadius.all(Radius.circular(20))),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                message,
                style:
                const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
              (status == "success"
                  ? const Icon(Icons.check_circle_outline_outlined,
                  color: Colors.white, size: 20)
                  : const Icon(
                Icons.error_outline,
                color: Colors.white,
                size: 30,
              ))
            ],
          )),
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      elevation: 0,
    ));
  }

  //handle add cart
  bool handleAddCart(ProductModel pAdd) {
    //Check
    // Nếu product đã có trong cart thì số lượng tăng thêm 1
    if (checkProductExistsInCart(pAdd)) {
      setState(() {
        listCart.map((e) {
          if (e.id == pAdd.id) {
            e.quantity = e.quantity! + 1;
          }
        }).toList();
      });
      return true;
    }
    else {
      //Nếu product chưa có trong cart thì thêm mới quantity = 1
      if (!checkProductExistsInCart(pAdd)) {
        CartModel cAdd = new CartModel(
            id: pAdd.id,
            title: pAdd.title,
            price: pAdd.price,
            description: pAdd.description,
            category: pAdd.category,
            image: pAdd.image,
            quantity: 1
        );
        setState(() {
          listCart.add(cAdd);
        });
        return true;
      }
      else {
        return false;
      }
    }
  }

  bool checkProductExistsInCart(var productAdd) {
    for (var i = 0; i < listCart.length; i++) {
      if (listCart[i].id == productAdd.id) {
        return true;
      }
    }

    return false;
  }

  buildRating(Rating rating) {
    return Row(children: [
      Text('${rating.rate}', style: TextStyle(color: Colors.grey, fontSize: 12),),
      Icon(Icons.star, color: Colors.yellow, size: 14),

    ]);
  }
}






