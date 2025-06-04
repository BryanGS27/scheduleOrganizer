import 'package:flutter/material.dart';

class ThemeColors {
  static const Color lightThemeBackground = Color.fromARGB(255, 248, 239, 218);
  static const Color darkBrown = Color.fromARGB(255, 59, 39, 30);
  static const Color lightBrown = Color.fromARGB(255, 177, 115, 76);
  static const Color sand = Color.fromARGB(255, 240, 224, 188);
  static const Color lightOrange = Color.fromARGB(255, 200, 147, 79);
  static const Color darkOrange = Color.fromARGB(255, 160, 94, 44);
}

class TextStyles {
  static const header = TextStyle(fontSize: 30, color: Colors.white);
  static const title = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: ThemeColors.darkBrown);
  static const description = TextStyle(fontSize: 14, color: Colors.black);
  static const titles = TextStyle(
      fontSize: 18, fontWeight: FontWeight.bold, color: ThemeColors.darkBrown);
}

class ButtonStyles {
  static ButtonStyle regular = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(ThemeColors.darkBrown),
    foregroundColor: WidgetStateProperty.all(Colors.white),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  );

  static ButtonStyle cancel = ButtonStyle(
    backgroundColor: WidgetStateProperty.all(ThemeColors.darkOrange),
    foregroundColor: WidgetStateProperty.all(Colors.white),
    shape: WidgetStateProperty.all(
      RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),
    padding: WidgetStateProperty.all(
      EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    ),
  );
}
