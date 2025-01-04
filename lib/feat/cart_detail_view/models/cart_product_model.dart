class CartProductModel {
  String productName;
  double productPrice;
  int qty;
  int id;
  CartProductModel(
      {required this.productName,
      required this.productPrice,
      required this.qty,
      required this.id});
  // factory CartProductModel.fromDoc(Map<String, dynamic> data) {
  //   return CartProductModel(
  //       productName: data['productName'],
  //       productPrice: data['productPrice'],
  //       qty: data['qty'],
  //       id: data['id']);
  // }
}
