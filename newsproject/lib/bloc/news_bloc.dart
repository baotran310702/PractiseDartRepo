import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsproject/models/news.dart';
import 'package:newsproject/services/news_repository.dart';

part 'news_events.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository dataNews;

  NewsBloc({required this.dataNews})
      : super((NewsInitial(
            currentPage: 1, isLoading: false, listNews: <News>[]))) {
    on<LoadPages>(_loadFirstPages);
    on<LoadMorePages>(_loadMorePages);
  }

  Future<void> _loadFirstPages(LoadPages event, Emitter<NewsState> emit) async {
    List<News> listNews = await dataNews.getNews(state.currentPage);
    state.listNews.addAll(listNews);
    state.currentPage = state.currentPage + 1;

    emit(NewsLoadPage(
        currentPage: state.currentPage,
        isLoading: false,
        listNews: state.listNews));
  }

  Future<void> _loadMorePages(
      LoadMorePages event, Emitter<NewsState> emit) async {
    List<News> listNewsMore = await dataNews.getNews(state.currentPage);

    state.listNews.addAll(listNewsMore);
    state.currentPage = state.currentPage + 1;

    emit(NewsLoadPage(
        currentPage: state.currentPage,
        isLoading: false,
        listNews: state.listNews));
  }
}
