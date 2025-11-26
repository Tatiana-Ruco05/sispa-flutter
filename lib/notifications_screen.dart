import 'package:flutter/material.dart';
import 'main_scaffold.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 2,
      child: SafeArea(
        child: ListView(padding: const EdgeInsets.all(20), children: [
          _noti("Alerta", "Tienes entregables pendientes", "8:20 AM\n 05/11/2022", Colors.red),
          _noti("Alerta", "Primer llamado reportate a tu instructor", "8:20 AM\n 05/11/2022", Colors.red),
          _noti("Bienestar", "Actividad deportiva", "10:00 AM\n 12/12/2022", Colors.orange),
          _noti("Académico", "Notas actualizadas", "8:20 AM\n 25/11/2022", Colors.green),
        ]),
      ),
    );
  }
  Widget _noti(String t, String m, String h, Color c) => Card(
        child: ListTile(leading: Icon(t == "Alerta" ? Icons.warning : Icons.info, color: c), title: Text(t, style: TextStyle(color: c, fontWeight: FontWeight.bold)), subtitle: Text(m), trailing: Text(h, style: const TextStyle(fontSize: 12))),
      );
}