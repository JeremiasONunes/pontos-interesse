// Importa o pacote flutter_bloc, que fornece as classes para implementação de Bloc.
import 'package:flutter_bloc/flutter_bloc.dart';

// Importa o pacote equatable para facilitar a comparação de objetos nos estados e eventos.
import 'package:equatable/equatable.dart';

// Importa os casos de uso e a entidade relacionados aos pontos de interesse.
import 'package:pontos_de_interesse/features/points/domain/usecases/add_point.dart';
import 'package:pontos_de_interesse/features/points/domain/entities/point_entity.dart';
import 'package:pontos_de_interesse/features/points/domain/usecases/get_points.dart';
import 'package:pontos_de_interesse/features/points/domain/usecases/get_current_location.dart';
import 'package:pontos_de_interesse/features/points/domain/usecases/calculate_distance.dart';

// Diretivas para importar os arquivos que contêm a definição dos eventos e estados.
part 'point_event.dart';
part 'point_state.dart';

/// Bloc responsável por gerenciar o estado relacionado aos Pontos de Interesse.
///
/// Ele lida com a adição de novos pontos, carregamento de pontos e carregamento
/// da localização atual do usuário.
class PointBloc extends Bloc<PointEvent, PointState> {
  /// Caso de uso para adicionar um novo ponto.
  final AddPoint addPoint;

  /// Caso de uso para recuperar todos os pontos.
  final GetPoints getPoints;

  /// Caso de uso para obter a localização atual do usuário.
  final GetCurrentLocation getCurrentLocation;

  /// Caso de uso para calcular a distância entre dois pontos.
  final CalculateDistance calculateDistance;

  /// Construtor que injeta os casos de uso necessários e define o estado inicial.
  PointBloc({
    required this.addPoint,
    required this.getPoints,
    required this.getCurrentLocation,
    required this.calculateDistance,
  }) : super(PointInitial()) {
    // Define que ao receber LoadPointsEvent, executa _onLoadPoints.
    on<LoadPointsEvent>(_onLoadPoints);

    // Define que ao receber AddPointEvent, executa _onAddPoint.
    on<AddPointEvent>(_onAddPoint);

    // Define que ao receber LoadLocationEvent, executa _onLoadLocation.
    on<LoadLocationEvent>(_onLoadLocation);
  }

  /// Handler para o evento de carregamento de pontos.
  ///
  /// Busca todos os pontos, obtém a localização atual, calcula a distância
  /// e emite o estado PointLoaded com a lista enriquecida.
  Future<void> _onLoadPoints(
    LoadPointsEvent event,
    Emitter<PointState> emit,
  ) async {
    // Emite estado de carregamento.
    emit(PointLoading());

    // Recupera todos os pontos.
    final points = await getPoints();

    // Obtém a localização atual.
    final location = await getCurrentLocation();

    // Mapeia cada ponto adicionando a distância até a localização atual.
    final enrichedPoints =
        points.map((point) {
          final distance = calculateDistance(
            startLatitude: location.latitude,
            startLongitude: location.longitude,
            endLatitude: point.latitude,
            endLongitude: point.longitude,
          );

          // Enriquecimento do nome do ponto com a distância calculada.
          return pointWithDistance(point, distance);
        }).toList();

    // Emite estado de pontos carregados, incluindo a localização do usuário.
    emit(
      PointLoaded(
        points: enrichedPoints,
        userLatitude: location.latitude,
        userLongitude: location.longitude,
      ),
    );
  }

  /// Handler para o evento de adição de um novo ponto.
  ///
  /// Adiciona o ponto e, após isso, dispara um evento de recarregamento dos pontos.
  Future<void> _onAddPoint(
    AddPointEvent event,
    Emitter<PointState> emit,
  ) async {
    // Executa o caso de uso para adicionar o ponto.
    await addPoint(event.point);

    // Dispara evento para recarregar a lista de pontos após a adição.
    add(LoadPointsEvent());
  }

  /// Handler para o evento de carregamento da localização atual.
  ///
  /// Obtém a localização e emite o estado UserLocationLoaded.
  Future<void> _onLoadLocation(
    LoadLocationEvent event,
    Emitter<PointState> emit,
  ) async {
    // Obtém a localização atual.
    final location = await getCurrentLocation();

    // Emite estado com a localização do usuário.
    emit(
      UserLocationLoaded(
        latitude: location.latitude,
        longitude: location.longitude,
      ),
    );
  }

  /// Método auxiliar que cria uma nova instância de [PointEntity],
  /// adicionando ao nome a distância calculada.
  ///
  /// Exemplo: "Parque Central (120.5m)".
  PointEntity pointWithDistance(PointEntity point, double distance) {
    return PointEntity(
      name: '${point.name} (${distance.toStringAsFixed(1)}m)',
      description: point.description,
      latitude: point.latitude,
      longitude: point.longitude,
    );
  }
}
