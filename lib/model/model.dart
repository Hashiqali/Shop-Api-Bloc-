class ProductModel {
  int id;
  String name;
  String price;
  String brand;
  String imageurl;
  String description;
  String rating;
  ProductModel(
      {required this.name,
      required this.id,
      required this.brand,
      required this.rating,
      required this.price,
      required this.description,
      required this.imageurl});

  factory ProductModel.fromjson(Map json) => ProductModel(
      id: json['id'],
      name: json['name'].toString(),
      brand: json['brand'].toString(),
      rating: json['rating'].toString(),
      price: json['price'].toString(),
      description: json['description'].toString(),
      imageurl: json['image_link'].toString());
}
