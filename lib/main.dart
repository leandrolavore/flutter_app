import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:habits/provider/habit_provider.dart';
import 'package:provider/provider.dart';
import 'app_router.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => HabitProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Habits App',
      routerConfig: router,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
    );
  }
}

class MainLayout extends StatelessWidget {
  final Widget child;

  const MainLayout({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final bool isMobile =
        defaultTargetPlatform == TargetPlatform.android ||
        defaultTargetPlatform == TargetPlatform.iOS;

    return Scaffold(
      appBar: AppBar(title: const Text('Habit tracker')),
      body: Row(
        children: [
          if (!isMobile)
            NavigationRail(
              labelType: NavigationRailLabelType.all,
              selectedIndex: _getSelectedIndex(context),
              onDestinationSelected: (index) {
                switch (index) {
                  case 0:
                    context.go('/');
                    break;
                  case 1:
                    context.go('/habits/manage-habits');
                    break;
                  case 2:
                    context.go('/habits/habit-details');
                    break;
                  case 3:
                    context.go('/settings');
                    break;
                }
              },
              destinations: const [
                NavigationRailDestination(
                  icon: Icon(Icons.home),
                  label: Text('Home'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.add),
                  label: Text('Manage Habits'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.add),
                  label: Text('Habit Details'),
                ),
                NavigationRailDestination(
                  icon: Icon(Icons.settings),
                  label: Text('Settings'),
                ),
              ],
            ),
          Expanded(child: child),
        ],
      ),
      bottomNavigationBar:
          isMobile
              ? BottomNavigationBar(
                currentIndex: _getSelectedIndex(context),
                onTap: (index) {
                  switch (index) {
                    case 0:
                      context.go('/');
                      break;
                    case 1:
                      context.go('/habits/manage-habits');
                      break;
                    case 2:
                      context.go('/habits/habit-details');
                      break;
                    case 3:
                      context.go('/settings');
                      break;
                  }
                },
                items: const <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: 'Manage Habits',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.add),
                    label: 'Habit Details',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.settings),
                    label: 'Settings',
                  ),
                ],
                selectedItemColor: Colors.amber[800],
                unselectedItemColor: Colors.amber,
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
              )
              : null,
    );
  }

  int _getSelectedIndex(BuildContext context) {
    final location = GoRouterState.of(context).uri.toString();

    if (location == '/') return 0;
    if (location.startsWith('/habits/manage-habits')) return 1;
    if (location.startsWith('/habits/habit-details')) return 2;
    if (location.startsWith('/settings')) return 3;

    return 0;
  }
}
