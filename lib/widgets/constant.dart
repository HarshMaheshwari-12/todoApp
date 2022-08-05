import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todo_app_with_flutter_and_firebase/widgets/color_utility.dart';

class Constant {
  static ThemeData defaultTheme() {
    final Color primary = ColorUtility.colorFromHex('46549f');
    final Color primaryLight = ColorUtility.colorFromHex('73a1e8');
    final Color primaryDark = ColorUtility.colorFromHex('2369d5');
    final Color secondary = ColorUtility.colorFromHex('e0a141');
    final Color secondaryLight = ColorUtility.colorFromHex('ebc384');
    final Color secondaryDark = ColorUtility.colorFromHex('dd9930');
    final Color primaryLight2 = ColorUtility.colorFromHex('5d5858');
    final Color bottomSelectedLight = ColorUtility.colorFromHex('5b99dd');
    final Color error = Colors.redAccent;
    final Color backgroundColor = ColorUtility.colorFromHex('f6f5f5');
    return ThemeData(
      textSelectionTheme: TextSelectionThemeData(
        cursorColor: secondary,
      ),
      cupertinoOverrideTheme: CupertinoThemeData(primaryColor: secondary),
      // brightness: Brightness.dark,
      primaryColor: primary,
      primaryColorLight: primaryLight,
      primaryColorDark: primaryDark,
      cardColor: primaryLight2,
      backgroundColor: backgroundColor,
      selectedRowColor: bottomSelectedLight,
      textTheme: TextTheme(button: TextStyle(fontSize: 18)),
      buttonTheme: ButtonThemeData(
        padding: EdgeInsets.all(15),
        buttonColor: secondary,
        textTheme: ButtonTextTheme.normal,
        highlightColor: secondaryLight,
        splashColor: secondaryDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(10.0),
          ),
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          primary: secondary,
          minimumSize: Size(88, 36),
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          onPrimary: Colors.white,
          primary: secondary,
          minimumSize: Size(88, 36),
          padding: EdgeInsets.all(15),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
          ),
        ),
      ),
      colorScheme: ColorScheme(
        // brightness: Brightness.dark,
        //commented for implementing the new design
        brightness: Brightness.light,
        background: Colors.black,
        onBackground: Colors.white,
        primary: primary,
        secondary: secondary,
        surface: Colors.white,
        error: error,
        onPrimary: Colors.white,
        onSecondary: Colors.black,
        onSurface: Colors.white,
        onError: Colors.white,
      ).copyWith(secondary: secondary),
    );
  }
}
