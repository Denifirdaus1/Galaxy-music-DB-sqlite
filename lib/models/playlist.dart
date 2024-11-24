class Playlist {
  int? id;
  String name;
  List<int> songIds;

  Playlist({
    this.id,
    required this.name,
    this.songIds = const []
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'songIds': songIds.join(',')
    };
  }
}