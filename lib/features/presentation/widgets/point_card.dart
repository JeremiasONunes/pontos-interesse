import 'package:flutter/material.dart';
import 'package:pontos_de_interesse/features/points/domain/entities/point_entity.dart';

class PointCard extends StatelessWidget {
  final PointEntity point;

  const PointCard({super.key, required this.point});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        title: Text(
          point.name,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(point.description),
            const SizedBox(height: 4),
            Text(
              'Lat: ${point.latitude.toStringAsFixed(4)}, Lon: ${point.longitude.toStringAsFixed(4)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          ],
        ),
        leading: const Icon(Icons.place, color: Colors.green),
      ),
    );
  }
}
