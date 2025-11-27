// lib/appointment_form_sheet.dart
import 'package:flutter/material.dart';
import 'app_theme.dart';

class AppointmentFormSheet extends StatelessWidget {
  const AppointmentFormSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: DraggableScrollableSheet(
        expand: false,
        initialChildSize: 0.9,
        maxChildSize: 0.95,
        builder: (_, controller) => Container(
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            controller: controller,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Center(
                  child: SizedBox(width: 50, height: 5, child: DecoratedBox(decoration: BoxDecoration(color: Colors.grey, borderRadius: BorderRadius.all(Radius.circular(10))))),
                ),
                const SizedBox(height: 20),
                const Text("Agendar cita", style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                const SizedBox(height: 25),

                const TextField(decoration: InputDecoration(labelText: "Nombre aprendiz", filled: true, fillColor: Color(0xFFF5F5F5), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none))),
                const SizedBox(height: 16),
                const TextField(decoration: InputDecoration(labelText: "Especialidad", filled: true, fillColor: Color(0xFFF5F5F5), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none))),
                const SizedBox(height: 16),
                DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: "Instructor", filled: true, fillColor: Color(0xFFF5F5F5), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none)),
                  items: ["Franco R.", "Johana Perz", "Natalia H.", "Carolina"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
                  onChanged: (_) {},
                ),
                const SizedBox(height: 16),
                const TextField(decoration: InputDecoration(labelText: "Tipo de atención", filled: true, fillColor: Color(0xFFF5F5F5), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none))),
                const SizedBox(height: 16),
                const TextField(decoration: InputDecoration(labelText: "Fecha deseada (dd/mm/aaaa)", filled: true, fillColor: Color(0xFFF5F5F5), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none))),
                const SizedBox(height: 16),
                const TextField(decoration: InputDecoration(labelText: "Hora", filled: true, fillColor: Color(0xFFF5F5F5), border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12)), borderSide: BorderSide.none))),
                const SizedBox(height: 30),

                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(backgroundColor: AppTheme.primary, padding: const EdgeInsets.symmetric(vertical: 16), shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12))),
                    onPressed: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("¡Cita agendada con éxito!")));
                    },
                    child: const Text("Agendar cita", style: TextStyle(fontSize: 16)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}