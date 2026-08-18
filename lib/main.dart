import 'package:assignment9/screens/add_screen.dart';
import 'package:assignment9/screens/home_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorSchemeSeed: Color(0XFF5555d9),

        appBarTheme: AppBarTheme(
          backgroundColor: Color(0XFF5555d9),
          foregroundColor: Colors.white,
        ),
        scaffoldBackgroundColor: Color(0XFFfdfdfd),
      ),
      initialRoute: '/homescreen',
      routes: {
        '/homescreen':(context) => HomeScreen(),
        '/addscreen':(context) => AddScreen(),

      },
    );
  }
}
