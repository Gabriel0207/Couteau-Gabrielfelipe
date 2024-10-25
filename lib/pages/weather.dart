import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class WeatherPage extends StatefulWidget {
  const WeatherPage({super.key});

  @override
  _WeatherPageState createState() => _WeatherPageState();
}

class _WeatherPageState extends State<WeatherPage> {
  String weatherInfo = "Cargando...";

  Future<void> fetchWeather() async {
    const apiKey = '18457196-91a9-11ef-9159-0242ac130003-184571f0-91a9-11ef-9159-0242ac130003';  // Tu clave API
    final response = await http.get(
        Uri.parse('https://api.openweathermap.org/data/2.5/weather?q=Santo%20Domingo&appid=$apiKey&units=metric')
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        weatherInfo = 'Clima: ${data['weather'][0]['description']}, Temperatura: ${data['main']['temp']}°C';
      });
    } else {
      setState(() {
        weatherInfo = 'Error al cargar el clima. Código: ${response.statusCode}';
      });
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
        title: const Text('Clima en República Dominicana'),
      ),
      body: Center(
        child: Text(
          weatherInfo,
          style: const TextStyle(fontSize: 24),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
