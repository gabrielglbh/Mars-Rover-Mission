part of '../../core/managers/theme_manager.dart';

final ThemeData dark = ThemeData(
    brightness: Brightness.dark,
    scaffoldBackgroundColor: Colors.grey.shade700,
    colorScheme: ColorScheme.fromSwatch().copyWith(
        secondary: Colors.white,
        brightness: Brightness.dark
    ),
    appBarTheme: AppBarTheme(
      color: Colors.grey.shade700,
      elevation: 0,
      titleTextStyle: const TextStyle(fontSize: FontSizes.fontSize26, color: Colors.white),
      iconTheme: const IconThemeData(color: Colors.white),
    ),
    iconTheme: const IconThemeData(color: Colors.white),
    textTheme: const TextTheme(
        headline1: TextStyle(color: Colors.white),
        headline2: TextStyle(color: Colors.white),
        headline3: TextStyle(color: Colors.white),
        headline4: TextStyle(color: Colors.white),
        headline5: TextStyle(color: Colors.white, fontSize: FontSizes.fontSize26, fontWeight: FontWeight.bold),
        headline6: TextStyle(color: Colors.white, fontSize: FontSizes.fontSize24, fontWeight: FontWeight.bold),
        subtitle1: TextStyle(color: Colors.white),
        subtitle2: TextStyle(color: Colors.black, fontSize: FontSizes.fontSize16),
        bodyText1: TextStyle(color: Colors.white54),
        bodyText2: TextStyle(color: Colors.white54, fontSize: FontSizes.fontSize32),
        caption: TextStyle(color: Colors.white, fontSize: FontSizes.fontSize20, fontWeight: FontWeight.bold),
        button: TextStyle(color: Colors.black, fontSize: FontSizes.fontSize16, fontWeight: FontWeight.bold),
        overline: TextStyle(color: Colors.white)
    ),
    dialogTheme: const DialogTheme(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(RRadius.radius16))),
    ),
    snackBarTheme: SnackBarThemeData(
        backgroundColor: Colors.grey.shade700,
        behavior: SnackBarBehavior.floating,
        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(RRadius.radius16))),
        elevation: 6,
        contentTextStyle: const TextStyle(color: Colors.white)
    ),
    inputDecorationTheme: InputDecorationTheme(
        hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: FontSizes.fontSize26),
        border: OutlineInputBorder(
          borderRadius: const BorderRadius.all(Radius.circular(RRadius.radius8)),
          borderSide: BorderSide(color: Colors.grey.shade400),
        ),
        focusedBorder: const OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(RRadius.radius8)),
          borderSide: BorderSide(color: Colors.white, width: 2.0),
        )
    ),
    dialogBackgroundColor: Colors.grey.shade700
);