// Importa a entidade de domínio PointEntity, que representa um ponto de interesse.
import 'package:pontos_de_interesse/features/points/domain/entities/point_entity.dart';

/// Abstração do repositório de pontos de interesse.
///
/// Define o contrato que deve ser seguido pelas implementações concretas,
/// garantindo a separação entre a lógica de domínio e a infraestrutura.
abstract class PointRepository {
  /// Adiciona um novo ponto de interesse ao repositório.
  ///
  /// Recebe um [PointEntity] e persiste de acordo com a implementação.
  Future<void> addPoint(PointEntity point);

  /// Recupera todos os pontos de interesse armazenados.
  ///
  /// Retorna uma lista de [PointEntity].
  Future<List<PointEntity>> getPoints();

  /// Obtém a localização atual do usuário.
  ///
  /// Retorna um objeto contendo `latitude` e `longitude`.
  /// O tipo retornado é um **record** do Dart 3: `({double latitude, double longitude})`.
  Future<({double latitude, double longitude})> getCurrentLocation();

  /// Calcula a distância entre dois pontos geográficos.
  ///
  /// [startLatitude] e [startLongitude] definem o ponto inicial.
  /// [endLatitude] e [endLongitude] definem o ponto final.
  ///
  /// Retorna a distância em metros como um [double].
  double calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  });
}
