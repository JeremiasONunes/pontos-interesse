import 'package:pontos_de_interesse/features/points/domain/entities/point_entity.dart';

abstract class PointRepository {
  Future<void> addPoint(PointEntity point);
  Future<List<PointEntity>> getPoints();
  Future<({double latitude, double longitude})> getCurrentLocation();
  double calculateDistance({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  });
}
