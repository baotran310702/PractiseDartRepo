import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsproject/bloc/news_bloc.dart';
import 'package:newsproject/home/home.dart';
import 'package:newsproject/services/news_repository.dart';
import 'home/appBar/app_bar.dart';
import 'package:flutter_svg/flutter_svg.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    print("Start component");
    return RepositoryProvider(
      create: (context) => NewsRepository(),
      child: BlocProvider(
        create: (context) => NewsBloc(
          dataNews: RepositoryProvider.of<NewsRepository>(context),
        )..add(LoadPages(listNews: [], currentPage: 1)),
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
