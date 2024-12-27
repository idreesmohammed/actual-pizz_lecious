import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/feat/add_ons_tab_view/bloc/add_ons_event.dart';
import 'package:pizz_lecious/feat/add_ons_tab_view/bloc/add_ons_state.dart';
import 'package:pizz_lecious/feat/add_ons_tab_view/service/add_ons_service.dart';

class AddOnsBloc extends Bloc<AddOnsEvent, AddOnsState> {
  AddOnsBloc() : super(AddOnsInitialState()) {
    on<AddOnsGetEvent>((event, emit) async {
      try {
        emit(AddOnsLoadingState());
        final data = await AddOnsService().getAddOnData();
        emit(AddOnsLoadSuccesState(addOnsModel: data));
      } catch (e) {
        emit(AddOnsLoadingState());
        emit(AddOnsLoadFailuerState(errorMessage: e.toString()));
      }
    });
  }
}
