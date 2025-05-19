import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontos_de_interesse/features/points/domain/entities/point_entity.dart';
import 'package:pontos_de_interesse/features/presentation/bloc/point_bloc.dart';

class AddPointPage extends StatefulWidget {
  const AddPointPage({super.key});

  @override
  State<AddPointPage> createState() => _AddPointPageState();
}

class _AddPointPageState extends State<AddPointPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descController = TextEditingController();

  double? latitude;
  double? longitude;
  bool isLoadingLocation = false;

  void _getLocation() async {
    setState(() => isLoadingLocation = true);
    try {
      final location = await context.read<PointBloc>().getCurrentLocation();
      setState(() {
        latitude = location.latitude;
        longitude = location.longitude;
      });
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro ao obter localização: $e')));
    } finally {
      setState(() => isLoadingLocation = false);
    }
  }

  void _savePoint() {
    if (_formKey.currentState!.validate() &&
        latitude != null &&
        longitude != null) {
      final point = PointEntity(
        name: _nameController.text,
        description: _descController.text,
        latitude: latitude!,
        longitude: longitude!,
      );

      context.read<PointBloc>().add(AddPointEvent(point));

      Navigator.pop(context); // volta para Home
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Preencha todos os campos e obtenha a localização.'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Adicionar Ponto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Digite um nome'
                            : null,
              ),
              TextFormField(
                controller: _descController,
                decoration: const InputDecoration(labelText: 'Descrição'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Digite uma descrição'
                            : null,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  ElevatedButton.icon(
                    onPressed: isLoadingLocation ? null : _getLocation,
                    icon: const Icon(Icons.my_location),
                    label: const Text('Obter localização'),
                  ),
                  const SizedBox(width: 12),
                  if (latitude != null && longitude != null)
                    Text(
                      '(${latitude!.toStringAsFixed(4)}, ${longitude!.toStringAsFixed(4)})',
                      style: const TextStyle(fontSize: 12),
                    ),
                ],
              ),
              const Spacer(),
              ElevatedButton.icon(
                onPressed: _savePoint,
                icon: const Icon(Icons.save),
                label: const Text('Salvar Ponto'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(50),
                  backgroundColor: Colors.green,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
