import 'package:cleanarchnews/core/usecase/usecase.dart';
import 'package:cleanarchnews/features/daily_news/domain/entities/article.dart';
import 'package:cleanarchnews/features/daily_news/domain/repository/article_repository.dart';

class SaveArticleUseCase implements Usecase<void, ArticleEntity>{
  final ArticleRepository _articleRepository;

  SaveArticleUseCase(this._articleRepository);
  
  @override
  Future<void> call({ArticleEntity ? params}) {
    return _articleRepository.saveArticle(params!);
  }  
}