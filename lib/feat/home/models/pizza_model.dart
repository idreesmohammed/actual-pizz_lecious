class PizzaModel {
  String name;
  String image;
  int id;
  bool isVegan;
  double price;
  double discount;
  int qty;
  List<dynamic> toppings;
  PizzaModel(
      {required this.discount,
      required this.id,
      required this.image,
      required this.isVegan,
      required this.name,
      required this.price,
      required this.qty,
      required this.toppings});
  factory PizzaModel.fromDocument(Map<String, dynamic> doc) {
    return PizzaModel(
      discount: doc['discount'].toDouble(),
      id: doc['id'],
      image: doc['image'],
      isVegan: doc['isVegan'],
      name: doc['name'],
      price: doc['price'].toDouble(),
      qty: 0,
      toppings: doc['toppings'],
    );
  }
}
