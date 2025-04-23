import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';


class ApiService {
  static final String baseUrl = _getBaseUrl();

  static String _getBaseUrl() {
    if (kIsWeb) {
      return 'http://localhost:4040/api';
    } else if (Platform.isAndroid) {
      return 'http://10.0.2.2:4040/api';
    } else {
      return 'http://localhost:4040/api';
    }
  }

  static Future<Map<String, dynamic>> registerUser({
    required String name,
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/register');

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'name': name,
          'email': email,
          'password': password,
        }),
      );

      final responseBody = jsonDecode(response.body);

      if (response.statusCode == 201) {
        return {
          'success': true,
          'message': responseBody['message'] ?? 'Cadastro realizado com sucesso.'
        };
      } else {
        return {
          'success': false,
          'error': responseBody['error'] ?? 'Erro desconhecido no servidor.'
        };
      }
    } catch (e) {
      return {
        'success': false,
        'error': 'Erro de conexão com o servidor: $e'
      };
    }
  }

  static Future<Map<String, dynamic>> loginUser({
  required String email,
  required String password,
}) async {
  final url = Uri.parse('$baseUrl/login');

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'email': email,
        'password': password,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return {
        'success': true,
        'token': data['token'],
        'user': data['user'],
        'message': data['message'],
      };
    } else {
      final body = jsonDecode(response.body);
      return {'success': false, 'error': body['error'] ?? 'Erro ao fazer login'};
    }
  } catch (e) {
    return {'success': false, 'error': 'Erro de conexão: $e'};
  }
}

}
