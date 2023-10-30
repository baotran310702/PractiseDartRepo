import 'package:flutter/foundation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsproject/models/news.model.dart';
import 'dart:math';

class NewsLocalStorage {
  static const boxName = 'NewsBox';

  final Box<News> boxNews = Hive.box<News>(boxName);

  //Add new story
  Future<void> addTask({required List<News> listNews}) async {
    int lenList = listNews.length;
    Random random = Random();
    for (int i = 0; i < lenList; i++) {
      await boxNews.put(random.nextInt(100001), listNews[i]);
    }
  }

  //Get News
  Future<List<News>> getNews() async {
    var values = boxNews.values.toList();
    return values;
  }

  //clear News
  Future<void> clearNews() async {
    await boxNews.clear();
  }

  //Handle anyevent if need
  ValueListenable<Box<News>> listenToTask() {
    return boxNews.listenable();
  }
}
