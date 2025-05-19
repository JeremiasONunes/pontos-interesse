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

final sl = GetIt.instance;

Future<void> init() async {
  //! Features - Points

  // Bloc
  sl.registerFactory(
    () => PointBloc(
      addPoint: sl(),
      getPoints: sl(),
      getCurrentLocation: sl(),
      calculateDistance: sl(),
    ),
  );

  // Use Cases
  sl.registerLazySingleton(() => AddPoint(sl()));
  sl.registerLazySingleton(() => GetPoints(sl()));
  sl.registerLazySingleton(() => GetCurrentLocation(sl()));
  sl.registerLazySingleton(() => CalculateDistance(sl()));

  // Repository
  sl.registerLazySingleton<PointRepository>(
    () => PointRepositoryImpl(localDataSource: sl(), locationDataSource: sl()),
  );

  // Data Sources
  sl.registerLazySingleton<PointLocalDataSource>(
    () => PointLocalDataSourceImpl(sharedPreferences: sl()),
  );
  sl.registerLazySingleton<LocationDataSource>(() => LocationDataSourceImpl());

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
}
