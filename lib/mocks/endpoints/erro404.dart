import 'resposta_payload.dart';

class Erro404Mock extends RespostaPayload {
  Map<String, dynamic> respostaAPI = {
    'title': '',
    'endpoint': 'erro404',
    'drawer': [
      {
        'type': 'title',
        'text': 'Menu',
      },
      {
        'type': 'text-button',
        'label': 'Home',
        'endpoint': 'home',
      },
      {
        'type': 'text-button',
        'label': 'Boletos',
        'endpoint': 'tela-de-boletos',
      },
      {
        'type': 'text-button',
        'label': 'Alguma pagina que nao existe',
        'endpoint': 'tela-de-boletos---',
      },
    ],
    'payload': [
      {
        'type': 'title',
        'align': 'center',
        'text': 'Erro - 404',
      },
      {
        'type': 'subtitle',
        'align': 'center',
        'text': 'Página não encontrada',
      },
      {
        'type': 'text-button',
        'label': 'Voltar ao início',
        'endpoint': 'home',
      },
    ]
  };

  @override
  Map<String, dynamic> getResposta() {
    return respostaAPI;
  }
}
