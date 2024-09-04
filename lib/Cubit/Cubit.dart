import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Cubit States.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(InitialState());

  static AppCubit get(context) => BlocProvider.of(context);
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