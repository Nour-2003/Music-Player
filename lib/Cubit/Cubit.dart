import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:music_player/Screens/Mymusic.dart';
import 'package:music_player/Screens/Watch.dart';

import 'Cubit States.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
  int counter =0;
  List<Widget> Screens = [Mymusic(),Watch()];
  // ThemeData theme = ThemeData.light();
  int currentIndex = 0;
  List<Widget> Titles = [
    const Text(
      'My Music',
      style: TextStyle(fontSize: 25),
    ),
    const Text(
      'Watch',
      style: TextStyle(fontSize: 25),
    ),];
  void changeIndex(int index)
  {
    currentIndex = index;
    if(index == 1)
    {

    }
    else if(index == 2)
    {

    }
    else if(index == 3)
    {

    }
    emit(BottomNavChangeState());
  }
  bool themebool = false;
  Icon icon = Icon(Icons.wb_sunny);
  ThemeData theme = ThemeData.light();
  void themeChange() {
    if (!themebool) {
      themebool = !themebool;
      icon = Icon(Icons.nights_stay);
      theme = ThemeData.dark().copyWith(
        drawerTheme: DrawerThemeData(
          backgroundColor: Color(0xFF091227),
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Color(0xFF091227),
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.grey,
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          titleSpacing: 30,
          backgroundColor: Color(0xFF091227),
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
          titleTextStyle: TextStyle(
            color: Colors.white,
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Color(0xFF091227),
      );
      emit(BlackTheme(themebool, icon, theme));
    }
    else {
      themebool = !themebool;
      icon = Icon(Icons.wb_sunny);
      theme = ThemeData.light().copyWith(
        drawerTheme: DrawerThemeData(
          backgroundColor: Colors.white, // Light background for the drawer
        ),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: Colors.white, // Light background for the bottom nav bar
          selectedItemColor: Color(0xFF091227), // Dark selected item color for contrast in light mode
          unselectedItemColor: Colors.grey, // Grey unselected item color for contrast in light mode
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(
            color: Color(0xFF091227), // Dark icon color for contrast in light mode
          ),
          titleSpacing: 30,
          backgroundColor: Colors.white, // Light background for the app bar
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white, // Status bar matches the app bar
            statusBarIconBrightness: Brightness.dark, // Dark icons for light status bar
          ),
          titleTextStyle: TextStyle(
            color: Color(0xFF091227), // Dark text color for app bar title
            fontSize: 25.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        scaffoldBackgroundColor: Colors.white, // Light background for the scaffold
        textTheme: TextTheme(
          bodyLarge: TextStyle(color: Color(0xFF091227)), // Dark text for general content
          bodyMedium: TextStyle(color: Color(0xFF091227)), // Dark text for general content
        ),
        iconTheme: IconThemeData(
          color: Color(0xFF091227), // Dark icons for consistency
        ),
        primaryColor: Color(0xFF091227), // Primary color for consistency with the dark theme
      );
      emit(WhiteTheme(themebool, icon, theme));
    }
  }
}
