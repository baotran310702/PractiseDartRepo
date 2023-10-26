part of 'news_bloc.dart';

abstract class NewsState {
  int currentPage;
  bool isLoading;
  List<News> listNews;

  NewsState(
      {required this.currentPage,
      required this.isLoading,
      required this.listNews});
}

class NewsInitial extends NewsState {
  NewsInitial(
      {required int currentPage,
      required bool isLoading,
      required List<News> listNews})
      : super(
            currentPage: currentPage, isLoading: isLoading, listNews: listNews);
}

class NewsLoadPage extends NewsState {
  NewsLoadPage(
      {required int currentPage,
      required bool isLoading,
      required List<News> listNews})
      : super(
            currentPage: currentPage, isLoading: isLoading, listNews: listNews);
}

class NewsLoading extends NewsState {
  NewsLoading(
      {required int currentPage,
      required bool isLoading,
      required List<News> listNews})
      : super(
            currentPage: currentPage, isLoading: isLoading, listNews: listNews);
}

class NewsLoaded extends NewsState {
  NewsLoaded(
      {required int currentPage,
      required bool isLoading,
      required List<News> listNews})
      : super(
            currentPage: currentPage, isLoading: isLoading, listNews: listNews);
}
