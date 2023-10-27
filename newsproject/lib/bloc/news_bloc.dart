import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:newsproject/data/news_hive_store.dart';
import 'package:newsproject/models/news.model.dart';
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

  //Load first page is different load more pages because of first clear the Storage in Hive
  Future<void> _loadFirstPages(LoadPages event, Emitter<NewsState> emit) async {
    List<News> listNews = await dataNews.getNews(1);

    if (listNews.isEmpty) {
      List<News> storageData = await _getDataLocal();
      state.listNews.addAll(storageData);
      state.currentPage = 1;
    } else {
      await _clearStorage();
      state.listNews.addAll(listNews);
      await _addStorage(listNews);
      state.currentPage = state.currentPage + 1;
    }

    emit(NewsLoadPage(
        currentPage: state.currentPage,
        isLoading: false,
        listNews: state.listNews));
  }

  Future<void> _loadMorePages(
      LoadMorePages event, Emitter<NewsState> emit) async {
    List<News> listNewsMore = await dataNews.getNews(state.currentPage);

    if (listNewsMore.isEmpty) {
      state.currentPage = 1;
    } else {
      state.listNews.addAll(listNewsMore);
      await _addStorage(listNewsMore);
      state.currentPage = state.currentPage + 1;
    }

    emit(NewsLoadPage(
        currentPage: state.currentPage,
        isLoading: false,
        listNews: state.listNews));
  }

  Future<List<News>> _getDataLocal() async {
    NewsLocalStorage localStorage = NewsLocalStorage();
    List<News> listData = await localStorage.getNews();
    return listData;
  }

  Future<void> _clearStorage() async {
    NewsLocalStorage localStorage = NewsLocalStorage();
    localStorage.clearNews();
  }

  Future<void> _addStorage(List<News> listNews) async {
    NewsLocalStorage localStorage = NewsLocalStorage();
    localStorage.addTask(listNews: listNews);
  }
}
