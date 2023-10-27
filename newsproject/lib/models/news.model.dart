import 'package:hive/hive.dart';

part 'news.model.g.dart';

@HiveType(typeId: 2) // You can use any positive integer, e.g., 2
class News {
  @HiveField(0)
  int? storyId;
  @HiveField(1)
  String? title;
  @HiveField(2)
  String? summary;
  @HiveField(3)
  String? modifiedAt;
  @HiveField(4)
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
