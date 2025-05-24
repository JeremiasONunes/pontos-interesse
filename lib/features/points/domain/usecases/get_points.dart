// Importa a entidade que representa um Ponto de Interesse (PointEntity).
import '../entities/point_entity.dart';

// Importa a abstração do repositório, que fornece os métodos de acesso aos pontos.
import '../repositories/point_repository.dart';

/// Caso de uso (Use Case) responsável por obter todos os pontos de interesse salvos.
///
/// Esse caso de uso encapsula a lógica de recuperação de pontos, promovendo a separação
/// de responsabilidades e aderência à Clean Architecture.
class GetPoints {
  /// Dependência do repositório, responsável por fornecer os dados dos pontos.
  final PointRepository repository;

  /// Construtor que injeta a dependência do repositório.
  GetPoints(this.repository);

  /// Executa o caso de uso de recuperar todos os pontos de interesse.
  ///
  /// Retorna um [Future] que resolve para uma [List] de [PointEntity].
  ///
  /// Exemplo de retorno:
  /// [
  ///   PointEntity(name: 'Praça Central', description: 'Ponto turístico', latitude: -23.55, longitude: -46.63),
  ///   ...
  /// ]
  Future<List<PointEntity>> call() async {
    // Delegação ao repositório para recuperar os pontos.
    return await repository.getPoints();
  }
}
