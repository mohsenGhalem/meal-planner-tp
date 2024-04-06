import 'package:flutter/material.dart';
import 'package:tp02/screens/add_new_meal_page.dart';
import 'package:tp02/screens/details_page.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';
import 'home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Meal Planner',
      theme: ThemeData(
        appBarTheme:const AppBarTheme(
          backgroundColor: Colors.black,
          titleTextStyle: TextStyle(
            color: Colors.orange,
            fontSize: 17,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.orange),
        ),
      ),
      initialRoute: "/login",
      routes: {
        '/home':(context) => const HomePage(),
        '/login':(context)=> const LoginPage(),
        '/signup':(context) => const SignUpPage(),
        '/add_meal':(context)=> const AddNewMealPage(),
        '/details':(context) => const DetailsPage(),
      },
    );
  }
}
