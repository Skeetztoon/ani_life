import 'package:ani_life/utils/constants.dart';
import 'package:flutter/material.dart';

ThemeData basicTheme() => ThemeData(
      brightness: Brightness.light,
      primaryColor: myPrimaryColor,
      textTheme: const TextTheme(
        titleLarge: TextStyle(
          fontSize: largeTextSize,
          color: Color(0xFF2D2F23),
          // fontWeight: FontWeight.bold,
        ),
        titleMedium: TextStyle(
          fontSize: mediumTextSize,
          color: Color(0xFF424530),
          // fontWeight: FontWeight.bold,
        ),
        titleSmall: TextStyle(
          fontSize: smallTextSize,
          // fontWeight: FontWeight.bold,
          color: Color(0xFF424530),
        ),
      ),
      iconTheme: const IconThemeData(
        size: 50.0,
        color: Colors.black,
      ),
      inputDecorationTheme: const InputDecorationTheme(
        hintStyle: TextStyle(
          fontSize: mediumTextSize,
          color: Colors.grey,
          fontWeight: FontWeight.normal,
        ),
      ),
      scaffoldBackgroundColor: myBackgroundColor,
    );
