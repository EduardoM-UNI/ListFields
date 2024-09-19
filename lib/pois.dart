class Pois {
Pois({
    required this.list,
  });

  List<Lista> list;

  factory Pois.fromJson(Map<String, dynamic> json) => Pois(
        list: List<Lista>.from(
          json["list"].map((x) => Lista.fromJson(x)),
        ),
      );
}

class Lista {
  Lista({
    required this.id,
    required this.title,
    required this.geocoordinates,
    required this.image
  });

  String id;
  String title;
  String geocoordinates;
  String image;

  factory Lista.fromJson(Map<String, dynamic> json) => Lista(
        id: json["id"],
        title: json["title"],
        geocoordinates: json["geocoordinates"],
        image: json["image"],
      );
  
}
