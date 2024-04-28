import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tp02/components/my_text_button.dart';
import 'components/days_card.dart';
import 'models/day_meals.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

List<DayMeals> days_meals = [];

class _HomePageState extends State<HomePage> {
  final List<String> days = [
    "Sunday",
    "Monday",
    "Tuesday",
    "Wednesday",
    "Thursday",
    "Friday"
  ];
  final ScrollController _controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Page"),
        actions: [
          MyTextButton(
            label: 'Sign out',
            onPressed: () {
              FirebaseAuth.instance.signOut().then((value) =>
                  Navigator.of(context).pushReplacementNamed('/login'));
            },
          )
        ],
      ),
      body: ListView.builder(
        controller: _controller,
        itemCount: days.length,
        itemBuilder: (context, index) {
          return DayCard(
            day: days[index],
            dayAndItsMealsList: days_meals.firstWhere(
              (element) => element.day == days[index],
              orElse: () => DayMeals(
                day: days[index],
                meals: [],
              ),
            ),
          );
        },
      ),
    );
  }
}
