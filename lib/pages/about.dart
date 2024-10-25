import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Acerca de mí'),
      ),
      body: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 50,
              backgroundImage: AssetImage('assets/tu_foto.png'),  // Reemplaza con tu foto
            ),
            SizedBox(height: 20),
            Text(
              'Gabriel Felipe',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Desarrollador Junior | gabrielfelipe101515@gmail.com'),
            SizedBox(height: 10),
            Text('Matricula: 2022-1978'),
          ],
        ),
      ),
    );
  }
}
