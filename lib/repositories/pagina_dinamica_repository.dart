import '../models/pagina_dinamica_model.dart';

abstract class PaginaDinamicaRepository {
  Future<PaginaDinamicaModel> getPaginaDinamica(
    String endpoint,
    Map<String, dynamic>? data,
  );
}
