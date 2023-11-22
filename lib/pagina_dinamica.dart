import 'package:flutter/material.dart';

import 'carousel_item.dart';

final class Pagina {
  String titulo;
  List<CarouselItem> _carousel = [];
  List<Map<String, dynamic>> body = [];

  Widget _bodyConteudo = Container();
  List<Widget> sessoes = [];

  Pagina({
    required this.titulo,
    this.body = const [],
  }) {
    if (body.isNotEmpty) {
      for (var item in body) {
        if (item['type'] == 'carousel') {
          var carousel = item;

          sessoes.add(
            SizedBox(
              height: carousel['height'].toDouble(),
              child: ListView.builder(
                scrollDirection: carousel['direction'] == 'vertical'
                    ? Axis.vertical
                    : Axis.horizontal,
                itemCount: carousel['items'].length,
                itemBuilder: (context, index) {
                  var item = carousel['items'][index];

                  return SizedBox(
                    width: carousel['heightItem'].toDouble(),
                    child: ListTile(
                      title: Text(item['title']),
                      subtitle: Text(item['subtitle']),
                      leading: const FlutterLogo(),
                    ),
                  );
                },
              ),
            ),
          );
        }

        if (item['type'] == 'title') {
          Alignment alignTitle = Alignment.center;
          if (item['align'] == 'left') {
            alignTitle = Alignment.centerLeft;
          } else if (item['align'] == 'right') {
            alignTitle = Alignment.centerRight;
          }
          sessoes.add(
            Align(
              alignment: alignTitle,
              child: Text(
                item['text'],
                style: const TextStyle(fontSize: 21),
              ),
            ),
          );
        }

        if (item['type'] == 'subtitle') {
          Alignment alignSubTitle = Alignment.center;
          if (item['align'] == 'left') {
            alignSubTitle = Alignment.centerLeft;
          } else if (item['align'] == 'right') {
            alignSubTitle = Alignment.centerRight;
          }
          sessoes.add(
            Align(
              alignment: alignSubTitle,
              child: Text(
                item['text'],
                style: const TextStyle(fontSize: 16),
              ),
            ),
          );
        }

        if (item['type'] == 'text') {
          Alignment alignSubTitle = Alignment.center;
          if (item['align'] == 'left') {
            alignSubTitle = Alignment.centerLeft;
          } else if (item['align'] == 'right') {
            alignSubTitle = Alignment.centerRight;
          }
          sessoes.add(
            Align(
              alignment: alignSubTitle,
              child: Text(
                item['text'],
                style: const TextStyle(fontSize: 14),
              ),
            ),
          );
        }

        if (item['type'] == 'space') {
          sessoes.add(
            SizedBox(
              height: int.parse(item['height']).toDouble(),
            ),
          );
        }
      }
    }

    /*sessoes.add(
      TextButton(
        onPressed: () {
          print('Alguma coisa');
        },
        child: const Text('Alguma coisa'),
      ),
    );*/

    _bodyConteudo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sessoes,
    );
  }

  Widget render() {
    return Scaffold(
      appBar: AppBar(
        title: Text(titulo),
      ),
      body: _bodyConteudo,
    );
  }
}
