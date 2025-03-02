import 'package:cleanarchnews/config/routes/app_routes.dart';
import 'package:cleanarchnews/config/themes/app_themes.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/local/local_article_bloc.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/local/local_article_event.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/remote/remote_article_bloc.dart';
import 'package:cleanarchnews/features/daily_news/presentation/bloc/article/remote/remote_article_event.dart';
import 'package:cleanarchnews/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await initialiseDependencies();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<RemoteArticlesBloc>(
          create: (blocContext) => serviceLocator()..add(const GetArticles()),
        ),
         BlocProvider<LocalArticleBloc>(
          create: (blocContext) => serviceLocator()..add(const GetSavedArticles()),
        ),
      ],
      child: MaterialApp.router(
        title: 'Flutter Demo',
        theme: theme(),
        routerConfig: router,
      ),
    );
  }
}
