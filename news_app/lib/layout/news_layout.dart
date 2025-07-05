import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_app/cubit/appCubit.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/network/remote/dio_helper.dart';
import 'package:news_app/shared/components.dart';
import 'package:news_app/modules/search/search_screen.dart';

import '../cubit/states.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (context, state) {},
      builder: (context, state) {
        NewsCubit cubit = NewsCubit.get(context);
        Appcubit appcubit = Appcubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'News',
              style: GoogleFonts.montserrat(
                textStyle: TextStyle(
                  color: Theme.of(context).appBarTheme.titleTextStyle?.color ??
                      (Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black),
                  fontWeight: FontWeight.bold,
                  fontSize: 26,
                  letterSpacing: 1.0,
                ),
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  navigateTo(context, SearchScreen());
                },
              ),
              IconButton(
                icon: Icon(Icons.brightness_4_outlined),
                onPressed: () {
                  appcubit.changeAppMode();
                },
              )
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: cubit.currentIndex,
            onTap: (index) {
              cubit.changeBottomNav(index);
            },
            items: cubit.bottomItems,
          ),
          body: cubit.screens[cubit.currentIndex],
        );
      },
    );
  }
}
