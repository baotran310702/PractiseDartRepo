part of 'news_bloc.dart';

class NewsState {
  int? currentPage;
  bool isLoading;
  List<News>? listNews;

  NewsState({this.currentPage, required this.isLoading, this.listNews});
}
