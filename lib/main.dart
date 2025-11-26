import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'home_screen.dart';
import 'schedule_screen.dart';
import 'notifications_screen.dart';
import 'profile_screen.dart';

void main() => runApp(const SispaApp());

class SispaApp extends StatelessWidget {
  const SispaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SISPA',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/home',
      routes: {
        '/home': (_) => const HomeScreen(),
        '/schedule': (_) => const ScheduleScreen(),
        '/notifications': (_) => const NotificationsScreen(),
        '/profile': (_) => const ProfileScreen(),
      },
    );
  }
}