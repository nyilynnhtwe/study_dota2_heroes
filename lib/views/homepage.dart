import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/models/hero_model.dart';

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
      appBar: AppBar(
        title: const Text("Dota 2 Heros"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              scrollDirection: Axis.vertical,
              itemCount: heros.length,
              itemBuilder: (context, index) {
                return Container(
                  margin:
                      const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(
                        color: Color.fromARGB(85, 0, 0, 0),
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    leading: ClipRRect(
                      borderRadius: BorderRadius.circular(10.0),
                      child: Image.network(
                        heros[index].imageUrl ?? "null",
                        // fit: BoxFit.cover,
                      ),
                    ),
                    title: Text(heros[index].localizedName ?? ""),
                    subtitle: Text(
                        'Primary Attribute: ${formattedAttr(heros[index].primaryAttr ?? "")}'),
                    trailing: Text(heros[index].attackType ?? "null"),
                    onTap: () {
                      // Handle tap on the list item
                      print('Tapped on ${heros[index].localizedName}');
                    },
                  ),
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

  String formattedAttr(String rawAttr) {
    String formattedAttr = rawAttr == 'agi'
        ? 'Agility'
        : rawAttr == "str"
            ? "Strength"
            : rawAttr == "int"
                ? "Intelligent"
                : "All";
    return formattedAttr;
  }
}
