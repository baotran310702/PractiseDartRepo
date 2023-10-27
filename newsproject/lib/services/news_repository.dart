import 'package:dio/dio.dart';
import 'package:newsproject/bloc/news_bloc.dart';
import 'package:newsproject/models/news.model.dart';

class NewsRepository {
  final dio = Dio();

  String baseURl = "http://localhost:5249/";

  Future<List<News>> getNews(int page) async {
    // String path = "${baseURl}intern/news?page=${page.toString()}";
    String path = "${baseURl}api/WeatherForecast";

    try {
      Response res = await dio.get(path);
      if (res.statusCode == 200) {
        List<News> listNews = [];
        int length = res.data.length;
        for (int i = 0; i < length; i++) {
          News currentNews = News.fromJson(res.data[i]);
          listNews.add(currentNews);
        }

        return listNews;
      } else {
        // Handle non-200 status codes
        return [];
      }
    } catch (e) {
      return [];
    }
  }
}
