import 'package:flutter/material.dart';

import '../../../pagina_dinamica.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key, required this.title});

  final String title;

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  late Pagina pagina;

  @override
  void initState() {
    Map<String, dynamic> respostaAPI = {
      'title': 'Titulo Teste',
      'body': [
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
          'align': 'left',
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
      ]
    };

    pagina = Pagina(
      titulo: respostaAPI['title'],
      body: respostaAPI['body'],
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return pagina.render();
  }
}
