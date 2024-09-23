import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
import 'package:wether_app/models/weather_model.dart';
import 'package:wether_app/providers/theam_provider.dart';
import 'package:wether_app/services/weather_services.dart';
import 'package:wether_app/widgets/display_weather.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final WeatherServices _weatherServices =
      WeatherServices(apiKey: dotenv.env["OPEN_WEATHER_API_KEY"] ?? " ");

  Weather? _weather;

  // method to fetch the weather
  void fetchWeather() async {
    try {
      final weather = await _weatherServices.getWeatherByLocation();

      setState(() {
        _weather = weather;
        print(_weather);
      });
    } catch (error) {
      print("Error From Weather data:$error");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Easy Weather",
          style: TextStyle(
            fontWeight: FontWeight.w400,
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              Provider.of<TheamProvider>(context, listen: false)
                  .togleTheme(Theme.of(context).brightness != Brightness.dark);
            },
            icon: Icon(
              Theme.of(context).brightness == Brightness.dark
                  ? Icons.light_mode
                  : Icons.dark_mode,
            ),
          )
        ],
      ),
      body: _weather != null
          ? SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [WheatherDisplay(wheather: _weather!)],
              ),
            )
          : const Center(
              child: CircularProgressIndicator(),
            ),
    );
  }
}
