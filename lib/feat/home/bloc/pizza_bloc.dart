import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/core/user_repository.dart';
import 'package:pizz_lecious/feat/home/bloc/pizza_event.dart';
import 'package:pizz_lecious/feat/home/bloc/pizza_state.dart';
import 'package:pizz_lecious/feat/home/service/get_all_products_repository_service.dart';

class PizzaBloc extends Bloc<PizzaEvent, PizzaState> {
  int initialIndex = 0;
  PizzaBloc() : super(PizzaInitialState()) {
    UserAuthRepository user = UserAuthRepository();
    GetAllProductsRepositoryService getAllProductsRepositoryService =
        GetAllProductsRepositoryService();
    on<PizzaGetEvent>((event, emit) async {
      emit(PizzaLoadingState());
      try {
        CollectionReference collectionReference =
            FirebaseFirestore.instance.collection('pizzas');
        collectionReference.doc('pizzas').collection('1');
        final data = await getAllProductsRepositoryService.getAllProducts();
        emit(PizzaLoadingState());
        emit(PizzaLoadedSuccessState(pizzaModel: data));
      } catch (e) {
        emit(PizzaLoadFailureState(errorMessage: e.toString()));
      }
    });
    on<PizzaLogOutEvent>(
      (event, emit) async {
        user.logOut();
      },
    );
    on<PizzaOnTabChangeEvent>(
      (event, emit) {
        initialIndex = event.tab;
        try {
          print("eventindex ${event.tab}");
          print("indexChange $initialIndex");
          emit(PizzaOnTabChangeState(tabChange: initialIndex));
        } catch (e) {
          emit(PizzaLoadFailureState(errorMessage: e.toString()));
        }
      },
    );
  }
}
