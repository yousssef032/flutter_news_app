import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/appStates.dart';
import 'package:news_app/network/local/cache_helper.dart';

class Appcubit extends Cubit<AppStates> {
  Appcubit() : super(AppInitialState());
  static Appcubit get(context) => BlocProvider.of<Appcubit>(context);
  bool isDark = false;

  void changeAppMode({bool? fromShared}) {
    if (fromShared != null) {
      isDark = fromShared;
    } else {
      isDark = !isDark;
      CacheHelper.putData(
        key: 'isDark',
        value: isDark,
      ).then((value) {
        emit(AppChangeThemeState());
      });
    }
  }
}
