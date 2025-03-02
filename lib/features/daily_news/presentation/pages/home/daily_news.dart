import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/remote/remote_article_state.dart';
import 'package:cleanarchnews/features/daily_news/presentation/widgets/article_tile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class DailyNews extends StatelessWidget {
  const DailyNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Clean Arch Daily News"),
        actions: [
          GestureDetector(
            onTap: () => {
              context.push("/savedArticles"),
            },
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 3),
              child: Icon(Icons.bookmark, color: Colors.black87),
            ),
          )
        ],
      ),
      body: BlocBuilder<RemoteArticlesBloc, RemoteArticlesState>(
        builder: ( buildContext, state) {
          if(state is RemoteArticlesLoading) {
            return const Center(
              child: CupertinoActivityIndicator(),
            );
          } else if (state is RemoteArticlesError) {
            return const Center(
              child: Icon(Icons.refresh),
            );
          } else if (state is RemoteArticlesLoaded) {
            return ListView.builder(
              itemBuilder: (itemBuilderContext, index) {
                return ArticleWidget(
                  article: state.articles![index]
                );
              },
              itemCount: state.articles!.length,
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}