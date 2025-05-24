// Indica que este arquivo é parte do arquivo 'point_bloc.dart',
// possibilitando o uso conjunto das classes de estado no Bloc.
part of 'point_bloc.dart';

/// Classe abstrata base para os estados do PointBloc.
/// Herdar de Equatable facilita a comparação entre estados.
abstract class PointState extends Equatable {
  const PointState();

  // Define os campos para comparação de igualdade.
  // Aqui vazio pois a classe base não tem propriedades.
  @override
  List<Object?> get props => [];
}

/// Estado inicial do Bloc, antes de qualquer ação acontecer.
class PointInitial extends PointState {}

/// Estado que indica que os dados (pontos e localização) estão sendo carregados.
class PointLoading extends PointState {}

/// Estado que representa o sucesso no carregamento dos pontos e da localização do usuário.
class PointLoaded extends PointState {
  final List<PointEntity> points; // Lista de pontos carregados.
  final double userLatitude; // Latitude atual do usuário.
  final double userLongitude; // Longitude atual do usuário.

  // Construtor obrigatório recebendo os dados necessários.
  const PointLoaded({
    required this.points,
    required this.userLatitude,
    required this.userLongitude,
  });

  // Campos usados para comparação do estado, garantindo que mudanças sejam detectadas.
  @override
  List<Object?> get props => [points, userLatitude, userLongitude];
}

/// Estado específico para quando a localização do usuário é carregada com sucesso,
/// mas os pontos podem ainda não ter sido carregados.
class UserLocationLoaded extends PointState {
  final double latitude; // Latitude atual do usuário.
  final double longitude; // Longitude atual do usuário.

  // Construtor obrigatório.
  const UserLocationLoaded({required this.latitude, required this.longitude});

  // Propriedades para comparação entre estados.
  @override
  List<Object?> get props => [latitude, longitude];
}
