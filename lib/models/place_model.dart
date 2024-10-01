class PlaceModel {
  PlaceModel({
    required this.id,
    required this.name,
    required this.image,
    required this.coverImage,
    required this.type,
    required this.description,
    required this.address,
    required this.latitude, required this.longitude,
  });

  final String id;
  final String name;
  final String image;
  final String coverImage;
  final List<String> type;
  final String description;
  final String address;
  final double latitude;
  final double longitude;

  factory PlaceModel.fromJson(Map<String, dynamic> json) {
    return PlaceModel(
      id: json['_id'],
      name: json['name'],
      image: json['image'],
      coverImage: json['coverImage'],
      type: List<String>.from(json['type']),
      description: json['description'],
      address: json['address'],
      latitude: json['latitude'],
      longitude: json['longitude'],
    );
  }
}
