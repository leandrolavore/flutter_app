import 'package:flutter/material.dart';
import 'package:habits/provider/habit_provider.dart';
import 'package:provider/provider.dart';

class HabitDetailsScreen extends StatefulWidget {
  const HabitDetailsScreen({super.key, this.title});

  final String? title;

  @override
  State<HabitDetailsScreen> createState() => _HabitDetailScreenState();
}

class _HabitDetailScreenState extends State<HabitDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title ?? ""),
            Expanded(
              child: Consumer<HabitProvider>(
                builder: (context, habitProvider, child) {
                  return GridView.builder(
                    padding: const EdgeInsets.all(8.0),
                    gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                      maxCrossAxisExtent: 200, // Maximum width per tile
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      childAspectRatio: 1.0, // Adjust according to your design
                    ),
                    itemCount: habitProvider.habits.length,
                    itemBuilder: (context, index) {
                      final habit = habitProvider.habits[index];

                      return ListTile(title: Text(habit.name));
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
