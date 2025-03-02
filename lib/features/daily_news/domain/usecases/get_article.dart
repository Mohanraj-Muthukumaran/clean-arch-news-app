import 'package:cleanarchnews/core/resources/data_state.dart';
import 'package:cleanarchnews/core/usecase/usecase.dart';
import 'package:cleanarchnews/features/daily_news/domain/entities/article.dart';
import 'package:cleanarchnews/features/daily_news/domain/repository/article_repository.dart';

class GetArticleUsecase implements Usecase<DataState<List<ArticleEntity>>, void> {
  
  final ArticleRepository _articleRepository;

  GetArticleUsecase(this._articleRepository);

  @override
  Future<DataState<List<ArticleEntity>>> call({void params}) {
    return _articleRepository.getNewArticles();
  }
}