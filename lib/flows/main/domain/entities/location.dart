class Location {
  final double lat;
  final double lon;
  final String streetName;
  final String buildingNumber;
  final String? floorNumber;
  final String? doorNumber;
  final String? comment;

  Location({
    required this.lat,
    required this.lon,
    required this.streetName,
    required this.buildingNumber,
    this.floorNumber,
    this.doorNumber,
    this.comment,
  });
}
