import 'package:flutter/material.dart';
import 'app_theme.dart';

// parte de los icomos de la parte inferior
class MainScaffold extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  const MainScaffold({required this.child, required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (i) => Navigator.pushReplacementNamed(
          context,
          ['/home', '/schedule', '/notifications', '/profile'][i],
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.book), label: "Horario"),
          BottomNavigationBarItem(icon: Icon(Icons.notifications), label: "Notif"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Perfil"),
        ],
      ),
    );
  }
}