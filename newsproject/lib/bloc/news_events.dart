part of 'news_bloc.dart';

abstract class NewsEvent {}

class LoadPages extends NewsEvent {
  final int currentPage;
  final bool isLoading = true;
  final List<News> listNews;

  LoadPages({
    required this.listNews,
    required this.currentPage,
  });
}

class LoadMorePages extends NewsEvent {
  final int currentPage;
  final List<News> listNews;
  final bool isLoading = false;

  LoadMorePages({
    required this.listNews,
    required this.currentPage,
  });
}

class LoadingProgress extends NewsEvent {
  final isLoading = true;
  LoadingProgress();
}
