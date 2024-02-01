import 'dart:convert';
import 'package:http/http.dart' as http;

class GetRequest {
  final String baseUrl;

  GetRequest(this.baseUrl);

  Future<Map<String, dynamic>> fetchData({required String endpoint}) async {
    final Uri url = Uri.parse('$baseUrl/$endpoint');

    final response = await http.get(
      url,
      headers: {
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      return json.decode(utf8.decode(response.bodyBytes));
    } else {
      throw Exception('Failed to fetch data. Status code: ${response.statusCode}');
    }
  }
}