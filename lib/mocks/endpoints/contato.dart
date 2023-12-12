import 'resposta_payload.dart';

class ContatoMock extends RespostaPayload {
  Map<String, dynamic> respostaAPI = {
    'title': 'CONTATO PAGE',
    'endpoint': 'contato',
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
        'label': 'Contato',
        'endpoint': 'contato',
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
        'text': 'Contate-nos',
      },
      {
        'type': 'space',
        'height': '20',
      },
      {
        'type': 'formulario',
        'endpoint': 'contato-salvar-contato',
        'fields': [
          {
            'type': 'text',
            'label': 'Nome',
            'name': 'nome',
            'value': 'Java Lixo',
            'placeholder': 'Digite seu nome',
            'required': true,
          },
          {
            'type': 'text',
            'label': 'E-mail',
            'name': 'email',
            'placeholder': 'Digite seu e-mail',
            'required': true,
          },
          {
            'type': 'text',
            'label': 'Telefone',
            'name': 'telefone',
            'placeholder': 'Digite seu telefone',
            'required': true,
          },
          {
            'type': 'text',
            'label': 'Assunto',
            'name': 'assunto',
            'placeholder': 'Digite o assunto',
            'required': true,
          },
          {
            'type': 'textarea',
            'label': 'Mensagem',
            'name': 'mensagem',
            'placeholder': 'Digite sua mensagem',
            'required': true,
          },
        ],
      }
    ]
  };

  @override
  Map<String, dynamic> getResposta() {
    return respostaAPI;
  }
}
