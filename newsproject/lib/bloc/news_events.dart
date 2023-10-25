part of 'news_bloc.dart';

abstract class NewsEvent {}

class LoadPages extends NewsEvent {
  final int currentPage;
  final bool isLoading = false;
  final List<dynamic> listNews;

  LoadPages({
    required this.listNews,
    required this.currentPage,
  });
}

class LoadPageSuccess extends NewsEvent {
  final int currentPage;
  final bool isLoading = true;
  final List<dynamic> listNews;

  LoadPageSuccess({
    required this.listNews,
    required this.currentPage,
  });
}
