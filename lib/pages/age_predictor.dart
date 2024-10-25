import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class AgePredictorPage extends StatefulWidget {
  const AgePredictorPage({super.key});

  @override
  _AgePredictorPageState createState() => _AgePredictorPageState();
}

class _AgePredictorPageState extends State<AgePredictorPage> {
  String name = "";
  int age = 0;
  String category = "";
  String imagePath = "";

  Future<void> predictAge(String name) async {
    final response = await http.get(Uri.parse('https://api.agify.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        age = data['age'];
        if (age < 30) {
          category = "Joven";
          imagePath = 'assets/young.png';
        } else if (age < 60) {
          category = "Adulto";
          imagePath = 'assets/adult.png';
        } else {
          category = "Anciano";
          imagePath = 'assets/elderly.png';
        }
      });
    } else {
      throw Exception('Failed to load age prediction');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Predicción de Edad'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              decoration: const InputDecoration(labelText: 'Introduce un nombre'),
              onChanged: (value) {
                name = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                predictAge(name);
              },
              child: const Text('Predecir Edad'),
            ),
            const SizedBox(height: 20),
            Text(
              age > 0 ? 'La edad estimada es: $age, Categoría: $category' : 'Introduce un nombre para predecir la edad',
              style: const TextStyle(fontSize: 18),
            ),
            if (imagePath.isNotEmpty)
              Image.asset(imagePath, height: 200),
          ],
        ),
      ),
    );
  }
}
