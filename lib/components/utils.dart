import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

import '../models/day_meals.dart';

generateData() async {
  final infoBox = await Hive.openBox('info');

  bool? firstTime = infoBox.get('first-time');

  if (firstTime ==null || firstTime==false) {
    final dayMealsBox = await Hive.openBox<DayMeals>('dayMeals');
    final List<DayMeals> list = [
      DayMeals(day: 'Sunday', meals: []),
      DayMeals(day: 'Monday', meals: []),
      DayMeals(day: 'Tuesday', meals: []),
      DayMeals(day: 'Wednesday', meals: []),
      DayMeals(day: 'Thursday', meals: []),
      DayMeals(day: 'Friday', meals: []),
      DayMeals(day: 'Saturday', meals: []),
    ];
    for (var element in list) {
      await dayMealsBox.put(element.day, element);
    }
    await infoBox.put('first-time', true);
  }
}

buildSnackBar({
  required BuildContext context,
  Icon icon = const Icon(
    Icons.error,
    color: Colors.white,
  ),
  required String title,
}) =>
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            icon,
            const SizedBox(width: 10),
            Expanded(
              child: Text(title),
            ),
          ],
        ),
      ),
    );
String? myValidateEmailFct(String? value) {
  const pattern =
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+";
  final regex = RegExp(pattern);

  if (value!.isEmpty) {
    return "Email Can't be empty ";
  } else if (!regex.hasMatch(value)) {
    return 'Enter a valid email address';
  }
  return null;
}

String? myValidatePwdFct(String? value) {
  const pattern = r'^(?=.*[A-Z])(?=.*?[0-9])(?=.*?[ @#\&*~]) .{8,}';
  final regex = RegExp(pattern);
  if (value!.isEmpty) {
    return "Password Can't be empty ";
  }
  // else if (!regex.hasMatch(value)) {
  //   return '''The password must be at least 8 characters and should contain at least one upper case, one digit, one special character among (@#&*~)''';
  // }
  return null;
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      width: 60,
      decoration: BoxDecoration(
          color: Colors.orange,
          borderRadius: BorderRadius.circular(10),
          shape: BoxShape.rectangle),
      child: const CircularProgressIndicator(
        color: Colors.white,
      ),
    );
  }
}
