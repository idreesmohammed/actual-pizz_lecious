import 'package:pizz_lecious/feat/add_ons_tab_view/models/add_ons_model.dart';

abstract class AddOnsState {}

class AddOnsInitialState extends AddOnsState {}

class AddOnsLoadingState extends AddOnsState {}

class AddOnsLoadSuccesState extends AddOnsState {
  List<AddOnsModel> addOnsModel;
  AddOnsLoadSuccesState({required this.addOnsModel});
}

class AddOnsLoadFailuerState extends AddOnsState {
  String errorMessage;
  AddOnsLoadFailuerState({required this.errorMessage});
}
