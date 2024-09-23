import 'dart:convert';
import 'package:wether_app/models/weather_model.dart';
import 'package:http/http.dart' as http;
import 'package:wether_app/services/get_location_service.dart';

class WeatherServices {
  static const BASE_URL = "https://api.openweathermap.org/data/2.5/weather";
  final String apiKey;

  WeatherServices({required this.apiKey});
  // https://api.openweathermap.org/data/2.5/weather?q=london&appid=54238db75420c1d31f9d6f18bbfd13e9&units=metric

  //get the weather from the city name
  Future<Weather> getWeather({required String cityName}) async {
    try {
      final url = "$BASE_URL?q=$cityName&appid=$apiKey&units=metric";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Weather.fromJson(json);
      } else {
        throw Exception('Failed to load weather data');
      }
    } catch (error) {
      print("pakya:{$error}");
      throw Exception('Failed to load weather data');
    }
  }

  //get the weather from the location
  Future<Weather> getWeatherByLocation() async {
    try {
      final location = GetLocationService();
      final cityName = await location.getCityNameFromCurrentLocation();
      print(cityName);

      //https://api.openweathermap.org/data/2.5/weather?lat=6.9318&lon=6.9318&appid=$apiKey&units=metric
      final url =
          "$BASE_URL?lat=${cityName[0]}&lon=${cityName[1]}&appid=$apiKey&units=metric";

      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final json = jsonDecode(response.body);
        return Weather.fromJson(json);
      } else {
        print(
            'Failed to load weather data: Status Code ${response.statusCode}');
        throw Exception(
            'Failed to load weather data: Status Code ${response.statusCode}');
      }
    } catch (eror) {
      print("In WeatherService:{$eror}");

      throw Exception('Failed to load weather data');
    }
  }
}
