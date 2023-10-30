part of 'news_bloc.dart';

abstract class NewsEvent {}

class LoadPages extends NewsEvent {
  LoadPages();
}

class LoadMorePages extends NewsEvent {
  LoadMorePages();
}

class ReloadPages extends NewsEvent {
  ReloadPages();
}
