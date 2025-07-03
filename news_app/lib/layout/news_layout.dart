import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/cubit/cubit.dart';
import 'package:news_app/network/remote/dio_helper.dart';

import '../cubit/states.dart';

class NewsLayout extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit(),
      child: BlocConsumer<NewsCubit, NewsStates>(
        listener: (context, state) {},
        builder: (context, state) {
          NewsCubit cubit = NewsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: Text('News App'),
              actions: [
                IconButton(
                  icon: Icon(Icons.search),
                  onPressed: () {
                    // Implement search functionality here
                  },
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              onTap: (index) {
                cubit.changeBottomNav(index);
              },
              items: cubit.bottomItems,
            ),
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                DioHelper.getData('v2/top-headlines', {
                  'country': 'us',
                  'category': 'business',
                  'apiKey': 'e5fc4a3f6b7345d1b3f6b50091628c1b'
                }).then((value) {
                  print(value.data.toString());
                }).catchError((error) {
                  print('Error: $error');
                });
              },
              child: Icon(Icons.add),
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
