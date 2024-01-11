import 'dart:convert';

import 'package:nuframework/mocks/endpoints/boletos.dart';
import 'package:nuframework/mocks/endpoints/contato.dart';
import 'package:nuframework/mocks/endpoints/erro404.dart';
import 'package:nuframework/mocks/endpoints/resposta_payload.dart';
import 'package:nuframework/services/clientHTTP/clientHTTP.dart';
import 'package:nuframework/services/clientHTTP/request.dart';
import 'package:nuframework/services/clientHTTP/response.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../mocks/endpoints/algumacoisa.dart';
import '../mocks/endpoints/home.dart';
import '../models/pagina_dinamica_model.dart';
import 'pagina_dinamica_repository.dart';

class PaginaDinamicaRepositoryImplementation extends PaginaDinamicaRepository {
  late ClientHTTP clientHTTP;

  PaginaDinamicaRepositoryImplementation({
    required this.clientHTTP,
  });

  @override
  Future<PaginaDinamicaModel> getPaginaDinamica(
    String endpoint,
    Map<String, dynamic>? data,
  ) async {
    if (data == null) {
      Response resposta =
          await clientHTTP.get(Request(endpoint: "dynamicpage/$endpoint"));
      return PaginaDinamicaModel.fromMap(jsonDecode(resposta.body));
    }

    Response resposta = await clientHTTP.post(
      Request(
        endpoint: "dynamicpage/$endpoint",
        body: data,
      ),
    );

    Map<String, dynamic> response = jsonDecode(resposta.body);

    if (response.containsKey('accessToken')) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setString('accessToken', response['accessToken']);
    }

    return PaginaDinamicaModel.fromMap(response);
  }
}
