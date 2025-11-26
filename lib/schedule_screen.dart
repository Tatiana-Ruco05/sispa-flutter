import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'main_scaffold.dart';
import 'appointment_screen.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});
  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  CalendarFormat _format = CalendarFormat.month;
  DateTime _focused = DateTime.now();
  DateTime? _selected;

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 1,
      child: SafeArea(
        child: Column(children: [
          Container(
            margin: const EdgeInsets.all(20),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
            child: TableCalendar(
              firstDay: DateTime.utc(2020, 1, 1),
              lastDay: DateTime.utc(2030, 12, 31),
              focusedDay: _focused,
              calendarFormat: _format,
              selectedDayPredicate: (day) => isSameDay(_selected, day),
              onDaySelected: (s, f) => setState(() => {_selected = s, _focused = f}),
              onFormatChanged: (f) => setState(() => _format = f),
              headerStyle: const HeaderStyle(formatButtonVisible: false, titleCentered: true),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ElevatedButton.icon(
              onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const AppointmentScreen())),
              icon: const Icon(Icons.add),
              label: const Text("Agendar cita"),
            ),
          ),
          Expanded(
            child: ListView(padding: const EdgeInsets.all(20), children: [
              _class("07:00 am", "Derechos fundamentales", "Johana Perz"),
              _class("08:00 am", "Derechos fundamentales", "Johana Perz"),
              _class("09:20 am", "Derechos fundamentales", "Johana Perz"),
              _class("10:00 am", "Derechos fundamentales", "Johana Perz"),
              _class("11:00 am", "Derechos fundamentales", "Johana Perz"),
              _class("01:00 pm", "Ética", "Carolina"),
            ]),
          ),
        ]),
      ),
    );
  }

  Widget _class(String h, String m, String p) => Card(child: ListTile(leading: Text(h, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)), title: Text(m), subtitle: Text(p)));
}