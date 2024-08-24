
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ToDoApp/model/cubits/theme/theme_state.dart';

class ThemeCubit extends Cubit<ThemeState>{
  ThemeCubit(): super(ThemeInitial());

  static ThemeCubit get(context) => BlocProvider.of<ThemeCubit>(context);

  bool isDark =false;

  void changeThemeMode (){
    isDark =! isDark ;
    emit(ThemeChanged());
  }




}