part of 'news_bloc.dart';

abstract class NewsEvent {}

class LoadPages extends NewsEvent {
  LoadPages();
}

class ReloadPages extends NewsEvent {
  ReloadPages();
}
