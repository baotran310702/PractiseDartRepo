import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsproject/models/news.dart';
import 'package:newsproject/services/news_repository.dart';
part 'news_events.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository dataNews;

  NewsBloc({required this.dataNews})
      : super((NewsLoadPage(currentPage: 1, isLoading: true, listNews: []))) {
    on<LoadPages>(_loadFirstPages);
  }

  void _loadpages(LoadPages event, Emitter<NewsState> emit) {
    state.currentPage = event.currentPage;
    state.isLoading = event.isLoading;

    emit(NewsLoadPage(
        currentPage: event.currentPage,
        isLoading: event.isLoading,
        listNews: event.listNews));
  }

  Future<void> _loadFirstPages(LoadPages event, Emitter<NewsState> emit) async {
    await dataNews.getNews(1);
  }
}
