// ignore_for_file: public_member_api_docs, sort_constructors_first
class Request {
  String endpoint;
  String method;
  Map<String, dynamic> body;
  Request({
    required this.endpoint,
    this.method = 'GET',
    this.body = const {},
  });
}
