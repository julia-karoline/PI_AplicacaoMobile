import 'dart:convert';
import 'dart:io' show Platform;
import 'package:app_ecojourney/src/services/auth_api_service.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart'; 




class ApiService {
  static final String baseUrl = _getBaseUrl();
  static String? _token;

  static String _getBaseUrl() {
    if (kIsWeb) {
      return 'http://192.168.7.140:4040/api';
    } else if (Platform.isAndroid) {
      return 'http://192.168.7.140:4040/api';
    } else {
      return 'http://192.168.7.140:4040/api';
    }
  }

    static void setToken(String token) {
    _token = token;
  }
  

    static Map<String, String> _headers() {
    return {
      'Content-Type': 'application/json',
      if (_token != null) 'Authorization': 'Bearer $_token',
    };
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
  setToken(data['token']); 
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('user_name', data['user']['name']);
  return {
    'success': true,
    'token': data['token'],
    'user': data['user'],
    'message': data['message'],
  };
  } else {
      final body = jsonDecode(response.body);
      return {
        'success': false,
        'error': body['error'] ?? 'Erro ao fazer login'
      };
    }
  } catch (e) {
    return {'success': false, 'error': 'Erro de conexão: $e'};
  }
}

static Future<List<String>> fetchSuggestionsFromIA({
  required List<String> habits,
  required double carbonFootprint,
}) async {
  final token = await AuthApiService.getToken();

 final url = Uri.parse('$baseUrl/suggestions');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'habits': habits,
        'carbonFootprint': carbonFootprint,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return List<String>.from(data['suggestions']);
    } else {
      throw Exception('Erro ao obter sugestões');
    }
  } catch (e) {
    rethrow;
  }
}

static Future<List<Map<String, dynamic>>> fetchDailyGoals() async {
  final token = await AuthApiService.getToken();
  print('Token enviado para o backend: $token'); 

  final url = Uri.parse('$baseUrl/daily-goals');

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(data);
  } else {
    print('Erro do backend: ${response.body}');
    throw Exception('Erro ao carregar metas diárias');
  }
}


static Future<Map<String, dynamic>> createDailyGoal({
  required String title,
  required String description,
}) async {
   final token = await AuthApiService.getToken();
  final url = Uri.parse('$baseUrl/daily-goals');

  try {
    final response = await http.post(
      url,
      headers: {
        'Content-Type': 'application/json',
        if (token != null) 'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        'title': title,
        'description': description,
      }),
    );

    if (response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Erro ao criar meta: ${response.body}');
    }
  } catch (e) {
    print('Erro ao criar meta: $e');
    rethrow;
  }
}

static Future<void> updateDailyGoal({
  required int id,
  required String title,
  required String description,
  required bool completed,
}) async {
  final token = await AuthApiService.getToken();
  final url = Uri.parse('$baseUrl/daily-goals/$id');

  final response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'title': title,
      'description': description,
      'completed': completed,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Erro ao atualizar meta: ${response.body}');
  }
}

static Future<void> deleteDailyGoal(int id) async {
  final token = await AuthApiService.getToken();
  final url = Uri.parse('$baseUrl/daily-goals/$id');

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Erro ao excluir meta: ${response.body}');
  }
}

static Future<List<Map<String, dynamic>>> fetchHabits() async {
  final token = await AuthApiService.getToken();
  final url = Uri.parse('$baseUrl/habits');

  final response = await http.get(url, headers: {
    'Content-Type': 'application/json',
    if (token != null) 'Authorization': 'Bearer $token',
  });

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body);
    return List<Map<String, dynamic>>.from(data);
  } else {
    throw Exception('Erro ao buscar hábitos');
  }
}

static Future<Map<String, dynamic>> createHabit({
  required String title,
  required String description,
  required double value,
  required String unit,
}) async {
  final token = await AuthApiService.getToken();
  final url = Uri.parse('$baseUrl/habits');

  final response = await http.post(
    url,
    headers: {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'title': title,
      'description': description,
      'value': value,
      'unit': unit,
    }),
  );

  if (response.statusCode == 201) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Erro ao criar hábito: ${response.body}');
  }
}

static Future<void> updateHabit({
  required int id,
  required String title,
  required String description,
  required double value,
  required String unit,
}) async {
  final token = await AuthApiService.getToken();
  final url = Uri.parse('$baseUrl/habits/$id');

  final response = await http.put(
    url,
    headers: {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    },
    body: jsonEncode({
      'title': title,
      'description': description,
      'value': value,
      'unit': unit,
    }),
  );

  if (response.statusCode != 200) {
    throw Exception('Erro ao atualizar hábito');
  }
}

static Future<void> deleteHabit(int id) async {
  final token = await AuthApiService.getToken();
  final url = Uri.parse('$baseUrl/habits/$id');

  final response = await http.delete(
    url,
    headers: {
      'Content-Type': 'application/json',
      if (token != null) 'Authorization': 'Bearer $token',
    },
  );

  if (response.statusCode != 200) {
    throw Exception('Erro ao excluir hábito');
  }
}



}

