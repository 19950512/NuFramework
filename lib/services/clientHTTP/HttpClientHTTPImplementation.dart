import 'dart:convert';

import 'package:nuframework/services/clientHTTP/clientHTTP.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'request.dart';
import 'response.dart';
import 'package:http/http.dart' as http;

class HTTPClientHTTPImplementation implements ClientHTTP {
  final String baseURL;
  final Map<String, String> headers;
  final Map<String, dynamic> body;

  HTTPClientHTTPImplementation({
    required this.baseURL,
    required this.headers,
    required this.body,
  }) {}

  @override
  Future<Response> get(Request request) async {
    final url = Uri.parse('$baseURL${request.endpoint}');
    final httpRequest = await http.get(url);

    return Response(
      statusCode: httpRequest.statusCode,
      body: httpRequest.body,
    );
  }

  @override
  Future<Response> post(Request request) async {
    final url = Uri.parse('$baseURL${request.endpoint}');

    String accessToken = '';
    SharedPreferences.getInstance().then((prefs) {
      accessToken = prefs.getString('accessToken') ?? '';
    });

    Map<String, String> headers = {};
    if (accessToken.isNotEmpty) {
      headers = {
        'Authorization': 'Bearer $accessToken',
      };
    }

    try {
      // Fazendo a requisição GET
      var response = await http.post(
        url,
        body: request.body,
        headers: headers,
      );

      // Verifica se a resposta foi bem-sucedida (código de status 200)
      if (response.statusCode == 200) {
        return Response(
          statusCode: response.statusCode,
          body: response.body,
        );
      } else {
        return Response(
          statusCode: response.statusCode,
          body: response.body,
        );
      }
    } catch (error) {
      return Response(
        statusCode: 400,
        body: error.toString(),
      );
    }
  }
}
