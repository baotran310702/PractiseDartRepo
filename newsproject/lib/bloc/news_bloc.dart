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
      : super(
            (NewsState(currentPage: 0, isLoading: false, listNews: <News>[]))) {
    on<LoadPages>(_loadPage, transformer: droppable());
    on<ReloadPages>(_reloadPages, transformer: restartable());
  }
  //Reload Pages when pull down the top

  Future<void> _reloadPages(ReloadPages event, Emitter<NewsState> emit) async {
    state.currentPage = 0;

    emit(NewsState(
        currentPage: state.currentPage,
        isLoading: true,
        listNews: state.listNews));

    List<News> listNews = await dataNews.getNews(state.currentPage! + 1);

    try {
      if (listNews.isEmpty) {
      } else {
        await _clearStorage();
        state.listNews!.clear();
        state.listNews!.addAll(listNews);
        await _addStorage(listNews);
      }
    } catch (e) {
      print(e.toString());
    }
    emit(NewsState(
        currentPage: state.currentPage! + 1,
        isLoading: false,
        listNews: state.listNews));
  }

  //Load first page is different load more pages because of first clear the Storage in Hive
  Future<void> _loadPage(LoadPages event, Emitter<NewsState> emit) async {
    print("Load page");
    print("current page ${state.currentPage}");
    emit(NewsState(
        currentPage: state.currentPage,
        isLoading: true,
        listNews: state.listNews));

    List<News> listNews = await dataNews.getNews(state.currentPage! + 1);
    List<News> storageData = await _getDataLocal();

    if (listNews.isEmpty) {
    } else {
      await _clearStorage();
      state.listNews!.addAll(listNews);
      state.currentPage = state.currentPage! + 1;
      await _addStorage(listNews);
    }
    emit(NewsState(
        currentPage: state.currentPage,
        isLoading: false,
        listNews: listNews.isNotEmpty ? state.listNews : storageData));
  }

  //get Data from Hive local
  Future<List<News>> _getDataLocal() async {
    NewsLocalStorage localStorage = NewsLocalStorage();
    List<News> listData = await localStorage.getNews();
    return listData;
  }

  //clear Data from Hive local
  Future<void> _clearStorage() async {
    NewsLocalStorage localStorage = NewsLocalStorage();
    localStorage.clearNews();
  }

  //add Data to Hive local
  Future<void> _addStorage(List<News> listNews) async {
    NewsLocalStorage localStorage = NewsLocalStorage();
    localStorage.addTask(listNews: listNews);
  }
}
