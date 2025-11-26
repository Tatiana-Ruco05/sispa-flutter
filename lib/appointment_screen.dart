import 'package:flutter/material.dart';

class AppointmentScreen extends StatelessWidget {
  const AppointmentScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Agendar cita")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          const TextField(decoration: InputDecoration(labelText: "Nombre aprendiz")),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(labelText: "Especialidad")),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(labelText: "Instructor"),
            items: ["Franco R.", "Alex J", "Natalia H"].map((e) => DropdownMenuItem(value: e, child: Text(e))).toList(),
            onChanged: (_) {},
          ),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(labelText: "Tipo de atención")),
          const SizedBox(height: 16),
          const TextField(decoration: InputDecoration(labelText: "Fecha deseada (dd/mm/aaaa)")),
          const SizedBox(height: 30),
          ElevatedButton(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text("¡Cita agendada!")));
              Navigator.pop(context);
            },
            child: const Text("Agendar cita"),
          ),
        ]),
      ),
    );
  }
}