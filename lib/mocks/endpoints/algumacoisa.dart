import 'resposta_payload.dart';

class AlgumaCoisaMock extends RespostaPayload {
  Map<String, dynamic> respostaAPI = {
    'title': 'Alguma coisa',
    'pop': 'home',
    'endpoint': 'alguma-coisa',
    'payload': [
      {
        'type': 'carousel',
        'direction': 'horizontal',
        'height': 100,
        'heightItem': 250,
        'items': [
          {
            'title': 'Titulo Carousel 1',
            'subtitle': 'Subtitulo Carousel 1',
            'image': 'https://picsum.photos/seed/1/200/300'
          },
        ]
      },
      {
        'type': 'text',
        'align': 'center',
        'text':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor',
      },
      {
        'type': 'space',
        'height': '20',
      },
      {
        'type': 'text',
        'align': 'center',
        'text':
            'Lorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor sit amet, consectetur adipiscing elitLorem ipsum dolor',
      },
      {
        'type': 'space',
        'height': '40',
      },
      {
        'type': 'carousel',
        'direction': 'horizontal',
        'height': 80,
        'heightItem': 300,
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
        ]
      },
      {
        'type': 'text-button',
        'label': 'Voltar HOME',
        'endpoint': 'home',
      }
    ]
  };

  @override
  Map<String, dynamic> getResposta() {
    return respostaAPI;
  }
}
