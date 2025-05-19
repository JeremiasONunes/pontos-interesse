import 'package:geolocator/geolocator.dart';

abstract class LocationDataSource {
  Future<({double latitude, double longitude})> getCurrentLocation();
}

class LocationDataSourceImpl implements LocationDataSource {
  @override
  Future<({double latitude, double longitude})> getCurrentLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Verifica se o serviço de localização está habilitado
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      throw Exception('Serviço de localização desativado.');
    }

    // Verifica as permissões de localização
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        throw Exception('Permissão de localização negada.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      throw Exception('Permissão de localização permanentemente negada.');
    }

    // Obtém a posição atual
    final Position position = await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.high,
    );

    return (latitude: position.latitude, longitude: position.longitude);
  }
}
