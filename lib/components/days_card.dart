import 'package:flutter/material.dart';

import '../models/day_meals.dart';

class DayCard extends StatelessWidget {
  final String day;
  final DayMeals dayAndItsMealsList;
  const DayCard({
    super.key,
    required this.day,
    required this.dayAndItsMealsList,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.maxFinite,
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          color: Colors.orange,
          border: Border.all(),
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        children: [
          Align(
            child: Text(
              day,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const SizedBox(height: 15),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              IconButton(
                onPressed: () {
                  
                  Navigator.of(context).pushNamed(
                  '/details',
                  arguments: dayAndItsMealsList,
                );
                },
                icon: const Icon(
                  Icons.visibility,
                  color: Colors.black,
                ),
              ),
              const SizedBox(width: 10),
              IconButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  '/add_meal',
                  arguments: day,
                ),
                icon: const Icon(
                  Icons.add,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
