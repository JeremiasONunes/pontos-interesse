import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontos_de_interesse/features/presentation/bloc/point_bloc.dart';
import 'package:pontos_de_interesse/features/points/domain/entities/point_entity.dart';
import 'package:pontos_de_interesse/features/presentation/widgets/point_card.dart';
import 'add_point_page.dart';

/// Página principal que exibe a lista de pontos de interesse e a localização do usuário.
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      // Reutiliza o PointBloc já existente no contexto e dispara o evento para carregar os pontos.
      value: BlocProvider.of<PointBloc>(context)..add(LoadPointsEvent()),
      child: Scaffold(
        appBar: AppBar(title: const Text('Pontos de Interesse')),
        body: BlocBuilder<PointBloc, PointState>(
          builder: (context, state) {
            // Enquanto os dados estão sendo carregados, mostra um indicador de progresso.
            if (state is PointLoading) {
              return const Center(child: CircularProgressIndicator());

              // Quando os pontos e a localização foram carregados com sucesso, exibe-os.
            } else if (state is PointLoaded) {
              return Column(
                children: [
                  // Exibe a localização atual do usuário no topo.
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      'Localização atual: ${state.userLatitude.toStringAsFixed(4)}, ${state.userLongitude.toStringAsFixed(4)}',
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),

                  // Lista expansível que mostra os pontos usando o widget customizado PointCard.
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

              // Caso o estado não seja reconhecido ou não haja dados, mostra mensagem padrão.
            } else {
              return const Center(child: Text('Nenhum dado disponível.'));
            }
          },
        ),

        // Botão flutuante para navegar até a tela de adicionar um novo ponto.
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
