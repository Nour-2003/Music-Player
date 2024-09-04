import 'package:flutter/src/material/theme_data.dart';
import 'package:flutter/src/widgets/icon.dart';

abstract class AppStates {

}
class InitialState extends AppStates{

}
class BlackTheme extends AppStates{
  BlackTheme(bool themebool, Icon icon, ThemeData theme);

}
class WhiteTheme extends AppStates{
  WhiteTheme(bool themebool, Icon icon, ThemeData theme);

}