class GeoModel {
  final double lat;
  final double lng;

  GeoModel({
    required this.lat,
    required this.lng,
  });

  GeoModel.fromJson(Map<String, dynamic> json)
      : lat = double.parse(json['lat']),
        lng = double.parse(json['lng']);
}
