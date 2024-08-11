
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ToDoApp/model/cubits/pokemon/pokemon_cubit.dart';
import 'package:ToDoApp/model/cubits/pokemon/pokemon_state.dart';
import 'package:ToDoApp/view-model/utils/app_colors.dart';
import 'package:ToDoApp/view/screens/pokemon/widgets/pokemon_widget.dart';

class PokemonScreen extends StatelessWidget {

  const PokemonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: PokemonCubit.of(context)..getAllPokemon(),
      child: Scaffold(
          appBar: AppBar(
            backgroundColor: AppColors.blueAccent.withOpacity(0.8),
            title: const Text('Pokemon App'),
            centerTitle: true,
          ),
          body: BlocBuilder<PokemonCubit, PokemonState>(
            builder: (context, state) {
              return GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 12.sp,
                mainAxisSpacing: 12.sp,
                padding: EdgeInsets.all(12.sp),
                children: List.generate(
                  PokemonCubit.of(context).pokemons.length,
                  (index) => PokemonWidget(
                      pokemon: PokemonCubit.of(context).pokemons[index]),
                ),
              );
            },
          )),
    );
  }
}
