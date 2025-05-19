import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontos_de_interesse/features/presentation/bloc/point_bloc.dart';
import 'package:pontos_de_interesse/features/presentation/widgets/point_card.dart';

class PointListPage extends StatelessWidget {
  const PointListPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<PointBloc>(context)..add(LoadPointsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Lista de Pontos')),
        body: BlocBuilder<PointBloc, PointState>(
          builder: (context, state) {
            if (state is PointLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PointLoaded) {
              if (state.points.isEmpty) {
                return const Center(child: Text('Nenhum ponto cadastrado.'));
              }

              return ListView.builder(
                padding: const EdgeInsets.all(8),
                itemCount: state.points.length,
                itemBuilder: (context, index) {
                  final point = state.points[index];
                  return PointCard(point: point);
                },
              );
            } else {
              return const Center(child: Text('Erro ao carregar pontos.'));
            }
          },
        ),
      ),
    );
  }
}
