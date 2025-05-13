import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../utils/constants.dart';

class UserApiService {
  static const String baseUrl = Constants.baseUrl;

  static Future<Map<String, dynamic>> registerUser(User user) async {
    final url = Uri.parse('$baseUrl/register');
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(user.toJson()),
    );

    final body = jsonDecode(response.body);
    if (response.statusCode == 201) {
      return {'success': true, 'message': body['message']};
    } else {
      return {'success': false, 'error': body['error'] ?? 'Erro desconhecido'};
    }
  }
}
