import 'package:flutter/material.dart';
import 'package:nuframework/models/pagina_dinamica_model.dart';
import 'package:nuframework/repositories/pagina_dinamica_repository.dart';

class PaginaDinamica extends StatefulWidget {
  const PaginaDinamica({
    super.key,
  });

  @override
  State<PaginaDinamica> createState() => _PaginaDinamicaState();
}

class _PaginaDinamicaState extends State<PaginaDinamica> {
  Widget _bodyConteudo = Container();
  List<Widget> sessoes = [];
  List<Map<String, dynamic>> body = [];
  Text? title;
  Widget? leading;
  Widget? drawer;

  late PaginaDinamicaRepository paginaDinamicaRepository;

  getPagina(String endpoint) async {
    PaginaDinamicaModel paginaDinamica =
        await paginaDinamicaRepository.getPaginaDinamica(endpoint);

    processa(
      title: paginaDinamica.titulo,
      leading: paginaDinamica.leading,
      drawer: paginaDinamica.drawer,
      body: paginaDinamica.payload,
    );
  }

  @override
  void initState() {
    super.initState();

    paginaDinamicaRepository = PaginaDinamicaRepository();
    getPagina('home');
  }

  void processa({
    title = '',
    leading = null,
    drawer = null,
    required List<Map<String, dynamic>> body,
  }) {
    sessoes = [];

    this.drawer = null;
    if (drawer != null) {
      this.drawer = Drawer(
        child: ListView.builder(
          itemCount: drawer.length,
          itemBuilder: (context, index) {
            var item = drawer[index];

            if (item['type'] == 'title') {
              return DrawerHeader(
                child: Text(item['text']),
              );
            }

            if (item['type'] == 'text-button') {
              return ListTile(
                title: Text(item['label']),
                onTap: () async {
                  getPagina(item['endpoint']);

                  Navigator.pop(context);
                },
              );
            }

            return Container();
          },
        ),
      );
    }

    this.title = null;
    if (title.isNotEmpty) {
      this.title = Text(title);
    }

    this.leading = null;
    if (leading != null) {
      this.leading = IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => getPagina(leading),
      );
    }

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

        if (item['type'] == 'text-button') {
          sessoes.add(
            TextButton(
              onPressed: () async {
                getPagina(item['endpoint']);
              },
              child: Text(item['label']),
            ),
          );
        }
      }
    }

    _bodyConteudo = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: sessoes,
    );

    setState(() {});
  }

  Widget render() {
    return Scaffold(
      appBar: AppBar(
        title: title,
        leading: leading,
      ),
      drawer: drawer,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: _bodyConteudo,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return render();
  }
}
