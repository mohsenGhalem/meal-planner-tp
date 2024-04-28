import 'meal.dart';

import 'package:hive/hive.dart';
// note : part is very important to define to let the build runner do his work
// you will face an error don’t be afraid the build runner will fix this
part 'day_meals.g.dart';
// HiveType annotation for generate the type adapter
// hive type id is between 0–223 and it’s for indexing the object

@HiveType(typeId: 1)
class DayMeals {
  @HiveField(0)
  final String day;
  @HiveField(1)
  final List<Meal> meals;

  DayMeals({required this.day, required this.meals});
}
