// Importa a entidade PointEntity, que representa o modelo de domínio.
import '../entities/point_entity.dart';

// Importa a abstração do repositório, que será utilizada para persistência de dados.
import '../repositories/point_repository.dart';

/// Caso de uso (Use Case) responsável por adicionar um ponto de interesse.
///
/// Segue os princípios da Clean Architecture, mantendo a lógica de aplicação
/// separada das camadas de infraestrutura.
class AddPoint {
  /// Dependência do repositório, injetada via construtor.
  final PointRepository repository;

  /// Construtor que recebe a implementação de [PointRepository].
  AddPoint(this.repository);

  /// Executa o caso de uso de adicionar um ponto de interesse.
  ///
  /// Recebe um [PointEntity] e delega a adição ao repositório.
  /// O uso do método `call` permite invocar a instância como uma função.
  Future<void> call(PointEntity point) async {
    return await repository.addPoint(point);
  }
}
