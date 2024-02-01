import 'dart:convert';
import 'package:http/http.dart' as http;

class HttpRequest {
  final String baseUrl;

  HttpRequest(this.baseUrl);

  Future<Map<String, dynamic>> postJson(String endpoint, Map<String, dynamic> jsonData) async {
    final url = Uri.parse('$baseUrl/$endpoint');

    try {
      final response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(jsonData),
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      } else {
        throw Exception('Failed to load data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error: $e');
    }
  }

  Future performLogin({required Map<String, dynamic> jsonData, required String endpoint}) async {

    try {
      final result = await postJson(endpoint, jsonData);
      return result;
    } catch (e) {
      print('Error during login: $e');
    }
  }
}