import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/Cubit/Cubit%20States.dart';
import 'package:music_player/Screens/Mymusic.dart';

import 'Constants/Constants.dart';
import 'Cubit/Cubit.dart';
import 'Screens/Home Page.dart';

void main() {
  runApp( MyApp());
  Bloc.observer = MyBlocObserver();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state)
        {},
        builder: (context,state){
          return  MaterialApp(
            theme: AppCubit.get(context).theme,
            debugShowCheckedModeBanner: false,
            home:  MyHomePage(),
          );
        },
      ),
    );
  }
}
