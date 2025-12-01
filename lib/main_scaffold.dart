// lib/main_scaffold.dart
import 'package:flutter/material.dart';
import 'app_theme.dart';
import 'notifications_modal.dart';

class MainScaffold extends StatelessWidget {
  final Widget child;
  final int currentIndex;
  const MainScaffold({required this.child, required this.currentIndex, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Row(
          children: [
            Text("sispa", style: TextStyle(color: AppTheme.primary, fontSize: 28, fontWeight: FontWeight.bold)),
            SizedBox(width: 4),
            Text(".", style: TextStyle(color: AppTheme.primary, fontSize: 28, fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          // Campana de notificaciones
          Stack(
            children: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined, size: 30),
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const NotificationsModal(),
                ),
              ),
              const Positioned(
                right: 8,
                top: 8,
                child: CircleAvatar(radius: 8, backgroundColor: Colors.red, child: Text("9", style: TextStyle(fontSize: 10, color: Colors.white))),
              ),
            ],
          ),
          // Botón para cerrar sesión
          IconButton(
            icon: const Icon(Icons.logout_outlined, size: 28),
            onPressed: () => Navigator.pushReplacementNamed(context, '/login'),
          ),
          const SizedBox(width: 10),
        ],
      ),
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppTheme.primary,
        unselectedItemColor: Colors.grey,
        onTap: (i) => Navigator.pushReplacementNamed(
          context,
          ['/home', '/schedule', '/appointments', '/profile'][i],
        ),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: "Inicio"),
          BottomNavigationBarItem(icon: Icon(Icons.book_outlined), label: "Horario"),
          BottomNavigationBarItem(icon: Icon(Icons.calendar_today_outlined), label: "Citas"),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: "Perfil"),
        ],
      ),
    );
  }
}