import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class UniversitiesPage extends StatefulWidget {
  const UniversitiesPage({super.key});

  @override
  _UniversitiesPageState createState() => _UniversitiesPageState();
}

class _UniversitiesPageState extends State<UniversitiesPage> {
  String country = "";
  List universities = [];

  Future<void> fetchUniversities(String country) async {
    final response = await http.get(
        Uri.parse('http://universities.hipolabs.com/search?country=$country'));
    if (response.statusCode == 200) {
      setState(() {
        universities = json.decode(response.body);
      });
    } else {
      setState(() {
        universities = [];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Universidades por País'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  labelText: 'Introduce un país (en inglés)'),
              onChanged: (value) {
                country = value;
              },
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                fetchUniversities(country);
              },
              child: const Text('Buscar Universidades'),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: universities.isNotEmpty
                  ? ListView.builder(
                itemCount: universities.length,
                itemBuilder: (context, index) {
                  final university = universities[index];
                  return ListTile(
                    title: Text(university['name'] ?? 'No disponible'),
                    subtitle: Text(university['domain'] ?? 'No disponible'),
                    trailing: IconButton(
                      icon: const Icon(Icons.open_in_new),
                      onPressed: () {
                        final url = university['web_pages']?[0];
                        if (url != null) {
                          launch(url);
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('Página web no disponible'))
                          );
                        }
                      },
                    ),
                  );
                },
              )
                  : const Text('Introduce un país para ver sus universidades'),
            ),
          ],
        ),
      ),
    );
  }
}