import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:location/location.dart';
import 'package:flutter/foundation.dart';

class LocationService {
  Location location = Location();

  Future<bool> requestPermission() async {
    try {
      final permission = await location.requestPermission();
      return permission == PermissionStatus.granted;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  Future<LocationData> getCurrentLocation() async {
    final serviceEnabled = await requestPermission();
    if (serviceEnabled == true) {
      bool result = await location.serviceEnabled();
      if (result) {
        try {
          final locationData = await location.getLocation();
          print("GL5");

          return locationData;
        } catch (e) {
          return LocationData.fromMap({});
        }
      } else {
        return LocationData.fromMap({});
      }
    } else {
      return LocationData.fromMap({});
    }
  }
}

class WeatherData {
  final double temperature;
  final String recommendation;
  final double minTemp;
  final double maxTemp;
  WeatherData({
    required this.temperature,
    required this.recommendation,
    required this.minTemp,
    required this.maxTemp,
  });
}

class WeatherDataProvider extends ChangeNotifier {
  String apiKey = "2eb392402b6e0936e5b35dda3004615e";
  static final LocationService locationService = LocationService();
  WeatherData? _weatherData;
  LocationData? locationData;
  WeatherDataProvider() {
    locationData =
        LocationData.fromMap({"latitude": 9.005401, "longitude": 38.763611});
    _weatherData = WeatherData(
      temperature: 0,
      recommendation: "Enable manual mode for better efficiency",
      minTemp: 0,
      maxTemp: 20,
    );
    _initSensorInfo();
  }
  void _initSensorInfo() async {
    locationData = await locationService.getCurrentLocation();
    _fetchWeatherData();
    Timer.periodic(const Duration(seconds: 1), (timer) {
      _fetchWeatherData();
    });
  }

  WeatherData? get weatherData => _weatherData;

  Future<void> _fetchWeatherData() async {
    try {
      final double latitude = locationData!.latitude!;
      final double longitude = locationData!.longitude!;
      final String weatherApiUrl =
          'https://api.openweathermap.org/data/2.5/weather?lat=$latitude&lon=$longitude&appid=$apiKey&units=metric';

      final response = await http.get(Uri.parse(weatherApiUrl));

      if (response.statusCode == 200) {
        final Map<String, dynamic> weatherJson = json.decode(response.body);
        final double temperature = weatherJson['main']['temp'];
        final double minTemperature = weatherJson['main']['temp_min'];
        final double maxTemperature = weatherJson['main']['temp_max'];
        String recommendation = '';
        if (temperature < 10) {
          recommendation = 'Enable manual mode for better efficiency';
        } else if (temperature < 20) {
          recommendation = 'Enable manual mode for better efficiency';
        } else {
          recommendation = 'Enable automatic mode for better efficiency';
        }
        print("URL$weatherApiUrl");
        print("WDD${_weatherData!.temperature}");

        _weatherData = WeatherData(
          temperature: temperature,
          recommendation: recommendation,
          minTemp: minTemperature,
          maxTemp: maxTemperature,
        );

        notifyListeners();
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (e) {
      print('Error fetching weather data: $e');
      throw Exception('Error fetching weather data');
    }
  }
}
