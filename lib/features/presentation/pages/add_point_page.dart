import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontos_de_interesse/features/points/domain/entities/point_entity.dart';
import 'package:pontos_de_interesse/features/presentation/bloc/point_bloc.dart';

/// Tela para adicionar um novo ponto de interesse.
/// StatefulWidget pois possui estado interno dos campos do formulário.
class AddPointPage extends StatefulWidget {
  const AddPointPage({super.key});

  @override
  State<AddPointPage> createState() => _AddPointPageState();
}

class _AddPointPageState extends State<AddPointPage> {
  // Chave global para validar o formulário.
  final _formKey = GlobalKey<FormState>();

  // Controladores para capturar o texto dos campos.
  final _nameController = TextEditingController();
  final _descController = TextEditingController();
  final _latController = TextEditingController();
  final _lonController = TextEditingController();

  /// Função para salvar o ponto quando o usuário clicar no botão.
  void _savePoint() {
    // Verifica se o formulário está válido (não vazio, etc).
    if (_formKey.currentState!.validate()) {
      // Tenta converter os textos de latitude e longitude em double.
      final lat = double.tryParse(_latController.text);
      final lon = double.tryParse(_lonController.text);

      // Se conversão falhar, mostra mensagem de erro.
      if (lat == null || lon == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Latitude e longitude inválidas.')),
        );
        return;
      }

      // Cria um objeto PointEntity com os dados do formulário.
      final point = PointEntity(
        name: _nameController.text,
        description: _descController.text,
        latitude: lat,
        longitude: lon,
      );

      // Adiciona o evento AddPointEvent ao Bloc para salvar o ponto.
      context.read<PointBloc>().add(AddPointEvent(point));

      // Fecha a tela atual e volta para a anterior.
      Navigator.pop(context);
    } else {
      // Caso o formulário não seja válido, mostra mensagem.
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Preencha todos os campos corretamente.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Barra superior com título.
      appBar: AppBar(title: const Text('Adicionar Ponto')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        // Formulário para validar os campos.
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              // Campo para nome do ponto.
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nome'),
                validator:
                    (value) =>
                        value == null || value.isEmpty
                            ? 'Digite um nome'
                            : null,
              ),
              // Campo para descrição do ponto.
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
              // Campo para latitude com teclado numérico.
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
              // Campo para longitude com teclado numérico.
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
              // Botão para salvar o ponto.
              ElevatedButton.icon(
                onPressed: _savePoint,
                icon: const Icon(Icons.save),
                label: const Text('Salvar Ponto'),
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size.fromHeight(
                    50,
                  ), // botão grande e fácil de clicar
                  backgroundColor: Colors.green, // cor verde para ação positiva
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
