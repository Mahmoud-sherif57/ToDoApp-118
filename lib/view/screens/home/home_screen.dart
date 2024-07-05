import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:to_do_app/model/cubits/theme/theme_cubit.dart';
import 'package:to_do_app/view-model/utils/app_colors.dart';
import 'package:to_do_app/view-model/utils/app_functions.dart';
import 'package:to_do_app/view-model/utils/local_keys.g.dart';

import '../../../model/cubits/theme/theme_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(),
      appBar: AppBar(
        leading: AppFunctions.translationIcon(context),
        actions: [
          BlocBuilder<ThemeCubit, ThemeState>(
            builder: (context, state) {
              return IconButton(
                  onPressed: () {
                    ThemeCubit.get(context).changeThemeMode();
                  },
                  icon: Icon(
                    ThemeCubit.get(context).isDark
                        ? Icons.sunny
                        : Icons.nightlight_round_rounded,
                    color: AppColors.black,
                  ));
            },
          ),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.filter_list_outlined,
                color: AppColors.black,
              )),
          SizedBox(),
          IconButton(
              onPressed: () {},
              icon: Icon(
                Icons.logout,
                color: AppColors.black,
              )),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              LocaleKeys.smile.tr(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
