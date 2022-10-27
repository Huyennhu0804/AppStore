library cart;

import 'package:project_learning_g1/model/cart_model.dart';
import 'package:project_learning_g1/model/product_model.dart';


List<CartModel> lst = [];

void addToCart(ProductModel product, int unit){
  bool ok = true;
  for (int i = 0; i < lst.length; i++){
    if (lst[i].id == product.id){
      ok = false;
      lst[i]?.quantity += unit;
    }
  }
  if (ok){
    lst.add(CartModel(id: product.id,
        title: product.title,
        price: product.price,
        description: product.description,
        category: product.category,
        image: product.image,
        quantity: unit));
  }
}

void remove(int id) {
  for (int i = 0; i < lst.length; i++){
    if (lst[i].id == id){
      lst.remove(lst[i]);
      break;
    }
  }
}

CartModel findById(int id){
  for (int i = 0; i < lst.length; i++){
    if (lst[i].id == id){
      return lst[i];
    }
  }
  return CartModel(quantity: 0,id:-1);
}