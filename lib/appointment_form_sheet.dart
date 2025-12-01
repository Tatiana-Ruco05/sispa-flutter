// lib/appointment_form_sheet.dart
import 'package:flutter/material.dart';
import 'app_theme.dart';

class Appointment {
  final String instructor;
  final String tipo;
  final String modalidad;
  final String fecha;
  final String hora;

  Appointment({
    required this.instructor,
    required this.tipo,
    required this.modalidad,
    required this.fecha,
    required this.hora,
  });
}

class AppointmentFormSheet extends StatefulWidget {
  final Function(Appointment) onAppointmentCreated;

  const AppointmentFormSheet({super.key, required this.onAppointmentCreated});

  @override
  State<AppointmentFormSheet> createState() => _AppointmentFormSheetState();
}

class _AppointmentFormSheetState extends State<AppointmentFormSheet> {
  final _tipoController = TextEditingController();
  final _fechaController = TextEditingController();
  final _horaController = TextEditingController();
  String? _instructor;
  String _modalidad = "Presencial";

  void _agendar() {
    if (_instructor == null || _fechaController.text.isEmpty || _horaController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Completa todos los campos")),
      );
      return;
    }

    widget.onAppointmentCreated(Appointment(
      instructor: _instructor!,
      tipo: _tipoController.text.isEmpty ? "General" : _tipoController.text,
      modalidad: _modalidad,
      fecha: _fechaController.text,
      hora: _horaController.text,
    ));

    Navigator.pop(context);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("¡Cita agendada!")),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.85,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      padding: const EdgeInsets.all(20),
      child: ListView(
        children: [
          const Text("Agendar cita", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 20),

          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: "Instructor", border: OutlineInputBorder()),
            items: ["Franco R.", "Johana Perez", "Natalia H."].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => _instructor = v,
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _tipoController,
            decoration: const InputDecoration(labelText: "Tipo de atención", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),

          DropdownButtonFormField<String>(
            value: _modalidad,
            decoration: const InputDecoration(labelText: "Modalidad", border: OutlineInputBorder()),
            items: ["Presencial", "Virtual"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (v) => _modalidad = v!,
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _fechaController,
            decoration: const InputDecoration(labelText: "Fecha (ej: 20/05/2025)", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 16),

          TextField(
            controller: _horaController,
            decoration: const InputDecoration(labelText: "Hora (ej: 10:00 AM)", border: OutlineInputBorder()),
          ),
          const SizedBox(height: 30),

          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primary,
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            onPressed: _agendar,
            child: const Text("Agendar cita", style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
