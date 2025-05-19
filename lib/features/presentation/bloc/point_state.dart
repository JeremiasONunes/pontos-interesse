part of 'point_bloc.dart';

abstract class PointState extends Equatable {
  const PointState();

  @override
  List<Object?> get props => [];
}

class PointInitial extends PointState {}

class PointLoading extends PointState {}

class PointLoaded extends PointState {
  final List<PointEntity> points;
  final double userLatitude;
  final double userLongitude;

  const PointLoaded({
    required this.points,
    required this.userLatitude,
    required this.userLongitude,
  });

  @override
  List<Object?> get props => [points, userLatitude, userLongitude];
}

class UserLocationLoaded extends PointState {
  final double latitude;
  final double longitude;

  const UserLocationLoaded({required this.latitude, required this.longitude});

  @override
  List<Object?> get props => [latitude, longitude];
}
