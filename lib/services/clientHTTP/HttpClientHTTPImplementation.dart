import 'dart:convert';
import 'dart:io';

import 'package:nuframework/services/clientHTTP/clientHTTP.dart';

import 'request.dart';
import 'response.dart';

class HTTPClientHTTPImplementation implements ClientHTTP {
  final String baseURL;
  final Map<String, String> headers;
  final Map<String, dynamic> body;

  late HttpClient httpClient;

  HTTPClientHTTPImplementation({
    required this.baseURL,
    required this.headers,
    required this.body,
  }) {
    httpClient = HttpClient();
  }

  @override
  Future<Response> get(Request request) async {
    final url = Uri.parse('$baseURL${request.endpoint}');
    final httpRequest = await httpClient.getUrl(url);

    headers.forEach((key, value) {
      httpRequest.headers.add(key, value);
    });

    final httpResponse = await httpRequest.close();

    if (httpResponse.statusCode == HttpStatus.ok) {
      String responseBody = await httpResponse.transform(utf8.decoder).join();

      return Response(
        statusCode: httpResponse.statusCode,
        body: responseBody,
      );
    }

    return Response(
      statusCode: httpResponse.statusCode,
      body: '',
    );
  }

  @override
  Future<Response> post(Request request) async {
    final url = Uri.parse('$baseURL${request.endpoint}');

    final httpRequest = await httpClient.postUrl(url);
    headers.forEach((key, value) {
      httpRequest.headers.add(key, value);
    });

    if (body.isNotEmpty) {
      httpRequest.write(json.encode(body));
    }

    final httpResponse = await httpRequest.close();
    final responseBodyBytes =
        await httpResponse.expand((data) => data).toList();

    final responseBody = utf8.decode(responseBodyBytes);

    return Response(
      statusCode: httpResponse.statusCode,
      body: responseBody,
    );
  }
}
