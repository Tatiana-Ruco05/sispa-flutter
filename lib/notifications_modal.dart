// lib/notifications_modal.dart
import 'package:flutter/material.dart';

class NotificationsModal extends StatelessWidget {
  const NotificationsModal({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.75,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        children: [
          const Padding(
            padding: EdgeInsets.all(16),
            child: Text("Notificaciones", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
          ),
          const Divider(height: 1),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: const [
                _Noti(tipo: "Alerta", mensaje: "Tienes entregables pendientes", hora: "8:20 AM", color: Colors.red),
                _Noti(tipo: "Alerta", mensaje: "Primer llamado reportate a tu instructor", hora: "8:20 AM", color: Colors.red),
                _Noti(tipo: "Bienestar", mensaje: "Actividad deportiva", hora: "10:00 AM", color: Colors.orange),
                _Noti(tipo: "Académico", mensaje: "Notas actualizadas", hora: "Ayer", color: Colors.green),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _Noti extends StatelessWidget {
  final String tipo, mensaje, hora;
  final Color color;
  const _Noti({required this.tipo, required this.mensaje, required this.hora, required this.color});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(tipo == "Alerta" ? Icons.warning : Icons.info, color: color),
      title: Text(tipo, style: TextStyle(color: color, fontWeight: FontWeight.bold)),
      subtitle: Text(mensaje),
      trailing: Text(hora, style: const TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }
}