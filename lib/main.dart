import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontos_de_interesse/features/presentation/bloc/point_bloc.dart';
import 'package:pontos_de_interesse/features/presentation/pages/home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  // Garante que o binding do Flutter está inicializado para uso de recursos assíncronos
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa o container de injeção de dependências (GetIt)
  // que registra todos os serviços, blocos, casos de uso, etc.
  await di.init();

  // Executa o app após a inicialização das dependências
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PointBloc>(
      // Cria e injeta o PointBloc usando o GetIt (container di)
      create: (_) => di.sl<PointBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false, // Remove o banner de debug do app
        title: 'Pontos de Interesse',
        theme: ThemeData(
          // Define o tema do app usando uma cor base verde e Material 3
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        // Define a página inicial do app como HomePage
        home: const HomePage(),
      ),
    );
  }
}
