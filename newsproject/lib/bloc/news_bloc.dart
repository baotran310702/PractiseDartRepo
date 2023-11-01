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
            (NewsState(currentPage: 1, isLoading: false, listNews: <News>[]))) {
    on<NewsEvent>(_loadPage, transformer: restartable());
  }

  //Handle event here
  Future<void> _loadPage(NewsEvent event, Emitter<NewsState> emit) async {
    //Create local first
    List<News> storageData = await _getDataLocal();

    if (state.isLoading == false) {
      List<News> listNews = await dataNews.getNews(state.currentPage!);
      if (event is LoadPages) {
        emit(
          NewsState(
              currentPage: state.currentPage,
              isLoading: true,
              listNews: state.listNews),
        );
      }
      if (event is ReloadPages) {
        emit(
          NewsState(
              currentPage: 1,
              isLoading: true,
              listNews: listNews.isNotEmpty ? listNews : storageData),
        );
      }
      print(state.currentPage);

      //Check if API is call successfully
      if (listNews.isEmpty) {
      } else {
        //Then clear the localStorage
        await _clearStorage();
        state.listNews!.addAll(listNews);
        await _addStorage(
            state.listNews!.length < 40 ? state.listNews! : <News>[]);
        state.currentPage = state.currentPage! + 1;
      }

      //Emit state listNews that if internet is call failed -> return the storage
      emit(NewsState(
          currentPage: state.currentPage,
          isLoading: false,
          listNews: listNews.isNotEmpty ? state.listNews : storageData));
    }
  }

  /*Handle Local Storage */
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
