class AlbumModel {
  final int userId;
  final int id;
  final String title;

  AlbumModel({
    required this.userId,
    required this.id,
    required this.title,
  });

  AlbumModel.fromJson(Map<String, dynamic> json)
      : userId = json['userId'],
        id = json['id'],
        title = json['title'];
}