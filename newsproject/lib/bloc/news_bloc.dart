import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsproject/models/news.dart';
import 'package:newsproject/services/news_repository.dart';

part 'news_events.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository dataNews;

  NewsBloc({required this.dataNews})
      : super((NewsLoadPage(
            currentPage: 1, isLoading: true, listNews: <News>[]))) {
    on<LoadPages>(_loadFirstPages);
    on<LoadMorePages>(_loadPages);
  }

  Future<void> _loadFirstPages(LoadPages event, Emitter<NewsState> emit) async {
    print("Loading the init state first");

    List<News> listNews = await dataNews.getNews(1);

    print("This is type of listNews returned, ${listNews.runtimeType}");

    emit(NewsLoadPage(currentPage: 1, isLoading: false, listNews: listNews));
  }

  Future<void> _loadPages(LoadMorePages event, Emitter<NewsState> emit) async {
    print("start loading more page");
  }
}
