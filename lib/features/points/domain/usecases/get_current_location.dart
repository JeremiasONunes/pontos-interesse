import 'package:pontos_de_interesse/features/points/domain/repositories/point_repository.dart';

class GetCurrentLocation {
  final PointRepository repository;

  GetCurrentLocation(this.repository);

  Future<({double latitude, double longitude})> call() async {
    return await repository.getCurrentLocation();
  }
}
