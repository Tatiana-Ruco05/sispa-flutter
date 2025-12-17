import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user_profile.dart';

import '../services/auth_service.dart';

class ProfileService {
  static const String baseUrl = 'http://10.39.203.217:4000/api/users';

  Future<UserProfile> getProfile(String? token, {int userId = 2}) async {
    final t = token ?? AuthService.currentToken;
    if (t == null) throw Exception('Token no disponible');

    final response = await http.get(
      Uri.parse('$baseUrl/$userId/profile'),
      headers: {
        'Authorization': 'Bearer $t',
        'Content-Type': 'application/json',
      },
    ).timeout(const Duration(seconds: 15));

    if (response.statusCode == 200) {
      return UserProfile.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener perfil: ${response.statusCode}');
    }
  }

  Future<bool> updateProfile({
    String? token,
    required int userId,
    required String celular,
  }) async {
    try {
      final t = token ?? AuthService.currentToken;
      if (t == null) return false;

      final response = await http
          .put(
            Uri.parse('$baseUrl/$userId/profile'),
            headers: {
              'Authorization': 'Bearer $t',
              'Content-Type': 'application/json',
            },
            body: jsonEncode({'celular': celular}),
          )
          .timeout(const Duration(seconds: 15));

      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }
}
