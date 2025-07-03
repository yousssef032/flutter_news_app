import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/states.dart';
import 'package:news_app/modules/settings/settings_screen.dart';
import 'package:news_app/network/remote/dio_helper.dart';

import '../modules/business/business_screen.dart';
import '../modules/science/science_screen.dart';
import '../modules/sports/sports_screen.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());
  static NewsCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  String apiKey = 'e5fc4a3f6b7345d1b3f6b50091628c1b';
  List<Widget> screens = [
    BusinessScreen(),
    ScienceScreen(),
    SportsScreen(),
    SettingsScreen()
  ];
  List<BottomNavigationBarItem> bottomItems = [
    BottomNavigationBarItem(icon: Icon(Icons.business), label: 'Business'),
    BottomNavigationBarItem(icon: Icon(Icons.science), label: 'Science'),
    BottomNavigationBarItem(icon: Icon(Icons.sports), label: 'Sports'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];
  List<dynamic> business = [];
  List<dynamic> sports = [];
  List<dynamic> science = [];
  void changeBottomNav(int index) {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  void getBusinessData() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData('v2/top-headlines', {
      'country': 'us',
      'category': 'business',
      'apiKey': apiKey
    }).then((value) {
      business = value.data['articles'];
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      print('Error: $error');
      emit(NewsGetBusinessErrorState(error.toString()));
    });
  }

  void getSportsData() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData('v2/top-headlines', {
      'country': 'us',
      'category': 'sports',
      'apiKey': apiKey
    }).then((value) {
      sports = value.data['articles'];
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      print('Error: $error');
      emit(NewsGetSportsErrorState(error.toString()));
    });
  }

  void getScienceData() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData('v2/top-headlines', {
      'country': 'us',
      'category': 'science',
      'apiKey': apiKey
    }).then((value) {
      science = value.data['articles'];
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      print('Error: $error');
      emit(NewsGetScienceErrorState(error.toString()));
    });
  }
}
