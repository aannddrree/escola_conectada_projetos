import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_config.dart';

class ApiService {
  Future<List<dynamic>> getList(String path) async {
    final response = await http.get(Uri.parse('${ApiConfig.baseUrl}$path'));
    if (response.statusCode == 200) return jsonDecode(response.body);
    throw Exception('Erro ao consultar $path');
  }
  Future<void> post(String path, Map<String,dynamic> data) async {
    final response = await http.post(Uri.parse('${ApiConfig.baseUrl}$path'), headers: {'Content-Type':'application/json'}, body: jsonEncode(data));
    if (response.statusCode < 200 || response.statusCode >= 300) throw Exception('Erro ao salvar em $path');
  }
}
