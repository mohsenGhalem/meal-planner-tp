import 'package:flutter/material.dart';
import 'package:tp02/models/day_meals.dart';

import '../models/meal.dart';

class DetailsPage extends StatelessWidget {
  const DetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    dynamic receivedData = ModalRoute.of(context)?.settings.arguments;
    List<Meal> myListofMeals = [];
    if (receivedData.runtimeType == DayMeals) {
      receivedData = receivedData as DayMeals;
      myListofMeals = receivedData.meals;
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Details Page'),
      ),
      body: myListofMeals.isEmpty
          ? const Center(
              child: Text('No meals found'),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(8),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
              ),
              itemCount: myListofMeals.length,
              itemBuilder: (context, index) {
                return Card(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset(myListofMeals[index].path,
                            fit: BoxFit.cover),
                        Text(myListofMeals[index].name),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}
