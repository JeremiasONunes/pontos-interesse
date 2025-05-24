import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontos_de_interesse/features/presentation/bloc/point_bloc.dart';
import 'package:pontos_de_interesse/features/presentation/widgets/point_card.dart';

/// Página que exibe a lista de pontos cadastrados no sistema.
class PointListPage extends StatelessWidget {
  const PointListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      // Reutiliza o PointBloc já existente no contexto e dispara evento para carregar os pontos.
      value: BlocProvider.of<PointBloc>(context)..add(LoadPointsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Lista de Pontos')),
        body: BlocBuilder<PointBloc, PointState>(
          builder: (context, state) {
            // Exibe indicador de carregamento enquanto os dados são obtidos.
            if (state is PointLoading) {
              return const Center(child: CircularProgressIndicator());

              // Quando os pontos são carregados com sucesso:
            } else if (state is PointLoaded) {
              // Caso a lista de pontos esteja vazia, exibe mensagem informativa.
              if (state.points.isEmpty) {
                return const Center(child: Text('Nenhum ponto cadastrado.'));
              }

              // Exibe uma lista com os pontos usando o widget PointCard para cada item.
              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.points.length,
                itemBuilder: (context, index) {
                  final point = state.points[index];
                  return PointCard(point: point);
                },
              );

              // Se o estado for inesperado ou ocorrer algum erro, exibe mensagem padrão.
            } else {
              return const Center(child: Text('Erro ao carregar pontos.'));
            }
          },
        ),
      ),
    );
  }
}
