
import 'package:cleanarchnews/features/daily_news/data/models/article.dart';
import 'package:floor/floor.dart';

@dao
abstract class ArticleDao {

  @insert
  Future<void> insertArticle(ArticleModel article);

  @delete
  Future<void> deleteArticle(ArticleModel article);

  @Query("SELECT * FROM article")
  Future<List<ArticleModel>> getArticles();
}