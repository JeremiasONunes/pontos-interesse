import '../entities/point_entity.dart';
import '../repositories/point_repository.dart';

class GetPoints {
  final PointRepository repository;

  GetPoints(this.repository);

  Future<List<PointEntity>> call() async {
    return await repository.getPoints();
  }
}
