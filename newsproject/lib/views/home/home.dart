import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsproject/bloc/news_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsproject/views/home/news/news.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final ScrollController _controller = ScrollController();

  void _scrollListener() {
    if (_controller.position.pixels == 0.0) {
      context.read<NewsBloc>().add(ReloadPages());
    }

    if (_controller.position.pixels == _controller.position.maxScrollExtent) {
      context.read<NewsBloc>().add(LoadPages());
    }
  }

  @override
  void initState() {
    super.initState();
    _controller.addListener(_scrollListener);
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
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
                  //Check if list is empty or not
                  if (state.listNews!.isNotEmpty) {
                    return ListView.builder(
                      controller: _controller,
                      //Length + 1 to add a CircleProgress at the last of List
                      itemCount: state.listNews!.length + 1,
                      itemBuilder: (context, index) {
                        if (index < state.listNews!.length) {
                          return NewsFeed(
                            title: state.listNews![index].title.toString(),
                            summary: state.listNews![index].summary.toString(),
                            modifiedAt:
                                state.listNews![index].modifiedAt.toString(),
                            image: state.listNews![index].image.toString(),
                          );
                        } else {
                          if (state.isLoading == true) {
                            return const Column(
                              children: [
                                // Add some spacing between the list and the indicator
                                SizedBox(height: 16),
                                CircularProgressIndicator(),
                                // Add some spacing between the list and the indicator
                                SizedBox(height: 16),
                              ],
                            );
                          }
                          return null;
                        }
                      },
                    );
                  } else {}
                  return const CircularProgressIndicator();
                },
              ),
            ),
          ),
        ],
      ),
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
