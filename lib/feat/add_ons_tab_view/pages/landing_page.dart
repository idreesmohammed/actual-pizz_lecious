import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pizz_lecious/feat/add_ons_tab_view/bloc/add_ons_bloc.dart';
import 'package:pizz_lecious/feat/add_ons_tab_view/bloc/add_ons_event.dart';
import 'package:pizz_lecious/feat/add_ons_tab_view/bloc/add_ons_state.dart';

class AddOnLandingPage extends StatefulWidget {
  const AddOnLandingPage({super.key});

  @override
  State<AddOnLandingPage> createState() => _AddOnLandingPageState();
}

class _AddOnLandingPageState extends State<AddOnLandingPage> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder(
      bloc: context.read<AddOnsBloc>()..add(AddOnsGetEvent()),
      builder: (context, state) {
        if (state is AddOnsLoadingState) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is AddOnsLoadSuccesState) {
          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: state.addOnsModel.length,
            itemBuilder: (context, index) {
              return Card(
                elevation: 10,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    decoration:
                        BoxDecoration(borderRadius: BorderRadius.circular(10)),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          state.addOnsModel[index].type.toUpperCase(),
                          style: const TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Text(
                            "Calories - ${state.addOnsModel[index].calories.toString()}")
                      ],
                    ),
                  ),
                ),
              );
            },
          );
        }
        if (state is AddOnsLoadFailuerState) {
          return Text(state.errorMessage);
        }
        return const SizedBox();
      },
    );
  }
}
