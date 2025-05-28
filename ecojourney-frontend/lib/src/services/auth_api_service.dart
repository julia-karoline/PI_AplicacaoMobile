import 'dart:convert';
import 'package:app_ecojourney/src/services/api_service.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';

class AuthApiService {
  static const String baseUrl = Constants.baseUrl;

  static Future<Map<String, dynamic>> login(String email, String password) async {
  final url = Uri.parse('$baseUrl/login');
  final response = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode({'email': email, 'password': password}),
  );

  final data = jsonDecode(response.body);

  if (response.statusCode == 200 && data.containsKey('token')) {
    await _saveToken(data['token']); 
    await _saveUserName(data['user']['name']);
    ApiService.setToken(data['token']); 
    return {
      'success': true,
      'token': data['token'],
      'user': data['user'],
      'message': data['message'] ?? 'Login realizado com sucesso',
    };
  } else {
    return {
      'success': false,
      'error': data['error'] ?? 'Erro ao fazer login',
    };
  }
}

  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<void> _saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name');
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('auth_token');
    await prefs.remove('user_name');
  }

  static Future<int?> getUserPoints() async {
   final token = await AuthApiService.getToken();

  final response = await http.get(
    Uri.parse('$baseUrl/user/points'),
    headers: {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return data['points'] as int?;
  } else {
    print('Erro ao buscar pontos: ${response.body}');
    return null;
  }
}
}
