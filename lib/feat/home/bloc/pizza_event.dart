abstract class PizzaEvent {}

class PizzaGetEvent extends PizzaEvent {}

class PizzaLogOutEvent extends PizzaEvent {}

class PizzaOnTabChangeEvent extends PizzaEvent {
  int tab;
  PizzaOnTabChangeEvent({required this.tab});
}
