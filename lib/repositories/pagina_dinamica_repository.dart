import 'package:nuframework/mocks/endpoints/boletos.dart';
import 'package:nuframework/mocks/endpoints/erro404.dart';
import 'package:nuframework/mocks/endpoints/resposta_payload.dart';

import '../mocks/endpoints/algumacoisa.dart';
import '../mocks/endpoints/home.dart';
import '../models/pagina_dinamica_model.dart';

class PaginaDinamicaRepository {
  Future<PaginaDinamicaModel> getPaginaDinamica(String endpoint) async {
    if (endpoint == 'home') {
      RespostaPayload respostaPayload = HomeMock();
      return PaginaDinamicaModel.fromMap(respostaPayload.getResposta());
    }

    if (endpoint == 'alguma-coisa') {
      RespostaPayload respostaPayload = AlgumaCoisaMock();
      return PaginaDinamicaModel.fromMap(respostaPayload.getResposta());
    }
    if (endpoint == 'tela-de-boletos') {
      RespostaPayload respostaPayload = BoletosMock();
      return PaginaDinamicaModel.fromMap(respostaPayload.getResposta());
    }

    RespostaPayload respostaPayload = Erro404Mock();
    return PaginaDinamicaModel.fromMap(respostaPayload.getResposta());
  }
}
