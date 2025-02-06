import 'package:flutter/material.dart';

class AppTheme {
  final ColorScheme colorScheme = ColorScheme.fromSwatch().copyWith(
    primary: const Color.fromARGB(255, 209, 10, 17),
  );

  ThemeData getTheme() {
    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      fontFamily: 'Roboto',
      textTheme: const TextTheme(
        bodyMedium: TextStyle(fontFamily: 'Roboto'),
        bodyLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.normal),
        titleLarge: TextStyle(fontFamily: 'Roboto', fontWeight: FontWeight.normal),
      ),
    );
  }
}
