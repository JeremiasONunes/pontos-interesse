import '../entities/point_entity.dart';
import '../repositories/point_repository.dart';

class AddPoint {
  final PointRepository repository;

  AddPoint(this.repository);

  Future<void> call(PointEntity point) async {
    return await repository.addPoint(point);
  }
}
