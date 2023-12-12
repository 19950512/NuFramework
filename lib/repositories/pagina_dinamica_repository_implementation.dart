import 'dart:convert';

import 'package:nuframework/mocks/endpoints/boletos.dart';
import 'package:nuframework/mocks/endpoints/contato.dart';
import 'package:nuframework/mocks/endpoints/erro404.dart';
import 'package:nuframework/mocks/endpoints/resposta_payload.dart';
import 'package:nuframework/services/clientHTTP/clientHTTP.dart';
import 'package:nuframework/services/clientHTTP/request.dart';
import 'package:nuframework/services/clientHTTP/response.dart';

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
  Future<PaginaDinamicaModel> getPaginaDinamica(String endpoint) async {
    Response resposta =
        await clientHTTP.get(Request(endpoint: "dynamicpage/$endpoint"));

    return PaginaDinamicaModel.fromMap(jsonDecode(resposta.body));
  }
}
