import 'dart:io';

import 'package:cleanarchnews/core/constants/constants.dart';
import 'package:cleanarchnews/core/resources/data_state.dart';
import 'package:cleanarchnews/features/daily_news/data/datasources/local/app_database.dart';
import 'package:cleanarchnews/features/daily_news/data/datasources/remote/news_api_service.dart';
import 'package:cleanarchnews/features/daily_news/data/models/article.dart';
import 'package:cleanarchnews/features/daily_news/domain/entities/article.dart';
import 'package:cleanarchnews/features/daily_news/domain/repository/article_repository.dart';
import 'package:dio/dio.dart';

class ArticleRepositoryImpl implements ArticleRepository {
  final NewsApiService _newsApiService;
  final AppDatabase _appDatabase;

  ArticleRepositoryImpl(this._newsApiService, this._appDatabase);

  @override
  Future<DataState<List<ArticleEntity>>> getNewArticles() async {
    try {
      final httpResponse = await _newsApiService.getNewArticles(
        apiKey: newsAPIkey,
        country: newsCountry,
        category: newsCategory,
      );

      if(httpResponse.response.statusCode == HttpStatus.ok){
        return DataSuccess(httpResponse.data);
      } else {
        return DataFailed(
          DioException(
            error: httpResponse.response.statusMessage,
            response: httpResponse.response,
            requestOptions: httpResponse.response.requestOptions,
          )
        );
      }
    } on DioException catch (error) {
      return DataFailed(error);
    }
  }
  
  @override
  Future<List<ArticleModel>> getSavedArticles() async {
    return _appDatabase.articleDao.getArticles();
  }
  
  @override
  Future removeArticle(ArticleEntity article) {
    return _appDatabase.articleDao.deleteArticle(ArticleModel.fromEntity(article));
  }
  
  @override
  Future saveArticle(ArticleEntity article) {
    return _appDatabase.articleDao.insertArticle(ArticleModel.fromEntity(article));
  }
}

