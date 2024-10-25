import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class GenderPredictorPage extends StatefulWidget {
  const GenderPredictorPage({super.key});

  @override
  _GenderPredictorPageState createState() => _GenderPredictorPageState();
}

class _GenderPredictorPageState extends State<GenderPredictorPage> {
  String name = "";
  String gender = "";
  Color backgroundColor = Colors.white;

  Future<void> predictGender(String name) async {
    final response = await http.get(Uri.parse('https://api.genderize.io/?name=$name'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        gender = data['gender'];
        backgroundColor = (gender == 'male') ? Colors.blue : Colors.pink;
      });
    } else {
      throw Exception('Failed to load gender prediction');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text('Predicción de Género'),
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
                predictGender(name);
              },
              child: const Text('Predecir Género'),
            ),
            const SizedBox(height: 20),
            Text(
              gender.isNotEmpty ? 'El género es: $gender' : 'Introduce un nombre para predecir el género',
              style: const TextStyle(fontSize: 18),
            ),
          ],
        ),
      ),
    );
  }
}
