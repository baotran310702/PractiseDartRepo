import 'package:dio/dio.dart';

class NewsRepository {
  final dio = Dio();

  String baseURl = "http://54.226.141.124/";

  Future<void> getNews(int page) async {
    print("Starting the process");

    String path = "${baseURl}intern/news?page=${page.toString()}";
    print("This is path ${path}");

    try {
      Response res = await dio.get(
        path,
      );
      if (res.statusCode == 200) {
        // Handle a successful response
      } else {
        // Handle non-200 status codes
        print("Error: ${res.statusCode} - ${res.statusMessage}");
      }
    } catch (e) {
      print("Error: $e");
    }
  }
}
