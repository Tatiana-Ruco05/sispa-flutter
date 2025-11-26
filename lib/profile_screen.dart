import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart'; // <-- Agrega esta dependencia en pubspec.yaml
import 'dart:io';
import 'main_scaffold.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;

  // Controladores para los campos de texto
  final TextEditingController _fichaController = TextEditingController(text: "20241A123");
  final TextEditingController _programaController = TextEditingController(text: "Análisis y Desarrollo de Software");
  final TextEditingController _sangreController = TextEditingController(text: "O+");
  final TextEditingController _direccionController = TextEditingController(text: "Calle 45 #12-34, Medellín");

  // Foto de perfil (inicia con una foto bonita por defecto)
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  // Función para seleccionar foto desde galería
  Future<void> _pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );

    if (pickedFile != null) {
      setState(() {
        _profileImage = File(pickedFile.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 3,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const SizedBox(height: 20),

              // Foto de perfil clickeable (solo en modo edición)
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

              const SizedBox(height: 12),
              const Text(
                "Estefani Portilla",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),

              // Botón Editar / Guardar
              ElevatedButton.icon(
                onPressed: () {
                  setState(() {
                    _isEditing = !_isEditing;
                  });
                },
                icon: Icon(_isEditing ? Icons.save : Icons.edit),
                label: Text(_isEditing ? "Guardar Cambios" : "Editar Perfil"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: _isEditing ? Colors.green : Colors.blue,
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                ),
              ),

              const SizedBox(height: 30),

              // Campos de texto (habilitados solo en edición)
              _buildTextField("Ficha", _fichaController),
              const SizedBox(height: 12),
              _buildTextField("Programa", _programaController),
              const SizedBox(height: 12),
              _buildTextField("Tipo de sangre", _sangreController),
              const SizedBox(height: 12),
              _buildTextField("Dirección", _direccionController),
            ],
          ),
        ),
      ),
    );
  }

  // Widget reutilizable para los campos
  Widget _buildTextField(String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      enabled: _isEditing,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: Colors.grey),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _fichaController.dispose();
    _programaController.dispose();
    _sangreController.dispose();
    _direccionController.dispose();
    super.dispose();
  }
}