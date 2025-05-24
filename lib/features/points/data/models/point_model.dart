import 'package:pontos_de_interesse/features/points/domain/entities/point_entity.dart';

/// Modelo de dados PointModel que estende a entidade de domínio PointEntity.
///
/// É responsável por representar os pontos de interesse no contexto da camada de dados,
/// permitindo conversão para e a partir de Map (para serialização e persistência).
class PointModel extends PointEntity {
  /// Construtor constante que recebe os atributos e passa para a superclasse PointEntity.
  const PointModel({
    required String name,
    required String description,
    required double latitude,
    required double longitude,
  }) : super(
         name: name,
         description: description,
         latitude: latitude,
         longitude: longitude,
       );

  /// Factory que cria uma instância de PointModel a partir de um Map.
  ///
  /// Usada principalmente para desserialização de dados armazenados, por exemplo, no SharedPreferences.
  factory PointModel.fromMap(Map<String, dynamic> map) {
    return PointModel(
      name: map['name'],
      description: map['description'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  /// Converte a instância de PointModel para um Map<String, dynamic>.
  ///
  /// Usada principalmente para serialização de dados para persistência.
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  /// Factory que cria um PointModel a partir de uma PointEntity.
  ///
  /// Facilita a conversão entre as camadas de domínio e de dados.
  factory PointModel.fromEntity(PointEntity entity) {
    return PointModel(
      name: entity.name,
      description: entity.description,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }

  /// Converte o PointModel para uma PointEntity.
  ///
  /// Útil para quando a camada de domínio precisa trabalhar com a entidade,
  /// desacoplada de detalhes da persistência.
  PointEntity toEntity() {
    return PointEntity(
      name: name,
      description: description,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
