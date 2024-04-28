import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:tp02/components/my_button.dart';
import 'package:tp02/components/my_textfield.dart';
import 'package:tp02/home_page.dart';
import 'package:tp02/models/day_meals.dart';
import 'package:tp02/models/meal.dart';

class AddNewMealPage extends StatefulWidget {
  const AddNewMealPage({super.key});

  @override
  State<AddNewMealPage> createState() => _AddNewMealPageState();
}

class _AddNewMealPageState extends State<AddNewMealPage> {
  List<MyTextField> listOfMyTextField = [];
  List<TextEditingController> ingredientsControllers = [];
  TextEditingController mealName = TextEditingController();
  TextEditingController mealPath = TextEditingController();
  GlobalKey<FormState> myFormState = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final receivedDay = ModalRoute.of(context)?.settings.arguments as String;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add new Meal'),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
            child: Form(
              key: myFormState,
              child: Column(
                children: [
                  MyTextField(
                    hintText: 'Enter meal name',
                    prefixIcon: const Icon(Icons.restaurant),
                    controller: mealName,
                  ),
                  MyTextField(
                    hintText: 'Enter image path',
                    prefixIcon: const Icon(Icons.image),
                    controller: mealPath,
                  ),
                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              const Text('List of Ingredients'),
                              const Spacer(),
                              IconButton(
                                onPressed: () {
                                  listOfMyTextField.removeLast();
                                  ingredientsControllers.removeLast();
                                  setState(() {});
                                },
                                icon: const Icon(Icons.delete),
                              ),
                              IconButton(
                                onPressed: () {
                                  TextEditingController newController =
                                      TextEditingController();
                                  ingredientsControllers.add(newController);
                                  listOfMyTextField.add(
                                    MyTextField(
                                      hintText: 'Name of Ingredient',
                                      prefixIcon:
                                          const Icon(Icons.restaurant_menu),
                                      controller: newController,
                                      validator: (value) {
                                        if (value == null || value.isEmpty) {
                                          return 'you forgot to enter the ingredient name';
                                        }
                                        return null;
                                      },
                                    ),
                                  );
                                  setState(() {});
                                },
                                icon: const Icon(Icons.add),
                              ),
                            ],
                          ),
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listOfMyTextField.length,
                            itemBuilder: (context, index) =>
                                listOfMyTextField[index],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  MyButton(
                    label: 'Add The Meal',
                    onPressed: () => addMeal(receivedDay),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  addMeal(String receivedDay) {
    if (myFormState.currentState!.validate()) {
      List<String> ingredients = List.generate(ingredientsControllers.length,
          (index) => ingredientsControllers[index].text);

      Meal newMeal = Meal(
          name: mealName.text,
          path: mealPath.text,
          listOfIngredient: ingredients);
      Box dayMealsBox = Hive.box<DayMeals>('dayMeals');
      DayMeals dayMeals = dayMealsBox.get(receivedDay);
      dayMeals.meals.add(newMeal);

      dayMealsBox.put(receivedDay, dayMeals);
      Navigator.pop(context);
    }
  }
}
