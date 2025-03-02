import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/local/local_article_state.dart';
import 'package:cleanarchnews/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class SavedArticles extends HookWidget{
  const SavedArticles({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(
          builder: (context) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => {
              context.push("/"),
            },
            child: const Icon(
              Ionicons.chevron_back, 
              color: Colors.black87,
            ),
          )
        ),
        title: const Text("Saved Articles"),
      ),

      body: BlocBuilder<LocalArticleBloc, LocalArticleState>(
        builder: (context, state) {
          if(state is LocalArticlesLoading) {
            return const Center(child: CupertinoActivityIndicator());
          } else if (state is LocalArticlesLoaded) {
            if(state.articles!.isEmpty){
              return const Center(
                child: Text(
                  'No Saved Articles',
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              );
            } else {
              return ListView.builder(
                itemCount: state.articles!.length,
                itemBuilder: (context, index) {
                  return ArticleWidget(
                    article: state.articles![index],
                    isRemovable: true,
                    onRemove: (article) {
                      context.read<LocalArticleBloc>().add(RemoveArticle(article));
                    },
                    onArticlePressed: (article) {
                      context.push("/articleDetails", extra: article);
                    }
                  );
                },
              );
            }
          }
          return Container();
        }
      ),
    );
  }
}