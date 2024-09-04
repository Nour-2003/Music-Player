
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Cubit/Cubit States.dart';
import '../Cubit/Cubit.dart';

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context,state) {},
      builder: (context,state){
        return Scaffold(
          body: AppCubit.get(context)
              .Screens[AppCubit.get(context).currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: AppCubit.get(context).currentIndex,
            onTap: (index) {
              AppCubit.get(context).changeIndex(index);
            },
            items: const [
              BottomNavigationBarItem(
                  icon: Icon(Icons.headphones), label: "My Music"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.video_library_outlined), label: "Watch"),
            ],
          ),
        );
      },
    );
  }
}