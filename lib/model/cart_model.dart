class CartModel {
  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
  int quantity;

  CartModel(
      { this.id,
        this.title,
        this.price,
        this.description,
        this.category,
        this.image,
        required this.quantity
      }
      );

  factory CartModel.fromJson(Map<String, dynamic> obj) {
    return CartModel(
        id: obj['id'],
        title: obj['title'],
        price: obj['price'],
        description: obj['description'],
        category: obj['category'],
        image: obj['image'],
        quantity: obj['quantity']
      // rating: Rating.fromJson(obj['rating'])
    );
  }
}