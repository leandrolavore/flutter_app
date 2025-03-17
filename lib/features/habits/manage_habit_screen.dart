import 'package:flutter/material.dart';
import 'package:habits/provider/habit_provider.dart';
import 'package:provider/provider.dart';

class ManageHabitScreen extends StatefulWidget {
  const ManageHabitScreen({super.key, this.title});

  final String? title;
  @override
  State<ManageHabitScreen> createState() => _AddHabitScreenState();
}

class _AddHabitScreenState extends State<ManageHabitScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _habitController = TextEditingController();

  void _saveHabit() {
    if (_formKey.currentState!.validate()) {
      final habitName = _habitController.text.trim();

      if (habitName.isNotEmpty) {
        Provider.of<HabitProvider>(context, listen: false).addHabit(habitName);
        _habitController.clear();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(widget.title ?? ""),
            Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: TextFormField(
                          controller: _habitController,
                          decoration: const InputDecoration(
                            icon: Icon(Icons.person),
                            hintText: 'Add a new habit',
                            labelText: 'Habit',
                          ),
                          validator: (String? value) {
                            if (value == null || value.isEmpty) {
                              return "Habit can't be empty";
                            }

                            return null;
                          },
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.add),
                        onPressed: _saveHabit,
                      ),
                    ],
                  ),
                  SizedBox(height: 16),
                  Consumer<HabitProvider>(
                    builder: (context, habitProvider, child) {
                      return SingleChildScrollView(
                        child: Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          alignment: WrapAlignment.start,
                          children:
                              habitProvider.habits.map((habit) {
                                return Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.3,
                                  padding: EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[100],
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: Text(
                                      habit.name,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                );
                              }).toList(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
