import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/constants.dart';
import 'api_service.dart';

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

static Future<bool> addPoints(int value) async {
  final token = await getToken();
  final response = await http.post(
    Uri.parse('$baseUrl/user/add-points'),
    headers: {
      'Authorization': 'Bearer $token',
      'Content-Type': 'application/json',
    },
    body: jsonEncode({'points': value}),
  );

  return response.statusCode == 200;
}


  static Future<bool> redeemPoints(int points) async {
    try {
      final token = await getToken();
      final response = await http.post(
        Uri.parse('$baseUrl/redeem-points'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: jsonEncode({'points': points}),
      );

      return response.statusCode == 200;
    } catch (e) {
      print('Erro ao resgatar pontos: $e');
      return false;
    }
  }

  static Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  static Future<void> _saveUserName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_name', name);
  }

  static Future<String?> getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token');
  }

  static Future<String?> getUserName() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('user_name');
  }

  static Future<int?> getUserPoints() async {
    final token = await getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/user/points'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['points'] ?? 0;
    }
    return null;
  }
}
