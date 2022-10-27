class CategoryModel {
  String ?name;

  CategoryModel(
      {this.name
      });

  factory CategoryModel.fromJson(String name) {
    return CategoryModel(
        name: name
    );
  }
}