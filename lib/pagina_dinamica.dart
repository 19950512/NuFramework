import 'package:flutter/material.dart';
import 'package:nuframework/models/pagina_dinamica_model.dart';
import 'package:nuframework/repositories/pagina_dinamica_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  String paginaAtual = 'home';
  String accessToken = '';

  late PaginaDinamicaRepository paginaDinamicaRepository;

  getPagina({
    required String endpoint,
    Map<String, dynamic>? data,
  }) async {
    SharedPreferences.getInstance().then((prefs) {
      accessToken = prefs.getString('accessToken') ?? '';
    });

    print(accessToken);
    PaginaDinamicaModel paginaDinamica =
        await paginaDinamicaRepository.getPaginaDinamica(endpoint, data);

    processa(
      paginaAtual: paginaDinamica.endpoint,
      title: paginaDinamica.titulo,
      leading: paginaDinamica.leading,
      drawer: paginaDinamica.drawer,
      body: paginaDinamica.payload,
    );
  }

  @override
  void initState() {
    super.initState();
    Map<String, String> headerRequest = {};

    headerRequest['Content-Type'] = 'application/json';

    if (accessToken.isNotEmpty) {
      headerRequest['Authorization'] = 'Bearer $accessToken';
    }

    paginaDinamicaRepository = PaginaDinamicaRepositoryImplementation(
      clientHTTP: HTTPClientHTTPImplementation(
        baseURL: 'http://192.168.18.10:8052/',
        headers: headerRequest,
        body: {},
      ),
    );
    getPagina(
      endpoint: paginaAtual,
    );
  }

  void processa({
    paginaAtual = 'home',
    title = '',
    leading = null,
    drawer = null,
    required List body,
  }) {
    sessoes = [];

    this.controllersTextList = [];

    this.paginaAtual = paginaAtual;

    this.drawer = null;
    if (drawer != null) {
      if (drawer.length > 0) {
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
                    getPagina(
                      endpoint: item['endpoint'],
                    );

                    Navigator.pop(context);
                  },
                );
              }

              return Container();
            },
          ),
        );
      }
    }

    this.title = null;
    if (title.isNotEmpty) {
      this.title = Text(title);
    }

    this.leading = null;
    if (leading != null) {
      this.leading = IconButton(
        icon: const Icon(Icons.arrow_back, color: Colors.black),
        onPressed: () => getPagina(endpoint: leading),
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

        if (item['type'] == 'text') {
          Alignment alignSubTitle = Alignment.center;
          if (item['align'] == 'left') {
            alignSubTitle = Alignment.centerLeft;
          } else if (item['align'] == 'right') {
            alignSubTitle = Alignment.centerRight;
          }

          TextStyle styleText = const TextStyle(fontSize: 14);
          if (item['textType'] == 'title') {
            styleText = const TextStyle(fontSize: 21);
          }
          if (item['textType'] == 'subtitle') {
            styleText = const TextStyle(fontSize: 16);
          }
          if (item['textType'] == 'paragraph') {
            styleText = const TextStyle(fontSize: 14);
          }

          sessoes.add(
            Align(
              alignment: alignSubTitle,
              child: Text(
                item['text'],
                style: styleText,
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
                print('Requisitando a pagina: ${item['endpoint']}');
                getPagina(
                  endpoint: item['endpoint'],
                );
              },
              child: Text(item['label']),
            ),
          );
        }

        if (item['type'] == 'formulario') {
          sessoes.add(MyForm(item, getPagina: getPagina));
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
      body: RefreshIndicator(
        onRefresh: () async {
          print('Refreshando..');
          print('Pagina atual: $paginaAtual');
          getPagina(
            endpoint: paginaAtual,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: _bodyConteudo,
          ),
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

  late Function? getPagina;

  MyForm(this.item, {this.getPagina, super.key});

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
                  'type': field['fieldType'] ?? '',
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
                  obscureText: controller['type'] == 'password',
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

                    // os dados do formulario
                    Map<String, dynamic> data = {};
                    for (var item in controllersTextList) {
                      data[item['label']] = item['controller']!.text;
                    }

                    getPagina!(
                      endpoint: item['endpoint'],
                      data: data,
                    );

                    print('Enviando dados: $data');
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
