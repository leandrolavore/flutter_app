import 'package:go_router/go_router.dart';
import 'package:habits/features/habits/manage_habit_screen.dart';
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
          builder:
              (context, state) =>
                  const ManageHabitScreen(title: "Manage Habits"),
          routes: [
            GoRoute(
              path: 'manage-habits',
              builder:
                  (context, state) =>
                      const ManageHabitScreen(title: "Manage Habits"),
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
