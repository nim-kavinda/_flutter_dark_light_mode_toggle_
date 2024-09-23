import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:wether_app/models/weather_model.dart';
import 'package:wether_app/utils/utils_functions.dart';

class WheatherDisplay extends StatelessWidget {
  final Weather wheather;
  const WheatherDisplay({
    super.key,
    required this.wheather,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Lottie.asset(
              UtilsFunctions()
                  .getWeatherAnimation(condition: wheather.condition),
              width: 400,
              height: 400,
            ),
          ),
          Text(
            wheather.cityName,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w300,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            "${wheather.temperature.toStringAsFixed(1)}°C",
            style: const TextStyle(
              fontSize: 60,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 40),
          Row(
            children: [
              Text(
                wheather.condition,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                wheather.description,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _buildWeatherDetails("Pressure", "${wheather.pressure} hPa"),
              _buildWeatherDetails("Humidity", "${wheather.humidity}%"),
              _buildWeatherDetails("Wind Speed", "${wheather.windSpeed} m/s"),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildWeatherDetails(String label, String value) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value,
          style: const TextStyle(
            fontWeight: FontWeight.normal,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
