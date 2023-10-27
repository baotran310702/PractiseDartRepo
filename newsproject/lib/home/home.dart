import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsproject/bloc/news_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsproject/home/news/news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  void _scrollListener() {
    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      context.read<NewsBloc>().add(LoadMorePages());
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    print("Start Home Page");
    return Column(
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8),
          child: TextNews(),
        ),
        Expanded(
          child: Container(
            alignment: Alignment.topCenter,
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: BlocBuilder<NewsBloc, NewsState>(
              builder: (context, state) {
                if (state is NewsInitial) {
                  print("Init State");
                  if (state.isLoading == true) {
                    return const CircularProgressIndicator();
                  }
                }
                if (state is NewsLoadPage) {
                  print("Load Pages");
                  if (state.isLoading == true) {
                    return const CircularProgressIndicator();
                  }
                  if (state.listNews.isNotEmpty) {
                    print("Loading list...");
                    return ListView.builder(
                      controller: _controller,
                      itemCount: state.listNews.length + 1,
                      itemBuilder: (context, index) {
                        if (index < state.listNews.length) {
                          return NewsFeed(
                            title: state.listNews[index].title.toString(),
                            summary: state.listNews[index].summary.toString(),
                            modifiedAt:
                                state.listNews[index].modifiedAt.toString(),
                            image: state.listNews[index].image.toString(),
                          );
                        } else {
                          if (state.isLoading == true) {
                            return const Column(
                              children: [
                                CircularProgressIndicator(),
                                SizedBox(
                                    height:
                                        16), // Add some spacing between the list and the indicator
                              ],
                            );
                          }
                        }
                      },
                    );
                  }
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ),
      ],
    );
  }
}

class TextNews extends StatelessWidget {
  const TextNews({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(top: 12, bottom: 12),
      child: Text(
        "News",
        style: GoogleFonts.openSans(
          fontWeight: FontWeight.w600,
          fontSize: 14,
          color: const Color(0xff1D1A61),
        ),
      ),
    );
  }
}
