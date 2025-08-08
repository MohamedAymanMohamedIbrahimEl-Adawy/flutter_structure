import 'package:flutter/material.dart';
import '../../data/constants/app_colors.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.darkBorderColor),
      trackColor: WidgetStateProperty.all(Colors.blue), // Scrollbar track color
      trackBorderColor: WidgetStateProperty.all(
        Colors.black,
      ), // Track border color
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(AppColors.contentColor),
      // fillColor: MaterialStateProperty.all(AppColors.whiteColor),
    ),
    listTileTheme: const ListTileThemeData(
      selectedColor: AppColors.darkBackgroundColor,
      contentPadding: EdgeInsets.zero,
    ),
    dividerColor: AppColors.darkBorderColor,
    brightness: Brightness.dark,
    useMaterial3: true,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      brightness: Brightness.dark,
      primaryContainer: AppColors.darkDialogBackgroundColor,
      onPrimaryContainer: AppColors.darkFieldBackgroundColor,
      inversePrimary: AppColors.whiteColor,
    ),

    scaffoldBackgroundColor: AppColors.darkBackgroundColor,
    cardColor: AppColors.darkDialogBackgroundColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.darkBottomBarColor,
    ),

    appBarTheme: const AppBarTheme(
      surfaceTintColor: AppColors.darkBackgroundColor,
      backgroundColor: AppColors.darkBackgroundColor,
      iconTheme: IconThemeData(color: AppColors.darkTitleColor, size: 24),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        fontFamily: 'Cairo',
        color: AppColors.darkTitleColor,
      ),
      centerTitle: false,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: AppColors.primaryColor),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
        minimumSize: const Size(80, 48),
      ),
    ),

    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      minWidth: 88,
      height: 48,
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
      buttonColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.primaryColor,
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, // Enable the fill color
      fillColor: AppColors.darkFieldBackgroundColor, // Set the fill color
      border: OutlineInputBorder(
        // Optional: Customize the border
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: AppColors.darkBorderColor),
      ),
    ),
    fontFamily: 'Cairo',
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        color: AppColors.darkTitleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headlineMedium: TextStyle(
        color: AppColors.darkTitleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headlineLarge: TextStyle(
        color: AppColors.darkTitleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleSmall: TextStyle(
        color: AppColors.darkTitleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodySmall: TextStyle(
        color: AppColors.darkTitleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: TextStyle(
        color: AppColors.darkTitleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodyLarge: TextStyle(
        color: AppColors.darkTitleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleMedium: TextStyle(
        color: AppColors.darkTitleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleLarge: TextStyle(
        color: AppColors.darkTitleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
    dialogTheme: const DialogThemeData(
      backgroundColor: AppColors.darkDialogBackgroundColor,
    ),
    // pageTransitionsTheme: const PageTransitionsTheme(
    //   builders: {
    //     TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    //   },
    // ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: SlideFadePageTransitionsBuilder(),
        TargetPlatform.iOS: SlideFadePageTransitionsBuilder(),
      },
    ),
  );

  // Light theme
  static ThemeData lightTheme = ThemeData(
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStateProperty.all(AppColors.primaryColor),
      trackColor: WidgetStateProperty.all(Colors.blue),
      trackBorderColor: WidgetStateProperty.all(
        Colors.black,
      ), // Track border color
    ),
    checkboxTheme: CheckboxThemeData(
      checkColor: WidgetStateProperty.all(AppColors.contentColor),
      // fillColor: MaterialStateProperty.all(AppColors.whiteColor),
    ),
    listTileTheme: const ListTileThemeData(
      selectedColor: AppColors.primaryColor,
      contentPadding: EdgeInsets.zero,
    ),
    dividerColor: AppColors.grayColor200,
    brightness: Brightness.light,
    useMaterial3: true,
    hoverColor: Colors.transparent,
    splashColor: Colors.transparent,
    highlightColor: Colors.transparent,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primaryColor,
      primary: AppColors.primaryColor,
      secondary: AppColors.secondaryColor,
      brightness: Brightness.light,
      onPrimaryContainer: AppColors.shade2,
      inversePrimary: AppColors.primaryColor,
    ),
    scaffoldBackgroundColor: AppColors.backgroundColor,
    cardColor: AppColors.whiteColor,
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      backgroundColor: AppColors.whiteColor,
    ),
    appBarTheme: const AppBarTheme(
      surfaceTintColor: AppColors.backgroundColor,
      backgroundColor: AppColors.backgroundColor,
      iconTheme: IconThemeData(color: AppColors.iconColor, size: 24),
      titleTextStyle: TextStyle(
        fontWeight: FontWeight.w700,
        fontSize: 18,
        fontFamily: 'Cairo',
        color: AppColors.titleColor,
      ),
      centerTitle: false,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
          side: const BorderSide(color: AppColors.primaryColor),
        ),
        elevation: 0,
        padding: EdgeInsets.zero,
        minimumSize: const Size(80, 48),
      ),
    ),
    buttonTheme: const ButtonThemeData(
      textTheme: ButtonTextTheme.normal,
      minWidth: 88,
      height: 48,
      padding: EdgeInsets.only(top: 0, bottom: 0, left: 16, right: 16),
      buttonColor: AppColors.primaryColor,
      shape: RoundedRectangleBorder(
        side: BorderSide(
          color: AppColors.primaryColor,
          width: 0,
          style: BorderStyle.none,
        ),
        borderRadius: BorderRadius.all(Radius.circular(2.0)),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true, // Enable the fill color
      fillColor: AppColors.whiteColor, // Set the fill color
      border: OutlineInputBorder(
        // Optional: Customize the border
        borderRadius: BorderRadius.circular(4.0),
        borderSide: const BorderSide(color: AppColors.borderColor),
      ),
    ),
    fontFamily: 'Cairo',
    textTheme: const TextTheme(
      headlineSmall: TextStyle(
        color: AppColors.titleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headlineMedium: TextStyle(
        color: AppColors.titleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      headlineLarge: TextStyle(
        color: AppColors.titleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleSmall: TextStyle(
        color: AppColors.titleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodySmall: TextStyle(
        color: AppColors.titleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodyMedium: TextStyle(
        color: AppColors.titleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      bodyLarge: TextStyle(
        color: AppColors.titleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleMedium: TextStyle(
        color: AppColors.titleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
      titleLarge: TextStyle(
        color: AppColors.titleColor,
        fontWeight: FontWeight.w400,
        fontStyle: FontStyle.normal,
      ),
    ),
    dialogTheme: const DialogThemeData(backgroundColor: AppColors.whiteColor),
    // pageTransitionsTheme: const PageTransitionsTheme(
    //   builders: {
    //     TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    //     TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
    //   },
    // ),
    pageTransitionsTheme: const PageTransitionsTheme(
      builders: {
        TargetPlatform.android: SlideFadePageTransitionsBuilder(),
        TargetPlatform.iOS: SlideFadePageTransitionsBuilder(),
      },
    ),
  );
}

class SlideFadePageTransitionsBuilder extends PageTransitionsBuilder {
  const SlideFadePageTransitionsBuilder();

  @override
  Widget buildTransitions<T>(
    PageRoute<T> route,
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    const beginOffset = Offset(0.0, 0.1); // Slide from bottom slightly
    const endOffset = Offset.zero;

    final offsetAnimation = animation.drive(
      Tween<Offset>(
        begin: beginOffset,
        end: endOffset,
      ).chain(CurveTween(curve: Curves.easeOut)),
    );

    final fadeAnimation = animation.drive(CurveTween(curve: Curves.easeIn));

    return SlideTransition(
      position: offsetAnimation,
      child: FadeTransition(opacity: fadeAnimation, child: child),
    );
  }
}
