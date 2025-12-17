import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import '../widgets/main_scaffold.dart';
import '../app_theme.dart';
import '../services/profile_service.dart';
import '../models/user_profile.dart';

class ProfileScreen extends StatefulWidget {
  final String? token;

  const ProfileScreen({super.key, this.token});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool _isEditing = false;
  File? _profileImage;
  final ImagePicker _picker = ImagePicker();

  late Future<UserProfile> _profileFuture;

  final TextEditingController _celularController = TextEditingController();
  final TextEditingController _direccionController =
      TextEditingController(text: "Dirección no registrada");

  @override
  void initState() {
    super.initState();
    _profileFuture = ProfileService().getProfile(widget.token).then((user) {
      _celularController.text = user.celular;
      return user;
    });
  }

  Future<void> _pickImage() async {
    final picked =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 80);
    if (picked != null) {
      setState(() => _profileImage = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      currentIndex: 3,
      child: SafeArea(
        child: FutureBuilder<UserProfile>(
          future: _profileFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final user = snapshot.data!;

            return SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  const SizedBox(height: 20),

                  // FOTO
                  GestureDetector(
                    onTap: _isEditing ? _pickImage : null,
                    child: CircleAvatar(
                      radius: 70,
                      backgroundImage: _profileImage != null
                          ? FileImage(_profileImage!) as ImageProvider
                          : const AssetImage("assets/images/profile_default.jpg"),
                      child: _isEditing
                          ? const Icon(Icons.camera_alt,
                              size: 40, color: Colors.white70)
                          : null,
                    ),
                  ),

                  const SizedBox(height: 16),

                  Text(
                    '${user.nombre} ${user.apellido}',
                    style: const TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.primary,
                    ),
                  ),

                  const SizedBox(height: 40),

                  _infoRow(Icons.email, "Correo", user.correo),
                  const SizedBox(height: 20),
                  _infoRow(Icons.badge, "Documento",
                      '${user.tipoDocumento} ${user.documento}'),
                  const SizedBox(height: 20),

                  _isEditing
                      ? _editableField(
                          Icons.phone, "Número de celular", _celularController)
                      : _infoRow(
                          Icons.phone, "Número de celular", user.celular),

                  const SizedBox(height: 20),

                  _infoRow(
                    Icons.cake,
                    "Fecha de nacimiento",
                    user.fechaNacimiento
                        .toLocal()
                        .toString()
                        .split(' ')[0],
                  ),

                  const SizedBox(height: 40),

                  // BOTÓN
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () {
                        setState(() => _isEditing = !_isEditing);
                        if (!_isEditing) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                content: Text("¡Cambios guardados!")),
                          );
                        }
                      },
                      icon: Icon(_isEditing ? Icons.save : Icons.edit),
                      label: Text(
                          _isEditing ? "Guardar Cambios" : "Editar Perfil"),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primary,
                        padding: const EdgeInsets.symmetric(vertical: 16),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(30)),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
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
              Text(label,
                  style: const TextStyle(color: Colors.grey, fontSize: 14)),
              const SizedBox(height: 4),
              Text(value,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _editableField(
      IconData icon, String label, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: AppTheme.primary),
        labelText: label,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
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
