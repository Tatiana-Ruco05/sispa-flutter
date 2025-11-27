import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'main_scaffold.dart';
import 'app_theme.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 0,
      child: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Alerta SIN const problemático
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(16),
                decoration: const BoxDecoration(
                  color: Color(0xFFFFF3E0),
                  borderRadius: BorderRadius.all(Radius.circular(12)),
                  border: Border(left: BorderSide(color: AppTheme.accent, width: 5)),
                ),
                child: const Row(
                  children: [
                    Icon(Icons.warning_amber, color: AppTheme.accent),
                    SizedBox(width: 12),
                    Text("Alerta de entregables pendientes", style: TextStyle(fontWeight: FontWeight.w600)),
                  ],
                ),
              ),
              const SizedBox(height: 30),
              const Text("Progreso de materias", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 20),
              _progress("Negocios", 1.0, Colors.red.shade300),
              _progress("Ética", 0.5, AppTheme.accent),
              _progress("Algoritmia", 0.75, AppTheme.primary),
              _progress("Inglés", 0.42, Colors.orange.shade400),
              _progress("Derechos fundamentales", 1.0, AppTheme.primary),
              const SizedBox(height: 40),
              const Text("Entregables", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              const SizedBox(height: 16),
              _deliverable("Inglés", "Natalia R.", "verb to be", "Vence en 2 días", Colors.orange),
              _deliverable("Ética", "Natalia R.", "verb to be", "Entregado", Colors.green),
              _deliverable("Negocios", "Natalia R.", "verb to be", "Vence en 1 día", Colors.red),
              _deliverable("Ética", "Natalia R.", "verb to be", "En curso", Colors.blue),
            ],
          ),
        ),
      ),
    );
  }

  Widget _progress(String s, double p, Color c) => Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(children: [
          SizedBox(width: 130, child: Text(s)),
          Expanded(
            child: LinearPercentIndicator(
              percent: p,
              lineHeight: 14,
              backgroundColor: Colors.grey.shade300,
              progressColor: c,
              barRadius: const Radius.circular(10),
            ),
          ),
          const SizedBox(width: 10),
          Text("${(p * 100).toInt()}%"),
        ]),
      );

  Widget _deliverable(String sub, String prof, String tit, String est, Color col) => Card(
        margin: const EdgeInsets.symmetric(vertical: 6),
        child: ListTile(
          leading: CircleAvatar(backgroundColor: col, child: Text(sub[0], style: const TextStyle(color: Colors.white))),
          title: Text(tit),
          subtitle: Text("$prof • $est"),
          trailing: est.contains("Vence") ? const Icon(Icons.warning, color: Colors.orange) : null,
        ),
      );
}