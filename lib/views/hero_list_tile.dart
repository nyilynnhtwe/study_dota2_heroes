import 'package:flutter/material.dart';
import 'package:mobile/models/hero_model.dart';

class HeroListTile extends StatefulWidget {
  const HeroListTile({
    super.key,
    required this.hero,
  });

  final Dota2Hero hero;

  @override
  State<HeroListTile> createState() => _HeroListTileState();
}

class _HeroListTileState extends State<HeroListTile> {
  var heroBoxBgColor = const Color.fromARGB(193, 4, 137, 66);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          heroBoxBgColor = const Color.fromARGB(193, 12, 231, 85);
        });
        Future.delayed(const Duration(milliseconds: 100), () {
          setState(() {
            heroBoxBgColor = const Color.fromARGB(193, 4, 137, 66);
          });
        });
        Navigator.of(context).push(MaterialPageRoute(builder: builder))
      },
      child: Container(
        decoration: BoxDecoration(
          color: heroBoxBgColor,
          borderRadius: BorderRadius.circular(
              10.0), // Adjust the value for the desired roundness
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 10,
          horizontal: 10,
        ),
        margin: const EdgeInsets.symmetric(
          vertical: 5,
          horizontal: 5,
        ),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child: Image.network(
                widget.hero.imageUrl ?? "null",
              ),
            ),
            Column(
              children: [
                Text(
                  widget.hero.localizedName ?? "",
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
                RichText(
                  text: TextSpan(
                    children: [
                      const TextSpan(
                        text: 'Primary Attribute: ',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                      TextSpan(
                        text: formattedAttr(widget.hero.primaryAttr ?? ""),
                        style: const TextStyle(
                          color: Color.fromARGB(255, 163, 252, 179),
                          fontSize: 10,
                        ),
                      ),
                      TextSpan(
                        text: widget.hero.attackType ?? "null",
                        style: const TextStyle(
                          color: Colors.white,
                          // fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
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
