abstract class CartState {}

class CartAddedState extends CartState {
  int id;
  CartAddedState({required this.id});
}

class CartInitialState extends CartState {
  int id;
  CartInitialState({required this.id});
}

class CartAlreadyAddedState extends CartState {
  String warningMessage;
  CartAlreadyAddedState({required this.warningMessage});
}
