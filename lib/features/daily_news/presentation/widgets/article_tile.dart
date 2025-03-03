import 'package:cached_network_image/cached_network_image.dart';
import 'package:cleanarchnews/features/daily_news/domain/entities/article.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ArticleWidget extends StatelessWidget {
  final ArticleEntity? article;
  final bool? isRemovable;
  final Function(ArticleEntity article) ? onRemove;
  final Function(ArticleEntity article) ? onArticlePressed;

  const ArticleWidget({super.key, this.article, this.isRemovable, this.onRemove, this.onArticlePressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsetsDirectional.only(start: 14, end: 14, bottom: 14),
      height: MediaQuery.of(context).size.width / 2.2,
      child: GestureDetector(
        onTap: () => _onArticlePressed(context, article!),
        child: Row(
          children: [
            // image
            CachedNetworkImage(
              imageUrl: article!.urlToImage ?? "",
              imageBuilder: (context, imageProvider) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              progressIndicatorBuilder: (context, url, progress) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                    ),
                    child: const CupertinoActivityIndicator(),
                  ),
                ),
              ),
              errorWidget: (context, url, error) => Padding(
                padding: const EdgeInsetsDirectional.only(end: 14),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Container(
                    width: MediaQuery.of(context).size.width / 3,
                    height: double.maxFinite,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.08),
                    ),
                    child: const Icon(Icons.error),
                  ),
                ),
              ),
            ),
        
            // title, description and time
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 7),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      article!.title ?? "",
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontFamily: 'Butler',
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                        color: Colors.black87,
                      ),
                    ),
        
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 4),
                        child: Text(
                          article!.description ?? "",
                          maxLines: 2,
                        ),
                      )
                    ),
        
                    Row(
                      children: [
                        const Icon(
                          Icons.timeline_outlined, 
                          size: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          article!.publishedAt ?? "",
                          style: const TextStyle(
                            fontSize: 12,
                          ),  
                        )
                      ],
                    )
                  ],
                ),
              )
            ),
          
            if(isRemovable == true) 
            Center(
              child: IconButton(
                onPressed: () => {
                  onRemove!(article!),
                }, 
                icon: const Icon(Icons.remove_circle_outline),
                color: Colors.redAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _onArticlePressed(BuildContext context, ArticleEntity article) {
    context.push("/articleDetails", extra: article);
  }
}