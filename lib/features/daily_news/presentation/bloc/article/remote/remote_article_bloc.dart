import 'package:cleanarchnews/core/resources/data_state.dart';
import 'package:cleanarchnews/features/daily_news/domain/usecases/get_article.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoteArticlesBloc extends Bloc<RemoteArticlesEvent, RemoteArticlesState>{
  final GetArticleUsecase _getArticleUsecase;

  RemoteArticlesBloc(this._getArticleUsecase) : super(const RemoteArticlesLoading()) {
    on<GetArticles>(onGetArticles);
  }


  void onGetArticles(GetArticles event, Emitter<RemoteArticlesState> emit) async {
    final DataState dataState = await _getArticleUsecase();

    if(dataState is DataSuccess && dataState.data!.isNotEmpty) {
      emit(
        RemoteArticlesLoaded(dataState.data!)
      );
    } else if (dataState is DataFailed) {
      emit(
        RemoteArticlesError(dataState.error!)
      );
    }
  }
  
}