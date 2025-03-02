import 'package:cleanarchnews/features/daily_news/domain/entities/article.dart';
import 'package:equatable/equatable.dart';

abstract class LocalArticleState extends Equatable{
  final List<ArticleEntity> ? articles;

  const LocalArticleState({this.articles});
}

class LocalArticlesLoading extends LocalArticleState {
  const LocalArticlesLoading();
  
  @override
  List<Object?> get props => [];
}

class LocalArticlesLoaded extends LocalArticleState {
  const LocalArticlesLoaded(List<ArticleEntity> articles) : super(articles: articles);
  
  @override
  List<Object?> get props => [articles];
}