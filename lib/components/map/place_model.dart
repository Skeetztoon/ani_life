class Place {
  String name;
  String place;
  List<double> coords;
  String link;
  String schedule;

  Place.fromMap(Map<String, dynamic> data)
      : name = data["name"]?? "",
        place = data["place"] ?? "",
        coords = data["coords"] != null ? List<double>.from(data["coords"]) : [],
        link = data["link"]?? "",
        schedule = data["schedule"]?? "";
}