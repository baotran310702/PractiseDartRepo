import 'dart:io';
import 'package:dio/dio.dart';
import 'package:cleanachirtecture/core/constants/constants.dart';
import 'package:cleanachirtecture/core/errors/data_state.dart';
import 'package:cleanachirtecture/features/daily_news/data/data_sources/remote/news_api_services.dart';
import 'package:cleanachirtecture/features/daily_news/data/models/article.dart';
import 'package:cleanachirtecture/features/daily_news/domain/repositories/article_repositories.dart';
import 'package:retrofit/retrofit.dart';

class ArticleRepositoriesImpl implements ArticleRepositories {
  final NewsApiService _newsApiServices;
  ArticleRepositoriesImpl(this._newsApiServices);

  @override
  Future<DataState<List<ArticleModel>>> getNewsArticles() async {
    final httpResponse = await _newsApiServices.getNewsArticles(
      apiKey: newsAPIKey,
      country: countryQuery,
      category: categoryQuery,
    );

    if (httpResponse.response.statusCode == HttpStatus.ok) {
      return DataSucess(httpResponse.data);
    } else {
      return DataFailed(DioException.badResponse(
          statusCode: httpResponse.response.statusMessage as int,
          requestOptions: DioExceptionType.badResponse as RequestOptions,
          response: httpResponse.response));
    }
  }
}
