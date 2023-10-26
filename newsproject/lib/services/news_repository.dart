import 'package:dio/dio.dart';
import 'package:newsproject/models/news.dart';

class NewsRepository {
  final dio = Dio();

  String baseURl = "http://localhost:5249/";

  Future<List<News>> getNews(int page) async {
    print("Starting the process");

    // String path = "${baseURl}intern/news?page=${page.toString()}";
    String path = "${baseURl}api/WeatherForecast";
    print("This is path ${path}");

    try {
      Response res = await dio.get(
        path,
      );
      if (res.statusCode == 200) {
        //convert dynamic to News type

        List<News> listNews = [];
        int length = res.data.length;
        for (int i = 0; i < length; i++) {
          News currentNews = News.fromJson(res.data[i]);
          listNews.add(currentNews);
        }

        return listNews;
      } else {
        // Handle non-200 status codes
        print("Error: ${res.statusCode} - ${res.statusMessage}");
        return [];
      }
    } catch (e) {
      print("Error: $e");
      return [];
    }
  }
}
