import 'package:pizz_lecious/feat/cart_detail_view/models/cart_product_model.dart';

abstract class CartEvent {}

class CartAddEvent extends CartEvent {
  int id;
  String name;
  double price;
  CartAddEvent({required this.id, required this.name, required this.price});
}

class CartProductQtyIncementEvent extends CartEvent {
  int qty;
  int index;
  CartProductQtyIncementEvent({required this.qty, required this.index});
}

class CartProductQtyDecrementEvent extends CartEvent {
  int qty;
  int index;
  CartProductQtyDecrementEvent({required this.qty, required this.index});
}

class CartProductRemoveEvent extends CartEvent {
  int index;
  CartProductRemoveEvent({required this.index});
}

class CartReInitializeCartEvent extends CartEvent {}

class CartGetTotalPriceEvent extends CartEvent {
  List<CartProductModel> listData;
  CartGetTotalPriceEvent({required this.listData});
}
