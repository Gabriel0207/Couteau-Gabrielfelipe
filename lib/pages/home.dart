import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Toolbox App'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/toolbox.png', height: 200),  // Imagen de caja de herramientas
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/gender');
              },
              child: Text('Predicción de Género'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/age');
              },
              child: Text('Predicción de Edad'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/universities');
              },
              child: Text('Universidades por País'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/weather');
              },
              child: Text('Clima en República Dominicana'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/news');
              },
              child: Text('Noticias de Smashing Magazine'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/about');
              },
              child: Text('Acerca de mí'),
            ),
          ],
        ),
      ),
    );
  }
}
