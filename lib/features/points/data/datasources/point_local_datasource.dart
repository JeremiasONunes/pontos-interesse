import 'dart:convert';
import 'package:pontos_de_interesse/features/points/data/models/point_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Abstração da fonte de dados local para pontos.
/// Define as operações que podem ser realizadas: salvar e recuperar pontos.
abstract class PointLocalDataSource {
  /// Salva um ponto localmente.
  Future<void> savePoint(PointModel point);

  /// Recupera todos os pontos salvos localmente.
  Future<List<PointModel>> getAllPoints();
}

/// Chave utilizada para armazenar os pontos no SharedPreferences.
const String cachedPointsKey = 'CACHED_POINTS';

/// Implementação concreta da fonte de dados local utilizando SharedPreferences.
class PointLocalDataSourceImpl implements PointLocalDataSource {
  /// Instância do SharedPreferences injetada via construtor.
  final SharedPreferences sharedPreferences;

  /// Construtor com injeção de dependência.
  PointLocalDataSourceImpl({required this.sharedPreferences});

  /// Salva um ponto no armazenamento local.
  ///
  /// O método primeiro recupera todos os pontos armazenados,
  /// adiciona o novo ponto à lista, converte todos os pontos
  /// para um JSON, e salva no SharedPreferences.
  @override
  Future<void> savePoint(PointModel point) async {
    // Recupera os pontos atuais.
    final List<PointModel> currentPoints = await getAllPoints();

    // Adiciona o novo ponto à lista.
    currentPoints.add(point);

    // Converte a lista de pontos para uma lista de mapas (JSON).
    final List<Map<String, dynamic>> jsonList =
        currentPoints.map((e) => e.toMap()).toList();

    // Codifica a lista de mapas para uma string JSON.
    final String jsonString = json.encode(jsonList);

    // Salva a string JSON no SharedPreferences.
    await sharedPreferences.setString(cachedPointsKey, jsonString);
  }

  /// Recupera todos os pontos armazenados localmente.
  ///
  /// Se não houver pontos armazenados, retorna uma lista vazia.
  @override
  Future<List<PointModel>> getAllPoints() async {
    // Tenta obter a string JSON armazenada.
    final jsonString = sharedPreferences.getString(cachedPointsKey);

    // Se a string existir, decodifica e converte para objetos PointModel.
    if (jsonString != null) {
      final List<dynamic> decoded = json.decode(jsonString);
      return decoded
          .map((item) => PointModel.fromMap(item as Map<String, dynamic>))
          .toList();
    } else {
      // Caso não exista nenhum dado armazenado, retorna uma lista vazia.
      return [];
    }
  }
}
