class Location {
  final String city;
  final double long;
  final double lat;
  final int count;

  Location({
    required this.city,
    required this.long,
    required this.lat,
    required this.count,
  });
  factory Location.fromJson(dynamic json) {
    return Location(
      city: json['locate'],
      long: double.parse(json['X']),
      lat: double.parse(json['Y']),
      count: int.parse(json['count']),
    );
  }
}
