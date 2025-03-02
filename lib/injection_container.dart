import 'package:cleanarchnews/features/daily_news/data/datasources/local/app_database.dart';
import 'package:cleanarchnews/features/daily_news/data/datasources/remote/news_api_service.dart';
import 'package:cleanarchnews/features/daily_news/data/repository/article_repository.dart';
import 'package:cleanarchnews/features/daily_news/domain/repository/article_repository.dart';
import 'package:cleanarchnews/features/daily_news/domain/usecases/get_article.dart';
import 'package:cleanarchnews/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:cleanarchnews/features/daily_news/domain/usecases/remove_article.dart';
import 'package:cleanarchnews/features/daily_news/domain/usecases/save_article.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.instance;

Future<void> initialiseDependencies() async {

  // Database
  final database = await $FloorAppDatabase.databaseBuilder('app_database.db').build();
  serviceLocator.registerSingleton<AppDatabase>(database);
  // Dio
  serviceLocator.registerSingleton<Dio>(Dio());
  // Api Service
  serviceLocator.registerSingleton<NewsApiService>(NewsApiService(serviceLocator()));
  // Repository
  serviceLocator.registerSingleton<ArticleRepository>(ArticleRepositoryImpl(serviceLocator(), serviceLocator()));
  // Usecases
  serviceLocator.registerSingleton<GetArticleUsecase>(GetArticleUsecase(serviceLocator()));
  serviceLocator.registerSingleton<GetSavedArticleUseCase>(GetSavedArticleUseCase(serviceLocator()));
  serviceLocator.registerSingleton<RemoveArticleUseCase>(RemoveArticleUseCase(serviceLocator()));
  serviceLocator.registerSingleton<SaveArticleUseCase>(SaveArticleUseCase(serviceLocator()));
  // blocs
  serviceLocator.registerSingleton<RemoteArticlesBloc>(RemoteArticlesBloc(serviceLocator()));
  serviceLocator.registerSingleton<LocalArticleBloc>(LocalArticleBloc(serviceLocator(), serviceLocator(), serviceLocator()));
}