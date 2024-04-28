import 'package:hive/hive.dart';
// note : part is very important to define to let the build runner do his work
// you will face an error don’t be afraid the build runner will fix this
part 'meal.g.dart';
// HiveType annotation for generate the type adapter
// hive type id is between 0–223 and it’s for indexing the object

@HiveType(typeId: 0)
class Meal {
  @HiveField(0)
  final String? id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final String path;
  @HiveField(3)
  final List<String> listOfIngredient;

  Meal({
    this.id,
    required this.name,
    required this.path,
    required this.listOfIngredient,
  });
}
