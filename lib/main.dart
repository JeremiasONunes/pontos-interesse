import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pontos_de_interesse/features/presentation/bloc/point_bloc.dart';
import 'package:pontos_de_interesse/features/presentation/pages/home_page.dart';
import 'injection_container.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicializa as dependências com get_it
  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<PointBloc>(
      create: (_) => di.sl<PointBloc>(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Pontos de Interesse',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
