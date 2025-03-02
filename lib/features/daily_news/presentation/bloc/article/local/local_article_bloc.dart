import 'package:cleanarchnews/features/daily_news/domain/usecases/get_saved_article.dart';
import 'package:cleanarchnews/features/daily_news/domain/usecases/remove_article.dart';
import 'package:cleanarchnews/features/daily_news/domain/usecases/save_article.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocalArticleBloc extends Bloc<LocalArticlesEvent, LocalArticleState>{
  final GetSavedArticleUseCase _getSavedArticlesUseCase;
  final RemoveArticleUseCase _removeArticleUseCase;
  final SaveArticleUseCase _saveArticleUseCase;
  
  LocalArticleBloc(
    this._getSavedArticlesUseCase, 
    this._removeArticleUseCase, 
    this._saveArticleUseCase
  ) : super(const LocalArticlesLoading()) {
    on <GetSavedArticles> (onGetSavedArticles);
    on <RemoveArticle> (onRemoveArticle);
    on <SaveArticle> (onSaveArticle);
  }

  void onGetSavedArticles(GetSavedArticles event, Emitter<LocalArticleState> emit) async {
    final articles = await _getSavedArticlesUseCase();
    emit(
      LocalArticlesLoaded(articles)
    );
  }

  void onRemoveArticle(RemoveArticle removeArticle, Emitter<LocalArticleState> emit) async {
    await _removeArticleUseCase(params: removeArticle.article);

    final articles = await _getSavedArticlesUseCase();
     emit(
      LocalArticlesLoaded(articles)
    );
  }

  void onSaveArticle(SaveArticle saveArticle, Emitter<LocalArticleState> emit) async {
    await _saveArticleUseCase(params: saveArticle.article);

    final articles = await _getSavedArticlesUseCase();
     emit(
      LocalArticlesLoaded(articles)
    );
  }
}