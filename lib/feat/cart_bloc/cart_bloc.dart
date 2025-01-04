import 'dart:math';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/feat/cart_bloc/cart_event.dart';
import 'package:pizz_lecious/feat/cart_bloc/cart_state.dart';
import 'package:pizz_lecious/feat/cart_detail_view/models/cart_product_model.dart';
import 'package:pizz_lecious/feat/global_constants.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState(cartList: cartList)) {
    on<CartAddEvent>((event, emit) async {
      bool productExists = false;
      if (cartList.isEmpty) {
        cartList.add(CartProductModel(
            productName: event.name,
            productPrice: event.price.toDouble(),
            qty: 1,
            id: event.id));
        emit(CartAddedState(cartList: cartList));
      } else {
        for (var data in cartList) {
          if (data.id == event.id) {
            productExists = true;
            break;
          }
        }
        if (productExists) {
          emit(CartAlreadyAddedState(warningMessage: 'Item already added!'));
        } else {
          cartList.add(CartProductModel(
              productName: event.name,
              productPrice: event.price.toDouble(),
              qty: 1,
              id: event.id));
          emit(CartAddedState(cartList: cartList));
        }
      }
    });
    on<CartReInitializeCartEvent>(
        (event, emit) => emit(CartAddedState(cartList: cartList)));
    on<CartProductQtyIncementEvent>((event, emit) {
      for (var data in cartList) {
        data.qty++;
      }
      emit(CartAddedState(cartList: cartList));
    });
    on<CartProductQtyDecrementEvent>((event, emit) {
      for (var data in cartList) {
        if (event.qty > 1) {
          data.qty--;
        }
      }
      emit(CartAddedState(cartList: cartList));
    });
    on<CartProductRemoveEvent>(
      (event, emit) async {
        cartList.removeAt(event.index);
        emit(CartAddedState(cartList: cartList));

        if (cartList.isEmpty) {
          emit(CartEmptyState());
        }
        if (CartBloc().isClosed) {
          close();
        }
      },
    );
  }
}
