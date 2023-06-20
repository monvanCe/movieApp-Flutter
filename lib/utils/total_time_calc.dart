// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'dart:math';

Map<String, int> calculateTimes(List array) {
  double sum = 0;

  array.forEach((element) {
    double randomNum = Random().nextDouble() * (1.8 - 1.3) + 1.3;
    sum += randomNum;
  });

  int totalHours = sum.toInt();
  int totalDays = totalHours ~/ 24;
  int totalMonths = totalDays ~/ 30;

  int remainingHours = totalHours % 24;

  return {'months': totalMonths, 'days': totalDays, 'hours': remainingHours};
}
