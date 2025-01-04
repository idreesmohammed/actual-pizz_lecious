abstract class CartEvent {}

class CartAddEvent extends CartEvent {
  int id;
  String name;
  double price;
  CartAddEvent({required this.id, required this.name, required this.price});
}

class CartProductQtyIncementEvent extends CartEvent {
  int qty;
  CartProductQtyIncementEvent({required this.qty});
}

class CartProductQtyDecrementEvent extends CartEvent {
  int qty;
  CartProductQtyDecrementEvent({required this.qty});
}

class CartProductRemoveEvent extends CartEvent {
  int index;
  CartProductRemoveEvent({required this.index});
}

class CartReInitializeCartEvent extends CartEvent {}
