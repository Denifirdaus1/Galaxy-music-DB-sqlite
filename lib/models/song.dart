class Song {
  int? id;
  String title;
  String artistName;
  String genre;
  String filePath;
  String coverPath;
  bool isLiked;
  
  Song({
    this.id,
    required this.title,
    required this.artistName,
    required this.genre,
    required this.filePath,
    required this.coverPath,
    this.isLiked = false
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'artistName': artistName,
      'genre': genre,
      'filePath': filePath,
      'coverPath': coverPath,
      'isLiked': isLiked ? 1 : 0
    };
  }
}