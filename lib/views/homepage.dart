import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/hero_model.dart';
import 'package:mobile/views/hero_list_tile.dart';

const URL = "https://abusing-scripts.vercel.app/api/heros";

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isLoading = false;
  List<Dota2Hero> heros = [];

  @override
  void initState() {
    loadData();
    super.initState();
  }

  Future<void> loadData() async {
    await fetchAllHeros();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(182, 196, 182, 1.0),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(22, 48, 32, 1.0),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
        title: const Text(
          "Dota 2 Heros",
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: heros.length,
              itemBuilder: (context, index) {
                return Container(
                  margin: const EdgeInsets.symmetric(vertical: 5),
                  child: HeroListTile(hero: heros[index]),
                );
              },
            ),
    );
  }

  Future<void> fetchAllHeros() async {
    setState(() {
      isLoading = true;
    });
    var response = await http.get(Uri.parse(URL));
    if (response.statusCode == 200 || response.statusCode == 201) {
      var data = json.decode(response.body);
      ;
      for (var hero in data) {
        heros.add(Dota2Hero.fromJson(data: hero));
      }
    } else {
      // ignore: avoid_print
      print("Error");
    }
    isLoading = false;
    setState(() {});
  }
}
