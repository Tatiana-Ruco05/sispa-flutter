import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  // IP SENA para WEB
  static const String baseUrl = "http://10.33.90.217:4000/api/auth/user-login";

  static Future<Map<String, dynamic>> login({
    required String correo,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse(baseUrl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "correo": correo.trim(),
              "password": password.trim(),
            }),
          )
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        print("token: ${data['accessToken'] ?? data['token']}"); // Debug token
        return {
          "ok": true,
          "token": data["accessToken"] ?? data["token"],
          "userId": data["userId"] ?? data["id"],
          "role": data["role"] ?? data["rol"],
        };
      }
      return {
        "ok": false,
        "message": data["message"] ?? "Error del servidor",
      };
    } catch (e) {
      return {"ok": false, "message": "Sin conexión. Verifica red SENA"};
    }
  }
}
