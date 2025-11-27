// lib/profile_screen.dart
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'main_scaffold.dart';
import 'app_theme.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;

  final TextEditingController _celularController = TextEditingController(text: "300 123 4567");
  final TextEditingController _direccionController = TextEditingController(text: "Calle 45 #12-34, Medellín");

  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      setState(() => _profileImage = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 3,
      child: SafeArea(
        child: SingleChildScrollView(   // ← ESTA LÍNEA ES LA QUE ARREGLA TODO
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Foto de perfil
              GestureDetector(
                onTap: _isEditing ? _pickImage : null,
                child: CircleAvatar(
                  radius: 70,
                  backgroundImage: _profileImage != null
                      ? FileImage(_profileImage!)
                      : const AssetImage("assets/images/profile_default.jpg") as ImageProvider,
                  child: _isEditing
                      ? const Icon(Icons.camera_alt, size: 40, color: Colors.white70)
                      : null,
                ),
              ),

              const SizedBox(height: 16),
              const Text(
                "Estefani Portilla",
                style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppTheme.primary),
              ),

              const SizedBox(height: 40),

              // Todos los datos
              _infoRow(Icons.badge, "Ficha", "3064975"),
              const SizedBox(height: 20),
              _infoRow(Icons.school, "Programa", "Análisis y Desarrollo de Software"),
              const SizedBox(height: 20),
              _infoRow(Icons.bloodtype, "Tipo de sangre", "O+"),
              const SizedBox(height: 20),
              _isEditing
                  ? _editableField(Icons.phone, "Número de celular", _celularController)
                  : _infoRow(Icons.phone, "Número de celular", _celularController.text),
              const SizedBox(height: 20),
              _isEditing
                  ? _editableField(Icons.home, "Dirección", _direccionController)
                  : _infoRow(Icons.home, "Dirección", _direccionController.text),
              const SizedBox(height: 40),

              // BOTÓN ABAJO DEL TODO
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    setState(() => _isEditing = !_isEditing);
                    if (!_isEditing) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("¡Cambios guardados!")),
                      );
                    }
                  },
                  icon: Icon(_isEditing ? Icons.save : Icons.edit),
                  label: Text(_isEditing ? "Guardar Cambios" : "Editar Perfil"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
                  ),
                ),
              ),

              const SizedBox(height: 20), // Espacio final para que no toque el botón de navegación
            ],
          ),
        ),
      ),
    );
  }

  Widget _infoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, color: AppTheme.primary, size: 28),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 4),
              Text(value, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _editableField(IconData icon, String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      keyboardType: label.contains("celular") ? TextInputType.phone : TextInputType.streetAddress,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppTheme.primary),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppTheme.primary, width: 1.5),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _celularController.dispose();
    _direccionController.dispose();
    super.dispose();
  }
}