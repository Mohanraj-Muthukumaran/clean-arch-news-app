import 'package:cleanarchnews/features/daily_news/domain/entities/article.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';

class ArticleDetailsView extends HookWidget {
  final ArticleEntity ? article;

  const ArticleDetailsView({super.key, this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // App Bar
      appBar: AppBar(
        leading: Builder(
          builder: (context) => GestureDetector(
            behavior: HitTestBehavior.opaque,
            onTap: () => {
              context.pop(),
            },
            child: const Icon(
              Ionicons.chevron_back, 
              color: Colors.black87,
            ),
          )
        ),
      ),

      // body
      body: SingleChildScrollView(
        child: Column(
          children: [
            // title and Date
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title
                  Text(
                    article!.title!,
                    style: const TextStyle(
                      fontFamily: 'Butler',
                      fontSize: 26,
                    ),
                  ),

                  const SizedBox(height: 14,),

                  // DateTime
                  Row(
                    children: [
                      const Icon(
                        Ionicons.time_outline,
                        size: 16,
                      ),
                      const SizedBox(width:  4),
                      Text(
                        article!.publishedAt!,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  )
                ],
              ),
            ),

            // article image
            Container(
              width: double.maxFinite,
              height: 250,
              margin: const EdgeInsets.only(top: 14),
              child: Image.network(
                article!.urlToImage!,
                fit: BoxFit.cover,
              ),
            ),

            // article description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 3),
              child: Text(
                "${article!.description ?? ''} \n\n ${article!.content ?? ''}",
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
            )
          ],
        ),
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: () => {
            context.read<LocalArticleBloc>().add(SaveArticle(article!)),
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Article saved successfully!'),
              ),
            ),
          },
          child: const Icon(
            Ionicons.bookmark, 
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}