import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ToDoApp/model/pokemon_model.dart';
import 'package:ToDoApp/view-model/utils/app_colors.dart';
import 'package:ToDoApp/view-model/utils/app_functions.dart';
import 'package:ToDoApp/view-model/utils/click_widget.dart';
import 'package:ToDoApp/view/screens/pokemon/pokemon_details_screen.dart';

class PokemonWidget extends StatelessWidget {
  final PokemonModel pokemon;
   const PokemonWidget({required this.pokemon, super.key});

  @override
  Widget build(BuildContext context) {
    return ClickWidget(
      onTap: () {
        AppFunctions.push(context,  const PokemonDetailsScreen());
      },
      color: AppColors.white,
      elevation: 12,
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: Image.network(
              pokemon.img ?? '',
              errorBuilder: (context, error, stackTrace) {
                return const Icon(Icons.error_outline,color: AppColors.red,) ;
              },
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          Flexible(
              flex: 1,
              child: Text(
                pokemon.name ?? "",
                maxLines: 1,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              )),
        ],
      ),
    );
  }
}
