// Importa a biblioteca Equatable, que facilita a comparação de objetos por valor.
import 'package:equatable/equatable.dart';

/// Entidade de domínio que representa um ponto de interesse.
///
/// Utilizada na camada de domínio para garantir a separação entre lógica de negócio
/// e implementação específica de armazenamento ou apresentação.
class PointEntity extends Equatable {
  /// Nome do ponto de interesse.
  final String name;

  /// Descrição do ponto de interesse.
  final String description;

  /// Latitude do ponto de interesse.
  final double latitude;

  /// Longitude do ponto de interesse.
  final double longitude;

  /// Construtor constante que inicializa todos os atributos obrigatórios.
  const PointEntity({
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  /// Sobrescreve a lista de propriedades para comparação de igualdade.
  ///
  /// Necessário para que o Equatable funcione corretamente,
  /// permitindo comparar objetos de forma segura e previsível.
  @override
  List<Object> get props => [name, description, latitude, longitude];
}
