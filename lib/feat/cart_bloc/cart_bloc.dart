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
      cartList[event.index].qty++;
      emit(CartAddedState(cartList: cartList));
    });
    on<CartProductQtyDecrementEvent>((event, emit) {
      if (event.qty > 1) {
        cartList[event.index].qty--;
      }
      emit(CartAddedState(cartList: cartList));
    });
    on<CartProductRemoveEvent>(
      (event, emit) async {
        l.e(event.index);
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
    on<CartGetTotalPriceEvent>(
      (event, emit) {
        getTotal(event.listData);
        emit(CartAddedState(cartList: cartList));
      },
    );
  }
  double getTotal(event) {
    return event.listData
        .fold(0, (sum, product) => sum + (product.productPrice * product.qty));
  }
}
