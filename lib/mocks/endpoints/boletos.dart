import 'resposta_payload.dart';

class BoletosMock extends RespostaPayload {
  Map<String, dynamic> respostaAPI = {
    'title': 'BOLETOS PAGE',
    'endpoint': 'home',
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
        'type': 'carousel',
        'direction': 'vertical',
        'height': 'infinity',
        'heightItem': 100,
        'items': [
          {
            'title': 'Boleto 1',
            'subtitle': 'Subtitulo Carousel 1',
            'image': 'https://picsum.photos/seed/1/200/300'
          },
          {
            'title': 'Boleto 2',
            'subtitle': 'Subtitulo Carousel 2',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Boleto 3',
            'subtitle': 'Subtitulo Carousel 3',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Boleto 4',
            'subtitle': 'Subtitulo Carousel 4',
            'image': 'https://picsum.photos/seed/1/200/300'
          },
          {
            'title': 'Boleto 5',
            'subtitle': 'Subtitulo Carousel 5',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Boleto 5',
            'subtitle': 'Subtitulo Carousel 5',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Boleto 5',
            'subtitle': 'Subtitulo Carousel 5',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Boleto 3',
            'subtitle': 'Subtitulo Carousel 3',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Boleto 4',
            'subtitle': 'Subtitulo Carousel 4',
            'image': 'https://picsum.photos/seed/1/200/300'
          },
          {
            'title': 'Boleto 5',
            'subtitle': 'Subtitulo Carousel 5',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Boleto 5',
            'subtitle': 'Subtitulo Carousel 5',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Boleto 5',
            'subtitle': 'Subtitulo Carousel 5',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Boleto 5',
            'subtitle': 'Subtitulo Carousel 5',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Boleto 5',
            'subtitle': 'Subtitulo Carousel 5',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Boleto 5',
            'subtitle': 'Subtitulo Carousel 5',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Boleto 6',
            'subtitle': 'Subtitulo Carousel 6',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
        ]
      },
    ]
  };

  @override
  Map<String, dynamic> getResposta() {
    return respostaAPI;
  }
}
