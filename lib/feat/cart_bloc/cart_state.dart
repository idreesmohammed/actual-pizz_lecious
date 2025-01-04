import 'package:pizz_lecious/feat/cart_detail_view/models/cart_product_model.dart';

abstract class CartState {}

class CartAddedState extends CartState {
  List<CartProductModel> cartList;
  CartAddedState({required this.cartList});
}

class CartInitialState extends CartState {
  List<CartProductModel> cartList;
  CartInitialState({required this.cartList});
}

class CartAlreadyAddedState extends CartState {
  String warningMessage;
  CartAlreadyAddedState({required this.warningMessage});
}

class CartEmptyState extends CartState {}
