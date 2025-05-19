import 'package:pontos_de_interesse/features/points/domain/repositories/point_repository.dart';

class CalculateDistance {
  final PointRepository repository;

  CalculateDistance(this.repository);

  double call({
    required double startLatitude,
    required double startLongitude,
    required double endLatitude,
    required double endLongitude,
  }) {
    return repository.calculateDistance(
      startLatitude: startLatitude,
      startLongitude: startLongitude,
      endLatitude: endLatitude,
      endLongitude: endLongitude,
    );
  }
}
