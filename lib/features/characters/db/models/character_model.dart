class CharacterModel {
  int id;
  String name;
  String status;
  String species;
  String gender;
  String image;
  String? firstSeenEpisode;

  CharacterModel({
    required this.id,
    required this.name,
    required this.status,
    required this.species,
    required this.gender,
    required this.image,
    this.firstSeenEpisode,
  });

  factory CharacterModel.fromJson(Map<String, dynamic> json) {
    return CharacterModel(
      id: json['id'] ?? 0,
      name: json['name'] ?? 'Unknown',
      status: json['status'] ?? 'Unknown',
      species: json['species'] ?? 'Unknown',
      gender: json['gender'] ?? 'Unknown',
      image: json['image'] ?? '',
      // The firstSeenEpisode field will be set in the repository after the additional API call
    );
  }
}
