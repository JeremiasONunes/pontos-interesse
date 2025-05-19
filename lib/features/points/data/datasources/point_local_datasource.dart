import 'dart:convert';
import 'package:pontos_de_interesse/features/points/data/models/point_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class PointLocalDataSource {
  Future<void> savePoint(PointModel point);
  Future<List<PointModel>> getAllPoints();
}

const String cachedPointsKey = 'CACHED_POINTS';

class PointLocalDataSourceImpl implements PointLocalDataSource {
  final SharedPreferences sharedPreferences;

  PointLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<void> savePoint(PointModel point) async {
    final List<PointModel> currentPoints = await getAllPoints();
    currentPoints.add(point);
    final List<Map<String, dynamic>> jsonList =
        currentPoints.map((e) => e.toMap()).toList();
    final String jsonString = json.encode(jsonList);
    await sharedPreferences.setString(cachedPointsKey, jsonString);
  }

  @override
  Future<List<PointModel>> getAllPoints() async {
    final jsonString = sharedPreferences.getString(cachedPointsKey);
    if (jsonString != null) {
      final List<dynamic> decoded = json.decode(jsonString);
      return decoded
          .map((item) => PointModel.fromMap(item as Map<String, dynamic>))
          .toList();
    } else {
      return [];
    }
  }
}
