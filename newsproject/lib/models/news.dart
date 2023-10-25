class News {
  int? storyId;
  String? title;
  String? summary;
  String? modifiedAt;
  String? image;

  News({this.storyId, this.title, this.summary, this.modifiedAt, this.image});

  News.fromJson(Map<String, dynamic> json) {
    storyId = json['storyId'];
    title = json['title'];
    summary = json['summary'];
    modifiedAt = json['modifiedAt'];
    image = json['image'];
  }
}
