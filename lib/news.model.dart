class News {
  List<dynamic> tags;
  String id;
  String title;
  String content;
  String author;
  String image;
  String url;
  String createdAt;
  String updatedAt;
  News({
    this.tags,
    this.id,
    this.title,
    this.content,
    this.author,
    this.image,
    this.url,
    this.createdAt,
    this.updatedAt,
  });

  factory News.fromJson(Map<String, dynamic> json) => News(
        tags: json["tags"] == null
            ? null
            : List<String>.from(json["tags"].map((x) => x)),
        id: json["_id"] == null ? null : json["_id"],
        title: json["title"] == null ? null : json["title"],
        content: json["content"] == null ? null : json["content"],
        author: json["author"] == null ? null : json["author"],
        image: json["image"] == null ? null : json["image"],
        url: json["url"] == null ? null : json["url"],
        createdAt: json["createdAt"] == null
            ? null
            : json["createdAt"],
        updatedAt: json["updatedAt"] == null
            ? null
            : json["updatedAt"],
      );
}
