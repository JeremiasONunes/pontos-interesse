import 'package:flutter/material.dart';
import 'package:pontos_de_interesse/features/points/domain/entities/point_entity.dart';

/// Widget que exibe as informações de um ponto de interesse em um card visual.
class PointCard extends StatelessWidget {
  final PointEntity point;

  // Recebe a entidade PointEntity contendo dados do ponto a ser exibido.
  const PointCard({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return Card(
      // Espaçamento externo horizontal e vertical para separar visualmente os cards na lista.
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),

      // Elevação para dar profundidade e destaque visual ao card.
      elevation: 3,

      // Bordas arredondadas para aparência mais suave e moderna.
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),

      // Conteúdo do card estruturado em ListTile, padrão para listas no Flutter.
      child: ListTile(
        // Título em negrito exibindo o nome do ponto.
        title: Text(
          point.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),

        // Subtítulo que agrupa descrição e coordenadas.
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Descrição do ponto.
            Text(point.description),

            const SizedBox(height: 4),

            // Coordenadas latitude e longitude formatadas com 4 casas decimais, em texto menor e cinza.
            Text(
              'Lat: ${point.latitude.toStringAsFixed(4)}, Lon: ${point.longitude.toStringAsFixed(4)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),

        // Ícone à esquerda representando localização, com cor verde para destaque.
        leading: const Icon(Icons.place, color: Colors.green),
      ),
    );
  }
}
