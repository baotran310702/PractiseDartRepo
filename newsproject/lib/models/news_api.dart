import 'news.model.dart';

abstract class NewsAPI {
  int? currentPage;
  List<News>? allResult;

  NewsAPI({this.currentPage, this.allResult});
}
