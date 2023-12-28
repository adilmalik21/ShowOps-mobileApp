import 'dart:convert';
import 'package:http/http.dart' as http;

class NetworkHandler {
  final String url;

  NetworkHandler(this.url);

  Future<dynamic> post(Map<String, String> body) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode(body),
    );

    return json.decode(response.body);
  }
}
