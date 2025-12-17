// lib/schedule_screen.dart
import 'package:flutter/material.dart';
import '../widgets/main_scaffold.dart';
import '../app_theme.dart';

class ScheduleScreen extends StatelessWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 1,
      child: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: const [
            // ====================== LUNES ======================
            _DayHeader(day: "Lunes"),
            _ClassCard(hora: "7:00 AM", materia: "Derechos fundamentales", profesor: "Johana Perz"),
            _ClassCard(hora: "8:00 AM", materia: "Derechos fundamentales", profesor: "Johana Perz"),
            _ClassCard(hora: "9:20 AM", materia: "Derechos fundamentales", profesor: "Johana Perz"),
            _ClassCard(hora: "10:40 AM", materia: "Derechos fundamentales", profesor: "Johana Perz"),
            _ClassCard(hora: "12:00 PM", materia: "Derechos fundamentales", profesor: "Johana Perz"),
            _ClassCard(hora: "1:00 PM", materia: "Derechos fundamentales", profesor: "Johana Perz"),

            SizedBox(height: 30),

            // ====================== MARTES ======================
            _DayHeader(day: "Martes"),
            _ClassCard(hora: "7:00 AM", materia: "Negocios internacionales", profesor: "Franco Reyna"),
            _ClassCard(hora: "8:00 AM", materia: "Negocios internacionales", profesor: "Franco Reyna"),
            _ClassCard(hora: "9:20 AM", materia: "Negocios internacionales", profesor: "Franco Reyna"),
            _ClassCard(hora: "10:40 AM", materia: "Ética y valores", profesor: "Carolina Guzmán"),
            _ClassCard(hora: "11:20 AM", materia: "Ética y valores", profesor: "Carolina Guzmán"),

            SizedBox(height: 30),

            // ====================== MIÉRCOLES ======================
            _DayHeader(day: "Miércoles"),
            _ClassCard(hora: "7:00 AM", materia: "Algoritmia y lógica", profesor: "Andrés Felipe"),
            _ClassCard(hora: "8:00 AM", materia: "Algoritmia y lógica", profesor: "Andrés Felipe"),
            _ClassCard(hora: "9:20 AM", materia: "Base de datos", profesor: "Luis Fernando"),
            _ClassCard(hora: "10:40 AM", materia: "Base de datos", profesor: "Luis Fernando"),
            _ClassCard(hora: "12:00 PM", materia: "Inglés técnico", profesor: "Natalia Henao"),
            _ClassCard(hora: "1:00 PM", materia: "Inglés técnico", profesor: "Natalia Henao"),

            SizedBox(height: 30),

            // ====================== JUEVES ======================
            _DayHeader(day: "Jueves"),
            _ClassCard(hora: "7:00 AM", materia: "Programación web", profesor: "Diego Alzate"),
            _ClassCard(hora: "8:00 AM", materia: "Programación web", profesor: "Diego Alzate"),
            _ClassCard(hora: "9:20 AM", materia: "Programación web", profesor: "Diego Alzate"),
            _ClassCard(hora: "10:40 AM", materia: "Desarrollo móvil", profesor: "Camila Restrepo"),
            _ClassCard(hora: "11:20 AM", materia: "Desarrollo móvil", profesor: "Camila Restrepo"),

            SizedBox(height: 30),

            // ====================== VIERNES ======================
            _DayHeader(day: "Viernes"),
            _ClassCard(hora: "7:00 AM", materia: "Testing y calidad", profesor: "María José"),
            _ClassCard(hora: "8:00 AM", materia: "Testing y calidad", profesor: "María José"),
            _ClassCard(hora: "9:20 AM", materia: "Proyecto integrador", profesor: "Todos los instructores"),
            _ClassCard(hora: "10:40 AM", materia: "Proyecto integrador", profesor: "Todos los instructores"),
            _ClassCard(hora: "12:00 PM", materia: "Formación complementaria", profesor: "Bienestar"),
          ],
        ),
      ),
    );
  }
}

// Título del día (Lunes, Martes...)
class _DayHeader extends StatelessWidget {
  final String day;
  const _DayHeader({required this.day});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 12),
      child: Text(
        day,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: AppTheme.primary,
        ),
      ),
    );
  }
}

// Tarjeta de cada clase
class _ClassCard extends StatelessWidget {
  final String hora, materia, profesor;
  const _ClassCard({required this.hora, required this.materia, required this.profesor});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        leading: Text(
          hora,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 15,
            color: AppTheme.primary,
          ),
        ),
        title: Text(materia, style: const TextStyle(fontWeight: FontWeight.w600)),
        subtitle: Text(profesor),
      ),
    );
  }
}