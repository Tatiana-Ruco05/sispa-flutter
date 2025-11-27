// lib/appointments_screen.dart
import 'package:flutter/material.dart';
import 'main_scaffold.dart';
import 'appointment_form_sheet.dart';
import 'app_theme.dart';

class AppointmentsScreen extends StatelessWidget {
  const AppointmentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 2,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Mis citas", style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: () => showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  backgroundColor: Colors.transparent,
                  builder: (_) => const AppointmentFormSheet(),
                ),
                icon: const Icon(Icons.add),
                label: const Text("Agendar cita", style: TextStyle(fontSize: 16)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView(
                  children: const [
                    _AppointmentCard(instructor: "Franco Reyna", tipo: "Instructor", modalidad: "Presencial", fecha: "12/04/2025", hora: "10:00 AM"),
                    _AppointmentCard(instructor: "Natalia H.", tipo: "Psicología", modalidad: "Virtual", fecha: "15/04/2025", hora: "02:00 PM"),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AppointmentCard extends StatelessWidget {
  final String instructor, tipo, modalidad, fecha, hora;
  const _AppointmentCard({required this.instructor, required this.tipo, required this.modalidad, required this.fecha, required this.hora});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        title: Text(instructor, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
        subtitle: Text("$tipo • $modalidad"),
        trailing: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(fecha, style: const TextStyle(fontWeight: FontWeight.w600)),
            Text(hora, style: const TextStyle(color: Colors.grey)),
          ],
        ),
      ),
    );
  }
}