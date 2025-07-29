import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:nextroom8_animation/view/home_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        hideKeyboard(context);
      },
      child: MediaQuery(
        data: MediaQuery.of(
          context,
        ).copyWith(textScaler: TextScaler.linear(1.07)),
        child: GetMaterialApp(
          debugShowCheckedModeBanner: false,
          useInheritedMediaQuery: true,
          theme: ThemeData(
            scaffoldBackgroundColor: Colors.white,
            useMaterial3: false,
            splashFactory: NoSplash.splashFactory,
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
            textTheme: TextTheme(
              displayLarge: TextStyle(fontWeight: FontWeight.normal),
              displayMedium: TextStyle(fontWeight: FontWeight.normal),
              displaySmall: TextStyle(fontWeight: FontWeight.normal),
              headlineLarge: TextStyle(fontWeight: FontWeight.normal),
              headlineMedium: TextStyle(fontWeight: FontWeight.normal),
              headlineSmall: TextStyle(fontWeight: FontWeight.normal),
              titleLarge: TextStyle(fontWeight: FontWeight.normal),
              titleMedium: TextStyle(fontWeight: FontWeight.normal),
              titleSmall: TextStyle(fontWeight: FontWeight.normal),
              bodyLarge: TextStyle(fontWeight: FontWeight.normal),
              bodyMedium: TextStyle(fontWeight: FontWeight.normal),
              bodySmall: TextStyle(fontWeight: FontWeight.normal),
              labelLarge: TextStyle(fontWeight: FontWeight.normal),
              labelMedium: TextStyle(fontWeight: FontWeight.normal),
              labelSmall: TextStyle(fontWeight: FontWeight.normal),
            ),
          ),
          title: 'NextRoom8',
          home: HomeScreen(),
        ),
      ),
    );
  }

  void hideKeyboard(context) {
    FocusScopeNode currentFocus = FocusScope.of(context);
    if (!currentFocus.hasPrimaryFocus && currentFocus.focusedChild != null) {
      FocusManager.instance.primaryFocus?.unfocus();
    }
  }
}
