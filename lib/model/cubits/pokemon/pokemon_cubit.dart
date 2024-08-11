import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ToDoApp/model/cubits/pokemon/pokemon_state.dart';
import 'package:ToDoApp/model/pokemon_model.dart';
import 'package:ToDoApp/view-model/data/network/dio_helper.dart';
import 'package:ToDoApp/view-model/data/network/end_points.dart';

class PokemonCubit extends Cubit<PokemonState> {
  PokemonCubit() : super(PokemonInitialState());

  static PokemonCubit of(context) => BlocProvider.of<PokemonCubit>(context);

  List<PokemonModel> pokemons = [];
  void getAllPokemon() async {
    emit(GetAllPokemonLoadingState());
    await (DioHelper.get(endPoint: EndPoints.pokemon).then(
      (value) {
        pokemons.clear();
        // the next step to convert the( string value) to json to add it in the pokemons list..
        Map<String?, dynamic> json = jsonDecode(value.data);
        for (var i in json['pokemon']) {
          pokemons.add(PokemonModel.fromJson(i));
        }
        emit(GetAllPokemonSuccessfulState());
      },
    ).catchError(
      (error) {
        if (error is DioException) {
          emit(GetAllPokemonFailedState());
          return;
        } else {
          emit(GetAllPokemonFailedState());
          throw error;
        }
      },
    ));
  }
}
