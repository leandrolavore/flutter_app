import 'package:go_router/go_router.dart';
import 'package:habits/features/habits/add_habit_screen.dart';
import 'package:habits/features/habits/habit_details_screen.dart';
import 'package:habits/features/home/home_screen.dart';
import 'package:habits/features/settings/settings_screen.dart';
import 'package:habits/main.dart';

final GoRouter router = GoRouter(
  routes: [
    ShellRoute(
      builder: (context, state, child) {
        return MainLayout(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(title: "Home"),
        ),
        GoRoute(
          path: '/habits',
          builder: (context, state) => const AddHabitScreen(title: "Add Habit"),
          routes: [
            GoRoute(
              path: 'add-habit',
              builder:
                  (context, state) => const AddHabitScreen(title: "Add Habit"),
            ),
            GoRoute(
              path: 'habit-details',
              builder:
                  (context, state) =>
                      const HabitDetailsScreen(title: "Details"),
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: '/settings',
      builder: (context, state) => const SettingsScreen(title: "Settings"),
    ),
  ],
);
