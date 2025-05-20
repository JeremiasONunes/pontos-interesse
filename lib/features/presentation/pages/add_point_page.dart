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
  final _latController = TextEditingController();
  final _lonController = TextEditingController();

  void _savePoint() {
    if (_formKey.currentState!.validate()) {
      final lat = double.tryParse(_latController.text);
      final lon = double.tryParse(_lonController.text);

      if (lat == null || lon == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Latitude e longitude inválidas.')),
        );
        return;
      }

      final point = PointEntity(
        name: _nameController.text,
        description: _descController.text,
        latitude: lat,
        longitude: lon,
      );

      context.read<PointBloc>().add(AddPointEvent(point));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos corretamente.')),
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
              TextFormField(
                controller: _latController,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Latitude'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Informe a latitude'
                            : null,
              ),
              TextFormField(
                controller: _lonController,
                keyboardType: const TextInputType.numberWithOptions(
                  signed: true,
                  decimal: true,
                ),
                decoration: const InputDecoration(labelText: 'Longitude'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Informe a longitude'
                            : null,
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
