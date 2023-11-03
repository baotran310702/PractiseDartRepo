import 'package:cleanachirtecture/core/errors/data_state.dart';
import 'package:cleanachirtecture/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepositories {
  Future<DataState<List<ArticleEntity>>> getNewsArticles();
}
