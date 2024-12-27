import 'package:pizz_lecious/feat/home/models/pizza_model.dart';

abstract class PizzaState {}

class PizzaInitialState extends PizzaState {}

class PizzaLoadingState extends PizzaState {}

class PizzaLoadedSuccessState extends PizzaState {
  List<PizzaModel> pizzaModel;
  PizzaLoadedSuccessState({required this.pizzaModel});
}

class PizzaLoadFailureState extends PizzaState {
  String errorMessage;
  PizzaLoadFailureState({required this.errorMessage});
}

class PizzaUserLogOutState extends PizzaState {}
