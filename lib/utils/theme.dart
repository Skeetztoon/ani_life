import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData basicTheme () => ThemeData(
  brightness: Brightness.light,
  primaryColor: MyPrimaryColor,

  textTheme: const TextTheme(
      titleLarge: TextStyle(
        fontSize: LargeTextSize,
        // fontWeight: FontWeight.bold,
        // color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontSize: MediumTextSize,
        // fontWeight: FontWeight.bold,
        // color: Colors.white,
      ),
      titleSmall: TextStyle(
        fontSize: SmallTextSize,
        // fontWeight: FontWeight.bold,
        // color: Colors.white,
      )
  ),

  iconTheme: const IconThemeData(
    size: 50.0,
    color: Colors.black,
  ),


  inputDecorationTheme: const InputDecorationTheme(
    hintStyle: TextStyle(
        fontSize: MediumTextSize,
        color: Colors.grey,
        fontWeight: FontWeight.normal),
  ),

  scaffoldBackgroundColor: myBackgroundColor,
);