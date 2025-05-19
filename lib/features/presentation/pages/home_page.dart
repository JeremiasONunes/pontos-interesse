import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontos_de_interesse/features/presentation/bloc/point_bloc.dart';
import 'package:pontos_de_interesse/features/points/domain/entities/point_entity.dart';
import 'package:pontos_de_interesse/features/presentation/widgets/point_card.dart';
import 'add_point_page.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: BlocProvider.of<PointBloc>(context)..add(LoadPointsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Pontos de Interesse')),
        body: BlocBuilder<PointBloc, PointState>(
          builder: (context, state) {
            if (state is PointLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is PointLoaded) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Localização atual: ${state.userLatitude.toStringAsFixed(4)}, ${state.userLongitude.toStringAsFixed(4)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      itemCount: state.points.length,
                      itemBuilder: (context, index) {
                        final PointEntity point = state.points[index];
                        return PointCard(point: point);
                      },
                    ),
                  ),
                ],
              );
            } else {
              return const Center(child: Text('Nenhum dado disponível.'));
            }
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const AddPointPage()),
            );
          },
          child: const Icon(Icons.add),
        ),
      ),
    );
  }
}
