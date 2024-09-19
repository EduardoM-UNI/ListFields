import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:futbol_stadiums_app/details.dart';
import 'package:futbol_stadiums_app/pois.dart';


void main() {
  runApp(const MyApp());
}    

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<List<Lista>> poisFuture = getPois();

  static Future<List<Lista>> getPois() async {
    var url = Uri.parse("https://raw.githubusercontent.com/worldline-spain/technical_test_backend/main/pois.json");
    final response = await http.get(url, headers: {"Content-Type": "application/json"});
    final List body = json.decode(response.body)['list'];
    return body.map((e) => Lista.fromJson(e)).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of football fields'),
      ),
      body: Center(
        child: FutureBuilder<List<Lista>>(
          future: poisFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasData) {
              final list = snapshot.data!;
              return buildPosts(list.cast<Lista>());
            } else {
              return const Text("No data available");
            }
          },
        ),
      ),
    );
  }

  Widget buildPosts(List<Lista> lista) {
    return ListView.builder(
      itemCount: lista.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => Details(lista[index].title,lista[index].image, lista[index].geocoordinates)))
          }, 
        child: Container(
          color: Colors.grey.shade300,
          margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
          padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 5),
          height: 100,
          width: double.maxFinite,
          child: Row(
            children: [
              Expanded(flex: 1, child: Image.network(lista[index].image)),
              const SizedBox(width: 10),
              Expanded(flex: 3, child: Text(lista[index].title)),
            ],
          ),
        )
        );
      },
    );
  }
}
