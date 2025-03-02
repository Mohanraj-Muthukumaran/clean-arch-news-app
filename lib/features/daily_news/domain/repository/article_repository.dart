import 'package:cleanarchnews/core/resources/data_state.dart';
import 'package:cleanarchnews/features/daily_news/domain/entities/article.dart';

abstract class ArticleRepository {

  Future<DataState<List<ArticleEntity>>> getNewArticles();

  Future<List<ArticleEntity>> getSavedArticles();

  Future<void> saveArticle(ArticleEntity article);

  Future<void> removeArticle(ArticleEntity article); 

}