import 'package:flutter/material.dart';

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
          children: [Text(widget.title ?? "")],
        ),
      ),
    );
  }
}
