import 'package:flutter/material.dart';
import 'package:project_learning_g1/model/cart_model.dart';
import 'package:project_learning_g1/model/product_model.dart';
import 'package:project_learning_g1/product_page.dart';
import "cart.dart" as cart;
import 'model/cart_model.dart';

class CartPage extends StatefulWidget {
  final List<CartModel> data;

  const CartPage({super.key, required this.data});

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  List<CartModel> listCart = cart.lst;


  @override
  Widget build(BuildContext context) {

    num total = 0;

    for(var i = 0; i < listCart.length ; i++){
      setState(() {
        total = total + (listCart[i].price! * listCart[i].quantity!);
      });
    }

    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(

            children: [
              buildBackButton(context),
              const SizedBox(
                height: 20,
              ),
              buildTitle('Cart', total),
              const SizedBox(
                height: 20,
              ),
              buildListCart(listCart),
              buildButtonCheckout(context),
            ],
          ),
        ));
  }

  buildButtonCheckout (BuildContext context){
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Colors.blue[300],
          borderRadius: BorderRadius.circular(20)),
      alignment: Alignment.center,
      child: Text("Check Out",
        style: TextStyle(
          fontStyle: FontStyle.italic,
            color: Colors.black87),
          ),
    );
  }

  buildBackButton(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      child: IconButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ProductPage()));
        },
        icon: Icon(Icons.arrow_back),
      ),
    );
  }

//  build Title
  buildTitle(String s, num total) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            s,
            style: const TextStyle(
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue),
          ),
          Text('Total \$ ${total.toStringAsFixed(2)}',
            style: const TextStyle(
                fontSize: 24, fontWeight: FontWeight.bold, color: Colors.red),
          ),
        ]);
  }

  buildListCart(List<CartModel> listCart) {
    return Expanded(
      child: listCart.length == 0
          ? const Center(
          child: Text(
            'Cart is Empty!',
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.blue),
          ))
          : ListView(
        scrollDirection: Axis.vertical,
        children: [
          ...listCart.map((e) {
            return GestureDetector(

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
                              //giảm số lượng
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 14),
                                ),
                                onPressed: () {
                                  if(e.quantity! > 1){
                                    cart.addToCart(ProductModel(id:e.id,rating: null, image: e.image,category: e.category,description: e.description,price: e.price,title: e.title),-1 );
                                    setState(() {
                                    });

                                  }
                                },
                                child: const Text('-'),
                              ),
                              // Hiển thị số lượng
                              Text(e.quantity.toString() ?? "",
                                style: const TextStyle(
                                    color: Colors.red,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold
                                ),
                              ),
                              //  Tăng số lượng
                              TextButton(
                                style: TextButton.styleFrom(
                                  textStyle: const TextStyle(fontSize: 14),
                                ),
                                onPressed: () {
                                  if(e.quantity! < 10){
                                    cart.addToCart(ProductModel(id:e.id,rating: null, image: e.image,category: e.category,description: e.description,price: e.price,title: e.title),1 );
                                    setState(() {
                                    });
                                  }

                                },
                                child: const Text('+'),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    // Xóa khỏi cart
                    Container(
                      width: 110,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          ElevatedButton.icon(
                            onPressed: () {
                              cart.remove(e.id ?? 0);
                              setState(() {
                              });
                            },
                            icon: const Icon(Icons.remove_circle_outline),
                            label: const Text(
                              "remove",
                              style: TextStyle(fontSize: 12),
                            ),
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.blue)
                            ),
                          )
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

  void removeProductFromCart(int? id) {
    setState(() {
      listCart = listCart.where((element) =>
      element.id != id).toList();
    });

    // print(listCart);
  }
}



