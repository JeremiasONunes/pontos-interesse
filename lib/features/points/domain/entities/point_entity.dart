import 'package:equatable/equatable.dart';

class PointEntity extends Equatable {
  final String name;
  final String description;
  final double latitude;
  final double longitude;

  const PointEntity({
    required this.name,
    required this.description,
    required this.latitude,
    required this.longitude,
  });

  @override
  List<Object> get props => [name, description, latitude, longitude];
}
