import 'package:flutter/material.dart';
import 'package:nuframework/models/pagina_dinamica_model.dart';
import 'package:nuframework/repositories/pagina_dinamica_repository.dart';

import 'repositories/pagina_dinamica_repository_implementation.dart';
import 'services/clientHTTP/HttpClientHTTPImplementation.dart';

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
  List body = [];
  List<TextEditingController?> controllersTextList = [];
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

    paginaDinamicaRepository = PaginaDinamicaRepositoryImplementation(
      clientHTTP: HTTPClientHTTPImplementation(
        baseURL: 'http://192.168.1.106:8052/',
        headers: {},
        body: {},
      ),
    );
    getPagina('home');
  }

  void processa({
    title = '',
    leading = null,
    drawer = null,
    required List body,
  }) {
    sessoes = [];

    this.controllersTextList = [];

    this.drawer = null;
    if (drawer != null) {
      this.drawer = Drawer(
        child: ListView.builder(
          itemCount: drawer.length,
          itemBuilder: (context, index) {
            var item = drawer[index];

            if (item['type'] == 'title') {
              return DrawerHeader(
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image: NetworkImage(
                            'https://avatars.githubusercontent.com/u/36517599',
                          ),
                        ),
                      ),
                    ),
                    Text('Matheus Maydana')
                  ],
                ),
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

          double heightCarousel = MediaQuery.of(context).size.height;
          if (carousel['height'] is String) {
            if (carousel['height'] == 'infinity') {
              heightCarousel = MediaQuery.of(context).size.height;
            } else {
              heightCarousel = double.parse(carousel['height']);
            }
          } else {
            if (carousel['height'] is int || carousel['height'] is double) {
              if (carousel['height'] != null && carousel['height'] > 0) {
                heightCarousel = double.parse(carousel['height']);
              }
            }
          }

          sessoes.add(
            SizedBox(
              height: heightCarousel,
              child: ListView.builder(
                scrollDirection: carousel['direction'] == 'vertical'
                    ? Axis.vertical
                    : Axis.horizontal,
                itemCount: carousel['items'].length,
                itemBuilder: (context, index) {
                  var item = carousel['items'][index];

                  return SizedBox(
                    width: double.parse(carousel['heightItem']),
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

        if (item['type'] == 'divider') {
          sessoes.add(
            Divider(
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

        if (item['type'] == 'formulario') {
          sessoes.add(MyForm(item));
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
        child: SingleChildScrollView(
          child: _bodyConteudo,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return render();
  }
}

class MyForm extends StatelessWidget {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final Map<String, dynamic> item;

  MyForm(this.item, {super.key});

  List<Widget> sessoes = [];

  List<Map<String, dynamic>> controllersTextList = [];

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Builder(
        builder: (BuildContext context) {
          if (item['fields'] != null) {
            for (var field in item['fields']) {
              controllersTextList.add(
                {
                  'label': field['label'],
                  'placeholder': field['placeholder'] ?? '',
                  'controller': TextEditingController(
                    text: field['value'] ?? '',
                  ),
                },
              );
            }
          }

          if (controllersTextList.isNotEmpty) {
            for (var controller in controllersTextList) {
              sessoes.add(
                TextFormField(
                  controller: controller['controller'],
                  decoration: InputDecoration(
                    border: const OutlineInputBorder(),
                    hintText: controller['placeholder'] ?? '',
                    labelText: controller['label'] ?? '',
                  ),
                  validator: (String? value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor, preencha o campo';
                    }

                    Map<String, dynamic> data = {};
                    for (var item in controllersTextList) {
                      data[item['label']] = item['controller']!.text;
                    }

                    print(data);

                    return null;
                  },
                ),
              );
              sessoes.add(const SizedBox(height: 10));
            }

            sessoes.add(
              TextButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Processando dados'),
                      ),
                    );
                  }
                },
                child: const Text('Enviar'),
              ),
            );
          }

          return Column(
            children: sessoes,
          );
        },
      ),
    );
  }
}
