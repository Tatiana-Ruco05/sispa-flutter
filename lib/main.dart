// lib/main.dart
import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'screens/login_screen.dart';
import 'screens/home_screen.dart';
import 'screens/schedule_screen.dart';
import 'screens/appointment_screen.dart';
import 'screens/profile_screen.dart';
import 'forgot_password_screen.dart';

void main() => runApp(const SispaApp());

class SispaApp extends StatelessWidget {
  const SispaApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SISPA',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (_) => const LoginScreen(),
        '/home': (_) => const HomeScreen(),
        '/schedule': (_) => const ScheduleScreen(),
        '/appointments': (_) => const AppointmentsScreen(),
        '/profile': (_) => const ProfileScreen(),
        '/forgot-password': (_) => const ForgotPasswordScreen(),
      },
    );
  }
}
