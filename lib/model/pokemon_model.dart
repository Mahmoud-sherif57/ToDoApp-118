class PokemonModel {
  int? id;
  String? number;
  String? name;
  String? img;
  List<String>? type;
  String? height;
  String? wight;
  String? candy;
  num? candyCount;
  String? egg;
  num? spawnChance;
  num? avgSpawns;
  num? spawnTime;
  List<num>? multipliers;
  List<String>? weaknesses;
  List<Evolution>? nextEvolution;
  List<Evolution>? prevEvolution;

  PokemonModel({
    this.id,
    this.number,
    this.name,
    this.img,
    this.type,
    this.height,
    this.wight,
    this.candy,
    this.candyCount,
    this.egg,
    this.spawnChance,
    this.avgSpawns,
    this.spawnTime,
    this.multipliers,
    this.weaknesses,
    this.nextEvolution,
    this.prevEvolution,
  });

  PokemonModel.fromJson(Map<String?, dynamic> json) {
    id = json['id'];
    number = json['num'];
    name = json['name'];
    img = json['img'];
    type = [];
    for (var i in json['type'] ??[]) {
      type?.add(i);
    }
    height = json['height'];
    wight = json['wight'];
    candy = json['candy'];
    candyCount = json['candy_count'];
    egg = json['egg'];
    spawnChance = json['spawn_chance'];
    avgSpawns = json['avg_spawns'];
    spawnTime = json['spawn_time'];
    multipliers = [];
    for (var i in json['multipliers'] ?? []) {
      multipliers?.add(i);
    }
    weaknesses = [];
    for (var i in json['weaknesses'] ?? []) {
      weaknesses?.add(i);
    }
    nextEvolution = [];
    for (var i in json['next_evolution'] ?? []) {
      nextEvolution?.add(Evolution.fromJson(i));
    }
    prevEvolution = [];
    for (var i in json['Prev_evolution'] ?? []) {
      prevEvolution?.add(Evolution.fromJson(i));
    }
  }
}

class Evolution {
  String? number;
  String? name;
//constructor
  Evolution(this.number, this.name);
// Named constructor to convert the data type from json to object ..
  Evolution.fromJson(Map<String, dynamic> json) {
    number = json['num'];
    name = json['name'];
  }
// method to convert the data type from object to json ..
  Map<String, dynamic> toJson() {
    return {
      'num': number,
      'name': name,
    };
  }
}
