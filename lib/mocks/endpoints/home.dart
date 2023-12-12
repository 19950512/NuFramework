import 'resposta_payload.dart';

class HomeMock extends RespostaPayload {
  Map<String, dynamic> respostaAPI = {
    'title': 'HOME INICIO PAGE',
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
        'direction': 'horizontal',
        'height': 100,
        'heightItem': 250,
        'items': [
          {
            'title': 'PHP > Java',
            'subtitle': 'Subtitulo Carousel 1',
            'image': 'https://picsum.photos/seed/1/200/300'
          },
          {
            'title': 'Titulo Carousel 2',
            'subtitle': 'Subtitulo Carousel 2',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Titulo Carousel 3',
            'subtitle': 'Subtitulo Carousel 3',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
        ]
      },
      {
        'type': 'title',
        'align': 'center',
        'text': 'Promoções do dia',
      },
      {
        'type': 'subtitle',
        'align': 'left',
        'text': 'Veja as promoções do dia de hoje e aproveite!',
      },
      {
        'type': 'text',
        'align': 'center',
        'text':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor',
      },
      {
        'type': 'divider',
        'height': '20',
      },
      {
        'type': 'space',
        'height': '40',
      },
      {
        'type': 'divider',
        'height': '20',
      },
      {
        'type': 'text',
        'align': 'center',
        'text':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor',
      },
      {
        'type': 'divider',
        'height': '20',
      },
      {
        'type': 'carousel',
        'direction': 'vertical',
        'height': 300,
        'heightItem': 100,
        'items': [
          {
            'title': 'Titulo Carousel 1',
            'subtitle': 'Subtitulo Carousel 1',
            'image': 'https://picsum.photos/seed/1/200/300'
          },
          {
            'title': 'Titulo Carousel 2',
            'subtitle': 'Subtitulo Carousel 2',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Titulo Carousel 3',
            'subtitle': 'Subtitulo Carousel 3',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Titulo Carousel 4',
            'subtitle': 'Subtitulo Carousel 4',
            'image': 'https://picsum.photos/seed/1/200/300'
          },
          {
            'title': 'Titulo Carousel 5',
            'subtitle': 'Subtitulo Carousel 5',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
          {
            'title': 'Titulo Carousel 6',
            'subtitle': 'Subtitulo Carousel 6',
            'image': 'https://picsum.photos/seed/2/200/300'
          },
        ]
      },
      {
        'type': 'divider',
        'height': '20',
      },
      {
        'type': 'text-button',
        'label': 'Alguma coisa',
        'endpoint': 'alguma-coisa',
      },
      {
        'type': 'divider',
        'height': '20',
      },
      {
        'type': 'title',
        'align': 'center',
        'text': 'Promoções do dia',
      },
    ]
  };

  @override
  Map<String, dynamic> getResposta() {
    return respostaAPI;
  }
}
