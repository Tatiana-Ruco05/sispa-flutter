import 'dart:convert';
import 'package:http/http.dart' as http;

class AuthService {
  static const String baseUrl = "http://localHost:4000/api";
  static String? currentToken;

  static Future<Map<String, dynamic>> login({
    required String correo,
    required String password,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse("$baseUrl/user-login"),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({
              "documento": correo.trim(),
              "password": password.trim(),
            }),
          )
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        final token = data['accessToken'] ?? data['token'];
        currentToken = token;
        print("token: $token"); // Debug token
        return {
          "ok": true,
          "token": token,
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

  static Future<Map<String, dynamic>> sendPasswordReset({
    required String correo,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl/forgot-password'),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode({"correo": correo.trim()}),
          )
          .timeout(const Duration(seconds: 15));

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 || response.statusCode == 201) {
        return {"ok": true, "message": data["message"] ?? "Correo enviado"};
      }
      return {"ok": false, "message": data["message"] ?? "Error del servidor"};
    } catch (e) {
      return {"ok": false, "message": "Sin conexión. Verifica red SENA"};
    }
  }
}
