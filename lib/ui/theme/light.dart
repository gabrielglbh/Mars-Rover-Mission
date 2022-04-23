part of '../../core/managers/theme_manager.dart';

final ThemeData light = ThemeData(
    brightness: Brightness.light,
    scaffoldBackgroundColor: Colors.white,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.black,
        brightness: Brightness.light
    ),
    appBarTheme: const AppBarTheme(
      color: Colors.white,
      elevation: 0,
      titleTextStyle: TextStyle(fontSize: FontSizes.fontSize26, color: Colors.black),
      iconTheme: IconThemeData(color: Colors.black),
    ),
    iconTheme: const IconThemeData(color: Colors.black),
    textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.black),
        headline2: TextStyle(color: Colors.black),
        headline3: TextStyle(color: Colors.black),
        headline4: TextStyle(color: Colors.black),
        headline5: TextStyle(color: Colors.black, fontSize: FontSizes.fontSize26, fontWeight: FontWeight.bold),
        headline6: TextStyle(color: Colors.black, fontSize: FontSizes.fontSize24, fontWeight: FontWeight.bold),
        subtitle1: TextStyle(color: Colors.black),
        subtitle2: TextStyle(color: Colors.white, fontSize: FontSizes.fontSize16),
        bodyText1: TextStyle(color: Colors.black54),
        bodyText2: TextStyle(color: Colors.black54, fontSize: FontSizes.fontSize32),
        caption: TextStyle(color: Colors.black, fontSize: FontSizes.fontSize20, fontWeight: FontWeight.bold),
        button: TextStyle(color: Colors.white, fontSize: FontSizes.fontSize16, fontWeight: FontWeight.bold),
        overline: TextStyle(color: Colors.black)
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(RRadius.radius16))),
      ),
    ),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(RRadius.radius16))),
    ),
    snackBarTheme: const SnackBarThemeData(
        backgroundColor: Colors.white,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(RRadius.radius16))),
        elevation: 6,
        contentTextStyle: TextStyle(color: Colors.black)
    ),
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: FontSizes.fontSize26),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(RRadius.radius8)),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(RRadius.radius8)),
          borderSide: BorderSide(color: Colors.black, width: 2.0),
        )
    ),
    dialogBackgroundColor: Colors.white
);