import 'package:flutter/material.dart';
import 'pages/home.dart';
import 'pages/gender_predictor.dart';
import 'pages/age_predictor.dart';
import 'pages/universities.dart';
import 'pages/weather.dart';
import 'pages/news.dart'; // Asegúrate de que esta línea sea correcta
import 'pages/about.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Toolbox App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),  // Página de inicio
      routes: {
        '/gender': (context) => GenderPredictorPage(),
        '/age': (context) => AgePredictorPage(),
        '/universities': (context) => UniversitiesPage(),
        '/weather': (context) => WeatherPage(),
        '/news': (context) => RedditNewsPage(),
        '/about': (context) => AboutPage(),
      },
    );
  }
}
