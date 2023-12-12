import 'request.dart';
import 'response.dart';

abstract class ClientHTTP {
  Future<Response> get(Request request);
  Future<Response> post(Request request);
}
