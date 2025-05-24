import 'package:pontos_de_interesse/features/points/domain/repositories/point_repository.dart';
import 'package:pontos_de_interesse/features/points/domain/entities/point_entity.dart';
import 'package:pontos_de_interesse/features/points/data/datasources/point_local_datasource.dart';
import 'package:pontos_de_interesse/features/points/data/datasources/location_datasource.dart';
import 'package:pontos_de_interesse/features/points/data/models/point_model.dart';
import 'dart:math';

/// Implementação concreta do repositório de pontos de interesse.
///
/// Faz a mediação entre a camada de domínio e as fontes de dados (local e de localização).
class PointRepositoryImpl implements PointRepository {
  /// Fonte de dados local para persistência dos pontos.
  final PointLocalDataSource localDataSource;

  /// Fonte de dados para obter a localização atual.
  final LocationDataSource locationDataSource;

  /// Construtor com injeção de dependências.
  PointRepositoryImpl({
    required this.localDataSource,
    required this.locationDataSource,
  });

  /// Adiciona um novo ponto convertendo a entidade de domínio para modelo
  /// e persistindo na fonte de dados local.
  @override
  Future<void> addPoint(PointEntity point) async {
    // Converte PointEntity para PointModel
    final model = PointModel.fromEntity(point);
    // Salva o modelo na fonte de dados local
    await localDataSource.savePoint(model);
  }

  /// Recupera todos os pontos armazenados localmente.
  ///
  /// Converte a lista de modelos para entidades, mantendo a separação entre as camadas.
  @override
  Future<List<PointEntity>> getPoints() async {
    // Obtém modelos da fonte de dados local
    final models = await localDataSource.getAllPoints();
    // Converte cada modelo em entidade e retorna
    return models.map((model) => model.toEntity()).toList();
  }

  /// Obtém a localização atual utilizando a fonte de dados de localização.
  ///
  /// Retorna um record contendo latitude e longitude.
  @override
  Future<({double latitude, double longitude})> getCurrentLocation() async {
    return await locationDataSource.getCurrentLocation();
  }

  /// Calcula a distância entre dois pontos geográficos utilizando a fórmula de Haversine.
  ///
  /// Parâmetros:
  /// - startLatitude, startLongitude: coordenadas de origem
  /// - endLatitude, endLongitude: coordenadas de destino
  ///
  /// Retorna a distância em metros.
  @override
  double calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    const double earthRadius = 6371000; // raio da Terra em metros

    // Diferença das latitudes e longitudes convertidas para radianos
    final dLat = _toRadians(endLatitude - startLatitude);
    final dLon = _toRadians(endLongitude - startLongitude);

    // Aplicação da fórmula de Haversine
    final a =
        sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(startLatitude)) *
            cos(_toRadians(endLatitude)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    final c = 2 * atan2(sqrt(a), sqrt(1 - a));
    final distance = earthRadius * c;

    return distance;
  }

  /// Função auxiliar que converte graus em radianos.
  double _toRadians(double degree) => degree * pi / 180;
}
