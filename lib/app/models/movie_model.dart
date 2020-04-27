class MovieModel {
  final int id;
  final String title;
  final String imageUrl;

  MovieModel({
    this.id,
    this.title,
    this.imageUrl,
  });

  MovieModel.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        imageUrl = json['imageURl'];

  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'imageUrl': imageUrl,
      };
}
