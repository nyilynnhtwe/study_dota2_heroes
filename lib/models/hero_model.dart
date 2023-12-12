class Dota2Hero {
  int? id;
  String? name;
  String? localizedName;
  String? primaryAttr;
  String? attackType;
  List<dynamic>? roles;
  int? legs;
  String? imageUrl;
  Dota2Hero(
      {required this.id,
      required this.name,
      required this.localizedName,
      required this.primaryAttr,
      required this.attackType,
      required this.roles,
      required this.legs,
      required this.imageUrl});

  @override
  String toString() {
    return 'HeroModel{$id $localizedName$imageUrl}';
  }

  factory Dota2Hero.fromJson({Map<String, dynamic>? data}) {
    if (data == null) {
      throw ArgumentError("Data cannot be null");
    }

    return Dota2Hero(
        id: data['id'] ?? 0,
        name: data['name'] ?? "",
        localizedName: data['localized_name'] ?? "",
        primaryAttr: data['primary_attr'] ?? "",
        attackType: data['attack_type'] ?? "",
        roles: data['roles'] ?? [],
        legs: data['legs'] ?? 0,
        imageUrl: data['imageUrl'] ?? "");
  }
}
