import 'package:pontos_de_interesse/features/points/domain/entities/point_entity.dart';

class PointModel extends PointEntity {
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

  factory PointModel.fromMap(Map<String, dynamic> map) {
    return PointModel(
      name: map['name'],
      description: map['description'],
      latitude: map['latitude'],
      longitude: map['longitude'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'description': description,
      'latitude': latitude,
      'longitude': longitude,
    };
  }

  factory PointModel.fromEntity(PointEntity entity) {
    return PointModel(
      name: entity.name,
      description: entity.description,
      latitude: entity.latitude,
      longitude: entity.longitude,
    );
  }

  PointEntity toEntity() {
    return PointEntity(
      name: name,
      description: description,
      latitude: latitude,
      longitude: longitude,
    );
  }
}
