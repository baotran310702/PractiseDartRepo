import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:newsproject/bloc/news_bloc.dart';
import 'package:newsproject/data/news_hive_store.dart';
import 'package:newsproject/models/news.model.dart';
import 'package:newsproject/views/home/home.dart';
import 'package:newsproject/services/news_repository.dart';
import 'views/home/appBar/app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

Future<void> main() async {
  //Initial Hive Storage
  await Hive.initFlutter();
  //Register Hive Adapter
  Hive.registerAdapter<News>(NewsAdapter());
  //Open box
  var box = await Hive.openBox<News>(NewsLocalStorage.boxName);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return RepositoryProvider(
      create: (context) => NewsRepository(),
      child: BlocProvider(
        create: (context) => NewsBloc(
          dataNews: RepositoryProvider.of<NewsRepository>(context),
        )..add(LoadPages()),
        child: const MaterialApp(
          title: "News App",
          debugShowCheckedModeBanner: false,
          home: Scaffold(
            appBar: AppBarCustom(),
            body: Stack(
              children: [
                HomePage(),
                Positioned(bottom: 20, right: 20, child: ScrollUpBtn())
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class ScrollUpBtn extends StatelessWidget {
  const ScrollUpBtn({super.key});

  @override
  Widget build(BuildContext context) {
    const String assetPath = "assets/scrollToTop.svg";
    final Widget newsSvg = SvgPicture.asset(assetPath, semanticsLabel: 'bars');

    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          color: const Color(0xff1D1A61),
          borderRadius: BorderRadius.circular(30.0)),
      child: Center(child: newsSvg),
    );
  }
}
