import 'package:flutter/material.dart';
import 'package:habits/provider/habit.dart';

class HabitProvider extends ChangeNotifier {
  final List<Habit> _habits = [
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
    Habit(name: 'asdf'),
  ];

  List<Habit> get habits => _habits;

  void addHabit(String habitName) {
    _habits.add(Habit(name: habitName));
    notifyListeners();
  }

  void removeHabit(String habitName) {
    int index = _habits.indexWhere((habit) => habit.name == habitName);

    if (index != -1) {
      _habits.removeAt(index);
      notifyListeners();
    }
  }
}
