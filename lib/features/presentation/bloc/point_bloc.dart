import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pontos_de_interesse/features/points/domain/usecases/add_point.dart';
import 'package:pontos_de_interesse/features/points/domain/entities/point_entity.dart';
import 'package:pontos_de_interesse/features/points/domain/usecases/get_points.dart';
import 'package:pontos_de_interesse/features/points/domain/usecases/get_current_location.dart';
import 'package:pontos_de_interesse/features/points/domain/usecases/calculate_distance.dart';

part 'point_event.dart';
part 'point_state.dart';

class PointBloc extends Bloc<PointEvent, PointState> {
  final AddPoint addPoint;
  final GetPoints getPoints;
  final GetCurrentLocation getCurrentLocation;
  final CalculateDistance calculateDistance;

  PointBloc({
    required this.addPoint,
    required this.getPoints,
    required this.getCurrentLocation,
    required this.calculateDistance,
  }) : super(PointInitial()) {
    on<LoadPointsEvent>(_onLoadPoints);
    on<AddPointEvent>(_onAddPoint);
    on<LoadLocationEvent>(_onLoadLocation);
  }

  Future<void> _onLoadPoints(
    LoadPointsEvent event,
    Emitter<PointState> emit,
  ) async {
    emit(PointLoading());

    final points = await getPoints();
    final location = await getCurrentLocation();

    final enrichedPoints =
        points.map((point) {
          final distance = calculateDistance(
            startLatitude: location.latitude,
            startLongitude: location.longitude,
            endLatitude: point.latitude,
            endLongitude: point.longitude,
          );

          return pointWithDistance(point, distance);
        }).toList();

    emit(
      PointLoaded(
        points: enrichedPoints,
        userLatitude: location.latitude,
        userLongitude: location.longitude,
      ),
    );
  }

  Future<void> _onAddPoint(
    AddPointEvent event,
    Emitter<PointState> emit,
  ) async {
    await addPoint(event.point);
    add(LoadPointsEvent()); // recarrega a lista
  }

  Future<void> _onLoadLocation(
    LoadLocationEvent event,
    Emitter<PointState> emit,
  ) async {
    final location = await getCurrentLocation();
    emit(
      UserLocationLoaded(
        latitude: location.latitude,
        longitude: location.longitude,
      ),
    );
  }

  PointEntity pointWithDistance(PointEntity point, double distance) {
    return PointEntity(
      name: '${point.name} (${distance.toStringAsFixed(1)}m)',
      description: point.description,
      latitude: point.latitude,
      longitude: point.longitude,
    );
  }
}
