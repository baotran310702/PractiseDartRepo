part of 'news_bloc.dart';

abstract class NewsState {
  int currentPage;
  bool isLoading;
  List<dynamic> listNews;

  NewsState(
      {required this.currentPage,
      required this.isLoading,
      required this.listNews});
}

class NewsInitial extends NewsState {
  NewsInitial(
      {required int currentPage, required bool isLoading, required listNews})
      : super(
            currentPage: currentPage, isLoading: isLoading, listNews: listNews);
}

class NewsLoadPage extends NewsState {
  NewsLoadPage(
      {required int currentPage, required bool isLoading, required listNews})
      : super(
            currentPage: currentPage, isLoading: isLoading, listNews: listNews);
}
