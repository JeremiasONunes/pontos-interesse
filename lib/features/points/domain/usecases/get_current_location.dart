// Importa a abstração do repositório, responsável por fornecer o método de obtenção da localização atual.
import 'package:pontos_de_interesse/features/points/domain/repositories/point_repository.dart';

/// Caso de uso (Use Case) responsável por obter a localização geográfica atual do dispositivo.
///
/// Esse caso de uso encapsula a lógica de acesso à localização, delegando a responsabilidade
/// ao repositório, mantendo a aplicação alinhada aos princípios da Clean Architecture.
class GetCurrentLocation {
  /// Dependência do repositório, que fornece o método para recuperar a localização atual.
  final PointRepository repository;

  /// Construtor que injeta a dependência do repositório.
  GetCurrentLocation(this.repository);

  /// Executa o caso de uso de obter a localização atual.
  ///
  /// Retorna um [Future] que resolve para um record contendo:
  /// - `latitude` (double): latitude atual.
  /// - `longitude` (double): longitude atual.
  ///
  /// Exemplo de retorno: `({latitude: -23.5505, longitude: -46.6333})`
  Future<({double latitude, double longitude})> call() async {
    // Delegação da obtenção da localização ao repositório.
    return await repository.getCurrentLocation();
  }
}
