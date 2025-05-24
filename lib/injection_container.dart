import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'features/points/data/datasources/location_datasource.dart';
import 'features/points/data/datasources/point_local_datasource.dart';
import 'features/points/data/repositories/point_repository_impl.dart';
import 'features/points/domain/repositories/point_repository.dart';
import 'features/points/domain/usecases/add_point.dart';
import 'features/points/domain/usecases/get_points.dart';
import 'features/points/domain/usecases/get_current_location.dart';
import 'features/points/domain/usecases/calculate_distance.dart';
import 'features/presentation/bloc/point_bloc.dart';

// Instância singleton do GetIt para registrar e resolver dependências.
final sl = GetIt.instance;

// Função assíncrona que configura o container de injeção de dependências.
Future<void> init() async {
  //! Features - Points

  // Registro do BLoC: cria uma nova instância sempre que solicitada.
  // O BLoC depende dos casos de uso (use cases) que serão injetados automaticamente.
  sl.registerFactory(
    () => PointBloc(
      addPoint: sl(),
      getPoints: sl(),
      getCurrentLocation: sl(),
      calculateDistance: sl(),
    ),
  );

  // Registro dos casos de uso (use cases) como singletons preguiçosos,
  // ou seja, instanciados somente quando usados pela primeira vez.
  sl.registerLazySingleton(() => AddPoint(sl())); // Usa o repositório injetado.
  sl.registerLazySingleton(
    () => GetPoints(sl()),
  ); // Usa o repositório injetado.
  sl.registerLazySingleton(
    () => GetCurrentLocation(sl()),
  ); // Usa o data source de localização.
  sl.registerLazySingleton(
    () => CalculateDistance(sl()),
  ); // Usa o data source de localização.

  // Registro da implementação do repositório como singleton preguiçoso,
  // que depende dos data sources locais e de localização.
  sl.registerLazySingleton<PointRepository>(
    () => PointRepositoryImpl(localDataSource: sl(), locationDataSource: sl()),
  );

  // Registro dos data sources como singletons preguiçosos.
  // O data source local depende do SharedPreferences.
  sl.registerLazySingleton<PointLocalDataSource>(
    () => PointLocalDataSourceImpl(sharedPreferences: sl()),
  );
  // Data source para obter localização do dispositivo.
  sl.registerLazySingleton<LocationDataSource>(() => LocationDataSourceImpl());

  //! External
  // Instancia SharedPreferences, aguardando a inicialização assíncrona.
  final sharedPreferences = await SharedPreferences.getInstance();
  // Registra SharedPreferences como singleton para ser injetado onde for necessário.
  sl.registerLazySingleton(() => sharedPreferences);
}
