import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:tp02/components/utils.dart';

import 'firebase_options.dart';
import 'home_page.dart';
import 'models/day_meals.dart';
import 'models/meal.dart';
import 'screens/add_new_meal_page.dart';
import 'screens/details_page.dart';
import 'screens/forgot_password.dart';
import 'screens/login_page.dart';
import 'screens/signup_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(MealAdapter());
  Hive.registerAdapter(DayMealsAdapter());
  await generateData();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen(
      (event) {
        if (event == null) {
          debugPrint('User signout');
        }
        if (event != null) {
          debugPrint("User : ${event.uid}");
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Meal Planner',
      theme: ThemeData(
        appBarTheme: const AppBarTheme(
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
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignUpPage(),
        '/add_meal': (context) => const AddNewMealPage(),
        '/details': (context) => const DetailsPage(),
        '/forgot': (context) => const ForgotPasswordPage()
      },
    );
  }
}
