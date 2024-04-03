import 'package:flutter/material.dart';
import 'constants.dart';

ThemeData basicTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: MyPrimaryColor,
      textTheme: const TextTheme(
          titleLarge: TextStyle(
            fontSize: LargeTextSize,
            color: Color(0xFF2D2F23),
            // fontWeight: FontWeight.bold,
          ),
          titleMedium: TextStyle(
            fontSize: MediumTextSize,
            color: Color(0xFF424530),
            // fontWeight: FontWeight.bold,
          ),
          titleSmall: TextStyle(
            fontSize: SmallTextSize,
            // fontWeight: FontWeight.bold,
            color: Color(0xFF424530),
          )),
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
