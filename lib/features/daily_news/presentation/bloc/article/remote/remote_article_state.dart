import 'package:cleanarchnews/features/daily_news/domain/entities/article.dart';
import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';

abstract class RemoteArticlesState extends Equatable{
  final List<ArticleEntity> ? articles;
  final DioException ? error;

  const RemoteArticlesState({this.articles, this.error});
}

class RemoteArticlesLoading extends RemoteArticlesState {
  
  const RemoteArticlesLoading();

  @override
  List<Object?> get props => [];
}

class RemoteArticlesLoaded extends RemoteArticlesState {
  
  const RemoteArticlesLoaded(List<ArticleEntity> articles) : super(articles: articles);

  @override
  List<Object?> get props => [articles];
}


class RemoteArticlesError extends RemoteArticlesState {
  
  const RemoteArticlesError(DioException error) : super(error: error);

  @override
  List<Object?> get props => [error];
}