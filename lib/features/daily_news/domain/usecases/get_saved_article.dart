import 'package:cleanarchnews/core/usecase/usecase.dart';
import 'package:cleanarchnews/features/daily_news/domain/entities/article.dart';
import 'package:cleanarchnews/features/daily_news/domain/repository/article_repository.dart';

class GetSavedArticleUseCase implements Usecase<List<ArticleEntity>, void>{
  final ArticleRepository _articleRepository;

  GetSavedArticleUseCase(this._articleRepository);
  
  @override
  Future<List<ArticleEntity>> call({void params}) {
    return _articleRepository.getSavedArticles();
  }  
}