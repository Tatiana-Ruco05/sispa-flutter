class UserProfile {
  final int idUsuario;
  final String nombre;
  final String apellido;
  final String correo;
  final String celular;
  final String tipoDocumento;
  final String documento;
  final DateTime fechaNacimiento;

  UserProfile({
    required this.idUsuario,
    required this.nombre,
    required this.apellido,
    required this.correo,
    required this.celular,
    required this.tipoDocumento,
    required this.documento,
    required this.fechaNacimiento,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      idUsuario: json['id_usuario'],
      nombre: json['nombre'],
      apellido: json['apellido'],
      correo: json['correo_personal'],
      celular: json['celular'],
      tipoDocumento: json['tipo_documento'],
      documento: json['documento'],
      fechaNacimiento: DateTime.parse(json['fecha_nacimiento']),
    );
  }
}
