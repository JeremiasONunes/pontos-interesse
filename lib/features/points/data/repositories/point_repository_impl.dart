import 'package:pontos_de_interesse/features/points/domain/repositories/point_repository.dart';
import 'package:pontos_de_interesse/features/points/domain/entities/point_entity.dart';
import 'package:pontos_de_interesse/features/points/data/datasources/point_local_datasource.dart';
import 'package:pontos_de_interesse/features/points/data/datasources/location_datasource.dart';
import 'package:pontos_de_interesse/features/points/data/models/point_model.dart';
import 'dart:math';

class PointRepositoryImpl implements PointRepository {
  final PointLocalDataSource localDataSource;
  final LocationDataSource locationDataSource;

  PointRepositoryImpl({
    required this.localDataSource,
    required this.locationDataSource,
  });

  @override
  Future<void> addPoint(PointEntity point) async {
    final model = PointModel.fromEntity(point);
    await localDataSource.savePoint(model);
  }

  @override
  Future<List<PointEntity>> getPoints() async {
    final models = await localDataSource.getAllPoints();
    return models.map((model) => model.toEntity()).toList();
  }

  @override
  Future<({double latitude, double longitude})> getCurrentLocation() async {
    return await locationDataSource.getCurrentLocation();
  }

  @override
  double calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    const double earthRadius = 6371000; // em metros

    final dLat = _toRadians(endLatitude - startLatitude);
    final dLon = _toRadians(endLongitude - startLongitude);

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

  double _toRadians(double degree) => degree * pi / 180;
}
