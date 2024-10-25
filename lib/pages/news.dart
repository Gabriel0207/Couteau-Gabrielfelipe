import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';

class RedditNewsPage extends StatefulWidget {
  const RedditNewsPage({Key? key}) : super(key: key);

  @override
  _RedditNewsPageState createState() => _RedditNewsPageState();
}

class _RedditNewsPageState extends State<RedditNewsPage> {
  List posts = [];
  bool isLoading = true;

  Future<void> fetchPosts() async {
    try {
      final response = await http.get(
        Uri.parse('https://www.reddit.com/r/dbz/new.json?limit=10'), // Cambiado a r/dbz
      );
      print('Response status: ${response.statusCode}');
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        print('Response data: $data');
        setState(() {
          posts = data['data']['children'];
          isLoading = false;
        });
      } else {
        throw Exception('Error al cargar las publicaciones: ${response.statusCode}');
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    fetchPosts();
  }

  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se pudo abrir $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Publicaciones de Reddit - Dragon Ball Z'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: isLoading
            ? Center(child: CircularProgressIndicator())
            : posts.isEmpty
            ? Center(child: Text('No se encontraron publicaciones.'))
            : ListView.builder(
          itemCount: posts.length,
          itemBuilder: (context, index) {
            final post = posts[index]['data'];
            return Card(
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: ListTile(
                title: Text(post['title']),
                subtitle: Text(post['selftext'] ?? 'Sin descripción'),
                trailing: IconButton(
                  icon: Icon(Icons.open_in_new),
                  onPressed: () {
                    _launchURL('https://www.reddit.com${post['permalink']}');
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}