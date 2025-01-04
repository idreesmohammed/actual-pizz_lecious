abstract class CartEvent {}

class CartAddEvent extends CartEvent {
  int id;
  CartAddEvent({required this.id});
}
