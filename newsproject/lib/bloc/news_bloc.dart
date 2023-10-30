import 'dart:async';
import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsproject/data/news_hive_store.dart';
import 'package:newsproject/models/news.model.dart';
import 'package:newsproject/services/news_repository.dart';

part 'news_events.dart';
part 'news_state.dart';

class NewsBloc extends Bloc<NewsEvent, NewsState> {
  final NewsRepository dataNews;

  NewsBloc({required this.dataNews})
      : super((NewsInitial(
            currentPage: 0, isLoading: false, listNews: <News>[]))) {
    on<LoadPages>(_loadFirstPages);
    on<LoadMorePages>(_loadMorePages);
    on<ReloadPages>(_reloadPages, transformer: restartable());
  }

  //Reload Pages when pull down the top

  Future<void> _reloadPages(ReloadPages event, Emitter<NewsState> emit) async {
    List<News> listNews = await dataNews.getNews(1);

    try {
      if (listNews.isEmpty) {
      } else {
        await _clearStorage();
        state.listNews.clear();
        state.listNews.addAll(listNews);
        await _addStorage(listNews);
        state.currentPage = 1;

        print("Page loaded");
      }
    } catch (e) {
      print("An exception occur");
    }
    emit(NewsLoadPage(
        currentPage: state.currentPage,
        isLoading: false,
        listNews: state.listNews));
  }

  //Load first page is different load more pages because of first clear the Storage in Hive
  Future<void> _loadFirstPages(LoadPages event, Emitter<NewsState> emit) async {
    print("First page is inited");

    List<News> listNews = await dataNews.getNews(state.currentPage + 1);
    List<News> storageData = await _getDataLocal();

    if (listNews.isEmpty) {
      state.listNews.addAll(storageData);
      print(state.currentPage);
      print(storageData.length.toString());
    } else {
      await _clearStorage();
      state.listNews.clear();
      state.listNews.addAll(listNews);
      await _addStorage(listNews);
      state.currentPage = state.currentPage + 1;
      print(state.currentPage);
    }

    emit(NewsLoadPage(
        currentPage: state.currentPage,
        isLoading: false,
        listNews: state.listNews));
  }

  Future<void> _loadMorePages(
      LoadMorePages event, Emitter<NewsState> emit) async {
    print("Load more pages is called");

    List<News> listNewsMore = await dataNews.getNews(state.currentPage + 1);

    if (listNewsMore.isEmpty) {
      // state.currentPage = 1;
      print(state.currentPage);
    } else {
      state.listNews.addAll(listNewsMore);
      await _addStorage(listNewsMore);
      state.currentPage = state.currentPage + 1;
      print(state.currentPage);
      List<News> storageData1 = await _getDataLocal();
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
