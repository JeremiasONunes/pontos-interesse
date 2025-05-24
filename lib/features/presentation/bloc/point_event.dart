// Indica que este arquivo faz parte do arquivo 'point_bloc.dart'.
// Isso permite que os eventos sejam usados dentro do mesmo contexto do Bloc.
part of 'point_bloc.dart';

/// Classe abstrata base para todos os eventos relacionados ao PointBloc.
/// Herdar de Equatable para facilitar comparação e evitar eventos duplicados.
abstract class PointEvent extends Equatable {
  const PointEvent();

  // Define os campos que serão usados para comparação de igualdade.
  // Aqui, vazio, pois a classe base não tem propriedades.
  @override
  List<Object?> get props => [];
}

/// Evento para carregar a lista de pontos.
/// Usado para iniciar o carregamento dos pontos e da localização.
class LoadPointsEvent extends PointEvent {}

/// Evento para adicionar um novo ponto à lista.
/// Recebe um objeto PointEntity com os dados do ponto a ser adicionado.
class AddPointEvent extends PointEvent {
  final PointEntity point;

  // Construtor recebe o ponto a ser adicionado.
  const AddPointEvent(this.point);

  // Considera o ponto como propriedade para comparação do evento.
  @override
  List<Object?> get props => [point];
}

/// Evento para carregar apenas a localização atual do usuário.
/// Pode ser usado quando só queremos atualizar a localização.
class LoadLocationEvent extends PointEvent {}
