part of 'point_bloc.dart';

abstract class PointEvent extends Equatable {
  const PointEvent();

  @override
  List<Object?> get props => [];
}

class LoadPointsEvent extends PointEvent {}

class AddPointEvent extends PointEvent {
  final PointEntity point;

  const AddPointEvent(this.point);

  @override
  List<Object?> get props => [point];
}

class LoadLocationEvent extends PointEvent {}
