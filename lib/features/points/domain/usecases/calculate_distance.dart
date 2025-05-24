// Importa a abstração do repositório, que fornece o método de cálculo de distância.
import 'package:pontos_de_interesse/features/points/domain/repositories/point_repository.dart';

/// Caso de uso (Use Case) responsável por calcular a distância entre dois pontos geográficos.
///
/// Utiliza a Clean Architecture para manter a lógica de domínio desacoplada das implementações concretas.
class CalculateDistance {
  /// Dependência do repositório, que contém a lógica de cálculo da distância.
  final PointRepository repository;

  /// Construtor que recebe a implementação de [PointRepository].
  CalculateDistance(this.repository);

  /// Executa o cálculo de distância entre dois pontos.
  ///
  /// Parâmetros obrigatórios:
  /// - [startLatitude]: latitude do ponto inicial.
  /// - [startLongitude]: longitude do ponto inicial.
  /// - [endLatitude]: latitude do ponto final.
  /// - [endLongitude]: longitude do ponto final.
  ///
  /// Retorna a distância em metros como um [double].
  double call({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    // Delegação do cálculo para o repositório.
    return repository.calculateDistance(
      startLatitude: startLatitude,
      startLongitude: startLongitude,
      endLatitude: endLatitude,
      endLongitude: endLongitude,
    );
  }
}
