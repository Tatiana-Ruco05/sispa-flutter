// lib/appointments_screen.dart
import 'package:flutter/material.dart';
import 'main_scaffold.dart';
import 'appointment_form_sheet.dart';
import 'app_theme.dart';

class AppointmentsScreen extends StatefulWidget {
  const AppointmentsScreen({super.key});

  @override
  State<AppointmentsScreen> createState() => _AppointmentsScreenState();
}

class _AppointmentsScreenState extends State<AppointmentsScreen> {
  // Lista de citas
  final List<Appointment> _citas = [];

  // Función para agregar una cita
  void _agregarCita(Appointment cita) {
    setState(() {
      _citas.add(cita);
    });
  }

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

              // Botón para agendar
              ElevatedButton.icon(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => AppointmentFormSheet(onAppointmentCreated: _agregarCita),
                  );
                },
                icon: const Icon(Icons.add),
                label: const Text("Agendar cita"),
                style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary),
              ),
              const SizedBox(height: 20),

              // Lista de citas
              Expanded(
                child: _citas.isEmpty
                    ? const Center(child: Text("No tienes citas agendadas"))
                    : ListView.builder(
                        itemCount: _citas.length,
                        itemBuilder: (context, i) {
                          final c = _citas[i];
                          return Card(
                            margin: const EdgeInsets.only(bottom: 12),
                            child: ListTile(
                              title: Text(c.instructor, style: const TextStyle(fontWeight: FontWeight.bold)),
                              subtitle: Text("${c.tipo} • ${c.modalidad}"),
                              trailing: Column(
                                mainAxisSize: MainAxisSize.min,
                                children: [Text(c.fecha), Text(c.hora)],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
