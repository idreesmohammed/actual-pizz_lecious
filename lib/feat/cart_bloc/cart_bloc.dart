import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/feat/cart_bloc/cart_event.dart';
import 'package:pizz_lecious/feat/cart_bloc/cart_state.dart';
import 'package:pizz_lecious/feat/global_constants.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(CartInitialState(id: addedProductId.length)) {
    on<CartAddEvent>((event, emit) {
      if (addedProductId.isEmpty || (!addedProductId.contains(event.id))) {
        addedProductId.add(event.id);
        emit(CartAddedState(id: addedProductId.length));
        l.e(addedProductId);
      } else {
        emit(CartAlreadyAddedState(warningMessage: 'item already added!'));
      }
    });
  }
}
